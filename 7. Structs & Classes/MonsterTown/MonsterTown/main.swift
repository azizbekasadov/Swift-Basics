//
//  main.swift
//  MonsterTown
//
//  Created by Azizbek Asadov on 07/11/22.
//

import Foundation

// MARK: Structs - A struct is a type that groups a set of related chunks of data together in memory
var myTown = Town(region: "US", population: 10_000, stoplights: 4, mayor: Mayor())

// MARK: Instance Methods
myTown.printDescription()
// MARK: Application of mutating methods
myTown.changePopulation(by: 500)

// Inheritance is a relationship in which one class, a subclass, is defined in terms of another, a superclass.
// The subclass inherits the properties and methods of its superclass

let zombie = Zombie(limp: true, fallingApart: false, town: myTown, monsterName: "Zombie")
//zombie.town = myTown
zombie.terrorizeTown()
zombie.town?.printDescription() //  optional chaining unwrapping

// Polymorphism and type casting
let fredTheZombie: Monster = Zombie(limp: false, fallingApart: false, town: myTown, monsterName: "Fred")
fredTheZombie.town = myTown
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()

// Type casting -> instruct the compiler to treat a variable as though it were of a specific, related type
// it creates an expression that is of a different type than the variable, but does not change the type of the variable itself

// Casting from a more general type (a superclass) to a more specific type (a subclass) is called downcasting, and it is unsafe
(fredTheZombie as? Zombie)?.walksWithLimp = true
// First, casting from a subclass to its superclass is called upcasting and is always safe
// Ex. there is nothing a Monster can do that a Zombie cannot

// Second, you can ask Swift whether you are correct about an instance's type at runtime with the is keyword
if fredTheZombie is Zombie {
    print("I knew it!")
}
// The is expression will return true for the target type or any of its direct or indirect superclasses.

// A function with a signature of (Monster) -> Void would be happy to accept an argument of type Zombie, but not the reverse, without potentially unsafe type casting.

//Inheritance is only one form of polymorphism

//

// Because a struct (or enum) variable stores the instance's entire value, we say that structs and enums are value types and that their instances follow value semantics.

// Classes, on the other hand, only use a variable to store a reference to some other location in memory where the instance's actual content is stored. In a modern program, a reference is always 64 bits (8 bytes) of memory, no matter how many bytes are used by the actual instance it refers to.

// Because class variables only hold references to bytes that are stored elsewhere, we say that classes are reference types and that their instances follow reference semantics when we use them


print(Zombie.spookyNoise)
if Zombie.isTerrifying {
    print("Run away!")
}

// MARK: Access Control
// You can grant components of your code specific levels of access to other components of your code. This is called access control.
// With access control, you can manage the visibility of that property to hide it from other parts of the program. Doing so will encapsulate the property’s data and prevent external code from meddling with it.
// Access control is organized around two important and related concepts: modules and source files. In terms of your project’s files and organization, these are the central building blocks of your application.
// A module is code that is distributed as a unit.
// Modules are brought into another module using Swift’s import keyword, as suggested by the examples above.
//Source files, on the other hand, are more discrete units.
// They represent a single file and live within a specific module. It is good practice to define a single type within a source file.
//Access level Description Visible to... Subclassable within...
//
//open
//Entities are visible and subclassable to all files in the module and those that import the module.
//defining module and importing modules
//defining module and importing modules
//public
//Entities are visible to all files in the module and those that import the module.
//defining module and importing modules
//defining module
//internal
//(the default)
//Entities are visible to all files in the same module.
//defining module
//defining module
//fileprivate
//Entities are visible only within their defining source file.
//defining file
//defining file
//private
//Entities are visible only within their defining scope.
//scope
//scope

//In general, a type’s access level must be consistent with the access levels of its properties and methods. A property cannot have a less restrictive level of access control than its type. For example, a property with an access control level of internal cannot be declared on a type with private access.
//the access control of a function cannot be less restrictive than the access control listed for its parameter types. If you violate these requirements, the compiler will issue an error to help you correct the mistake.

