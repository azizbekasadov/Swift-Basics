import Foundation

//An important role of any memory management system is managing object lifetimes, in particular ensuring that memory is not deallocated too soon or too late.
//Swift uses reference counting to manage object lifetimes.

// MARK: Memory Allocation
// - Value types
//The allocation and deallocation of memory for value types – enumerations and structures – is handled for you. When you create a variable to store an instance of a value type, an appropriate amount of memory is automatically set aside for your instance, and your variable contains the entire value. Anything you do to pass the instance around, including passing it to a function and storing it in a property, creates a copy of the instance.
//When a variable containing a value type instance is destroyed, such as when a function that creates one returns, Swift reclaims the memory that was occupied by the instance. Each copy lives an independent lifetime and is automatically destroyed when the variable holding it goes away. You do not have to do anything to manage the memory of value types.

// - Reference types
//When you create a new class instance, memory is allocated for the instance to use, just as it is for value types. The difference is in what happens when you pass the class instance around.
//NB: passing a class instance to a function or storing it in a property creates an additional reference to the same memory, rather than copying the instance itself.
//Having multiple references to the same memory means that when any one of them changes the class instance, that change is apparent through any of its references.
//When should a class instance deallocate? The answer is: when all the references to it are gone. Every class instance knows its reference count: the number of existing references to the instance. The instance remains allocated as long as its reference count is greater than 0.
//When the last reference to an instance is destroyed and the instance’s reference count becomes 0, the system deallocates the instance and runs its deinit method.
//The Swift compiler handles incrementing and decrementing instance reference counts so that you do not have to. This Automatic Reference Counting (ARC) feature helps ensure that class instances are destroyed at the correct time. However, logic errors in your program can cause objects to not deallocate when you are done with them. This is called a memory leak

// MARK: Strong Reference Cycles
//To start, you will define the types you will be interacting with: Vault and Asset. You will create one vault and multiple assets to put into the vault, and then you will observe how your code affects their lifetimes.

class Vault {
    let number: Int
    private(set) var assets = [Asset]()
    
    init(number: Int) {
        self.number = number
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
    
    func store(_ asset: Asset) {
        asset.container = self
        assets.append(asset)
    }
}

extension Vault: CustomStringConvertible {
    var description: String {
        return "Vault(\(number))"
    }
}

class Asset {
    let name: String
    let value: Double
    var container: Vault?
    
    init(name: String, value: Double) {
        self.name = name
        self.value = value
    }
    deinit {
        print("\(self) is being deallocated")
    }
}

extension Asset: CustomStringConvertible {
    var description: String {
        if let container = container {
            return "Asset(\(name), worth \(value), in \(container))"
        } else {
            return "Asset(\(name), worth \(value), not stored anywhere)"
        }
    }
}

class Simulation {
    func run() {
        let vault13 = Vault(number: 13)
        print("Created \(vault13)")
        let coin: Asset = Asset(name: "Rare Coin", value: 1_000.0)
        let gem: Asset = Asset(name: "Big Diamond", value: 5_000.0)
        let poem: Asset = Asset(name: "Magnum Opus", value: 0.0)
        vault13.store(coin)
        vault13.store(gem)
//        You have created two strong reference cycles, which is the term for when two instances have strong references to each other.
        print("Created some assets: \([coin, gem, poem])")
    }
}
let simulation = Simulation()
simulation.run()
dispatchMain()

//The run() method of the Simulation class is where all your experimentation will happen. You might be wondering why you are using this method, instead of just working at the top level of main.swift, like you did with MonsterTown.
//You did this for two reasons: First, to define a scope, which you first learned about in Chapter 12 on functions. Scopes, as you might recall, are defined by pairs of braces ({ }). Functions and closures, conditionals, loops, and do/catch blocks all define scopes where their work is done.
func handle<T: Identifiable>(value: T) {
    // ...
}

func handle1(value: some Identifiable) {
    // ...
}
//Variables defined inside a scope (such as vault13, defined within run()’s scope) are reclaimed when that scope ends at the }. If the variable contained a value type instance, the end of the enclosing scope is where the instance is deallocated. If the variable contained a reference, the end of the enclosing scope is where the instance’s reference count is decremented, possibly leading to its deallocation.
//Instances that deallocate at the end of a program, on the other hand, do not execute their deinitializers. They do not need to; all the application’s memory is being reclaimed anyway. So an instance method of a class, like Simulation’s run() method, provides an observable scope where you can model the memory management issues that can plague more complicated apps.
//By default, all references that you create are strong references, which means they increment the reference count of the instance they refer to for the duration of the existence of the reference
//Xcode has several built-in tools that you can use to try to identify leaked objects and the references to them.
