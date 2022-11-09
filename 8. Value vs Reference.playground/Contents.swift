import UIKit

// MARK: Value types
var greeting = "Hello, playground"
var playgroundGreeting = greeting // a new copy of greeting will be stored here
playgroundGreeting = "You won!"
playgroundGreeting += "! How are you today?"
// types with value semantics are copied when they are assigned to an instance or passed as an argument to a function
// Swift’s basic data types – Array, Dictionary, Int, String, and so on – are all implemented as structs, so they are all value types.
// With value types, you get a copy of the instance when you assign it to a new constant or variable. The same is true when you pass an instance of a value type as the argument to a function.
// NB: You should first consider modeling your data with a struct and only use a class if needed.

// MARK: Reference semantics
// But for an instance of a reference type, these two actions create an additional reference to the same underlying instance.
class Employee {
    var id: Int = 0
}

let anika = Employee()
let theBoss = anika
anika.id = 16
theBoss.id
// When you assign an instance of a class to a constant or variable, as you did with anika, that constant or variable gets a reference to the instance. And, as you can see, a reference works differently than a copy.
// With a reference, the constant or variable refers to an instance of the class in memory.
// This does not mean that all references always refer to a single, shared instance; you can make more instances and references to them using the constructor syntax
//In terms of size, on all modern Apple platforms a reference type variable is always 64 bits (8 bytes), no matter what kind of object it refers to. You might have a reference to a large class instance packed with 500 Int properties adding up to 4 kilobytes of memory, but your reference is still only 8 bytes, and the actual 4 kilobyte instance is somewhere else, managed by the system.

// MARK: Constant Value and Reference Types
// Value and reference types behave differently when they are constants.
struct Company {
    var boss: Employee
}
let acme = Company(boss: anika)
let mel = Employee()
// acme.boss = mel // Compiler error
// Value types that are declared as constants cannot have their properties changed, even if those properties are declared with var in the type’s implementation.

// MARK: Using Value and Reference Types Together
// you must be very careful about using a reference type inside a value type. (Using a value type inside a
// reference type does not present any particular problems.)
// You should expect instances of value types to be copied when they are assigned to a new variable or constant
// or passed in to a function. But a value type with a reference type in a property will pass a reference to the
// same instance to the new variable or constant. Changes made to that instance via the property of any one of the
// constants or variables will be reflected in all of them.

// MARK: Copying
let juampa = Employee()
let employees = [anika, mel, juampa]
let partyGoers = employees
employees.last?.id = 4
employees
partyGoers
// Shallow copying does not traverse references: A shallow copy of a value type copies the value. A shallow copy of a reference type copies the reference.
// Deep copying - reverse of shallow
//A deep copy, on the other hand, would duplicate the instance at the destination of a reference. That would mean that the indices of the partyGoers array would not reference the same instances of Employee. Instead, a deep copy of employees would create a new array with references to its own instances of Employee.

// MARK: Equality vs Identity
// Equality refers to two instances having the same values for their observable characteristics, such as two instances of the String type that have the same text.
let x = 1
let y = 1
x == y // true
// Identity, on the other hand, refers to whether two references point to the same instance in memory.
// Check for identity on two new instances using the identity operator (===) to see whether they point to the same instance.
acme.boss === anika
//The === operator exists to check the memory address of instances referred to by reference type variables. Value type variables do not store references, so an identity check would be meaningless.

// Equatable protocol

//Strict rules are hard to define, because there are many factors to consider, but here are some general guidelines.
//• If you want a type to be passed by reference, use a class. Doing so will ensure that the type is referenced rather than copied when assigned or passed in to a function’s argument.
//• If the type needs to support inheritance, then use a class. Structs do not support inheritance and cannot be subclassed.
//• Otherwise, you probably want a struct.

// MARK: Copy on Write
// Copy on write, or COW, refers to the implicit sharing of value types’ underlying storage. Instances of a value
// type do not immediately have their own copies of the data. They share their underlying storage, with each instance
// maintaining its own reference to the store. If an instance needs to mutate the storage, or write to it, then the
// instance gets its own distinct copy.
// This allows value types to avoid creating copies of data unnecessarily.
fileprivate class IntArrayBuffer {
    var storage: [Int]
    
    init() {
        storage = []
    }
    
    init(buffer: IntArrayBuffer) {
        storage = buffer.storage
    }
}
struct IntArray {
    private var buffer: IntArrayBuffer
    
    init() {
        buffer = IntArrayBuffer()
    }
    
    private mutating func copyIfNeeded() {
        if !isKnownUniquelyReferenced(&buffer) {
            print("Making a copy of \(buffer.storage)")
            buffer = IntArrayBuffer(buffer: buffer)
        }
    }
    
    func describe() {
        print(buffer.storage)
    }
    
    mutating func insert(_ value: Int, at index: Int) {
        copyIfNeeded()
        buffer.storage.insert(value, at: index)
    }
    
    mutating func append(_ value: Int) {
        copyIfNeeded()
        buffer.storage.append(value)
    }
    
    mutating func remove(at index: Int) {
        copyIfNeeded()
        buffer.storage.remove(at: index)
    }
}
var integers = IntArray()
integers.append(1)
integers.append(2)
integers.append(4)
integers.describe()

var moreIntegers = integers
moreIntegers.insert(3, at: 2)
integers.describe()
moreIntegers.describe()

//Swift’s collections already provide COW. A struct made up of arrays, dictionaries, and strings gets COW behavior for free, because its component parts already implement it via the standard library. This discussion was meant to give you a sense of how COW works and to alleviate any concern about memory pressure resulting from the copy behavior of value types.