//Swift specifies internal as the default level of access control for your app. Having a default level of access means that you do not need to declare access controls for every type, property, and method in your code.

// MARK: Key Paths
// When you need an expression that refers to a specific property of a type, you can use a key-path
let names = ["Almasi", "Haris", "Jun", "Kala"]
let firstLetters = names.compactMap({ $0.first })
let firstLetters1 = names.compactMap(\String.first)
let firstLetters2 = names.compactMap(\.first)
// it is worth knowing that this syntax offers a type-safe alternative to manually writing a closure for functions that support the KeyPath type as arguments.

func foo(_ function: (Int) -> Int) -> Int {
    return function(function(5))
}
func bar<T: BinaryInteger>(_ number: T) -> T {
    return number * 3
}

print(foo(bar))

// MARK: Initializers
// Initialization is the operation of setting up an instance of a type. It entails giving each
// stored property an initial value and may involve other preparatory work. After this process,
// the instance is prepared and available to use.
// Initializers help you create an instance with the appropriate values.
// Initializers do not return values. Instead, initializers are tasked with giving values to a type’s stored properties.

// empty initializer
// init() {
//     // todo
// }

// memberwise initializer
// init(population: Int = 5422, numberOfStoplights: Int = 4) {
//     self.population = population
//     self.numberOfStoplights = numberOfStoplights
// }
// var myTown = Town(population: 10_000, numberOfStoplights: 6)
// myTown.printDescription()
// Free default memberwise initializers are a benefit of structs; they are not available on classes.

let someTown = Town(population: 8_465, stoplights: 4, mayor: Mayor())

// MARK: Class inits
// Designated and Convenience initializers
// 1. `Designated initializers` are responsible for making sure that an instance’s properties all have values before initialization completes, thus making the instance ready to use.
// 2. `Convenience initializers` supplement designated initializers by calling across a class to its designated initializer. The role of convenience initializers is typically to create an instance of a class for a very specific use case.

// MARK: Default inits for Classes
// Classes get a default empty initializer if you provide default values to all properties and do not write your own initializer
// Designated initializers for classes -> Classes use designated initializers as their primary initializers.
// Designated initializers are responsible for ensuring that the class’s properties are all given values before initialization is ended. If a class has a superclass, then its designated initializer must also call its superclass’s designated initializer.

// MARK: Convenience Inits for Classes
// Unlike designated initializers, convenience initializers are not responsible for making
// sure all of a class’s properties have a value. Instead, they do the work that they are
// defined to do and then hand off that information to either another convenience initializer
// or a designated initializer.
// Eventually, a convenience initializer must call through to its class’s designated initializer.
// The relationship between convenience and designated initializers defines a path by which a class’s stored properties receive initial values.
var convenientZombie = Zombie(limp: true, fallingApart: false)

// MARK: Required initializers for classes
// what if you want to be able to create instances of a class and all its subclasses with the
// same initializer? You can require that subclasses provide a specific initializer, if it is not inherited.

// MARK: Deinitialization
// Deinitialization is part of the process of removing instances of a class from memory when
// they are no longer needed.
// Deinitialization is limited to reference types; it is not available for value types.
// A deinitializer provides an opportunity to do any final maintenance before the instance is deallocated. It is called automatically, immediately prior to the removal of an instance from memory. If the class is a subclass, then the superclass's deinitializer will execute next, and on up the chain, before the instance's deallocation.
var dezombie: Zombie? = Zombie(limp: true, fallingApart: false)
dezombie?.town?.printDescription()
dezombie = nil

// MARK: Failable Initializers
// Failable initializers return an optional instance of the type. To indicate that an initializer is failable, you add a question mark to the init keyword: init?.

// MARK: Initializer Parameters
// External parameter names distinguish between the parameter names available to callers and the local parameter names used in a function’s implementation.
struct WeightRecordInLbs {
    let weight: Double
    
    init(_ pounds: Double) {
        weight = pounds
    }
    
    init(kilograms kilos: Double) {
        weight = kilos * 2.20462
    }
    
}

// MARK: Value vs Reference Types
