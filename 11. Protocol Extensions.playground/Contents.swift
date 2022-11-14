import Foundation
// MARK: Prtocol Extensions
protocol Exercise: CustomStringConvertible {
    var caloriesBurned: Double { get set }
    var minutes: Double { get set }
    var title: String { get }
}

extension Exercise {
    var caloriesBurnedPerMinute: Double {
        return caloriesBurned / minutes
    }
}

struct EllipticalWorkout: Exercise {
    var caloriesBurned: Double
    var minutes: Double
}

let ellipticalWorkout = EllipticalWorkout(caloriesBurned: 335, minutes: 30)

struct RunningWorkout: Exercise {
    let title = "Gotta go fast!"
    var caloriesBurned: Double
    var minutes: Double
    var meters: Double
    
    var description: String {
        "RunningWorkout(\(caloriesBurned) calories and \(meters)m in \(minutes) minutes)"
    }
}

let runningWorkout = RunningWorkout(caloriesBurned: 350, minutes: 25, meters: 5000)

func caloriesBurnedPerMinute<E: Exercise>(for exercise: E) -> Double {
    return exercise.caloriesBurned / exercise.minutes
}
print(caloriesBurnedPerMinute(for: ellipticalWorkout))
print(caloriesBurnedPerMinute(for: runningWorkout))

// Protocol extensions use the same extension keyword as extensions on other types. Protocol extensions can add new computed properties and methods that have implementations, but they cannot add new requirements to the protocol.
// Protocol extensions also cannot add stored properties, as extensions in general do not support stored properties.
// Properties and methods added in a protocol extension become available on all types that conform to the protocol.

// MARK: Self Types and Type Values
//Methods that have implementations on multiple types sometimes need to know the specific type they are being called on. There is a special type, Self, that you can use for this purpose.
extension Exercise {
    func adding(calories: Double) -> Self {
        var dupe = self
        dupe.caloriesBurned += calories
        print("Creating a new \(Self.self) with \(dupe.caloriesBurned) cal burned.")
        return dupe
    }
}

let ellipticalCopy = ellipticalWorkout.adding(calories: 50)
let runningCopy = runningWorkout.adding(calories: 100)
//Self (with a capital S) can be used as the return type of a method or computed property when you are returning an instance of the same type as the one whose code is executing.

// MARK: Protocol Extension where Clauses
// Extensions allow you to add new methods and computed properties to any type, not just types you have defined.
// Protocol extensions allow you to add new methods and computed properties to any protocol.
// NB: the properties and methods you add in a protocol extension can only use other properties and methods that are guaranteed to exist.
extension Sequence where Element == Exercise {
    func totalCaloriesBurned() -> Double {
        var total: Double = 0
        for exercise in self {
            total += exercise.caloriesBurned
        }
        return total
    }
}

let mondayWorkout: [Exercise] = [ellipticalWorkout, runningWorkout]
print(mondayWorkout.totalCaloriesBurned())

// MARK: Default Implementations with Protocol Extensions
//You can also use protocol extensions to provide default implementations for the protocol’s own requirements.

extension Exercise {
    var description: String {
        "Exercise(\(Self.self), burned \(caloriesBurned) calories in \(minutes) minutes)"
    }
}
print(ellipticalWorkout)
print(runningWorkout)
//When a protocol provides a default implementation for a property or method via a protocol extension, conforming types are not required to implement that requirement themselves – but they can.
//If they do, the compiler will use the conforming type’s implementation instead of the default implementation.

// MARK: Implementation Conflicts
//As you have seen, the compiler will select a concrete protocol-conforming type’s implementation of a method or property over any default implementation provided by a protocol extension. But there is a case where this does not seem to be true, and you should be aware of it to help prevent frustration in the future.
extension Exercise {
    var title: String {
        return "\(Self.self) - \(minutes) minutes"
    }
}
let tenKRun: RunningWorkout = RunningWorkout(caloriesBurned: 750, minutes: 60, meters: 10000)
let workout: Exercise = tenKRun
print(tenKRun.title)
print(workout.title)
//When a protocol declares a requirement and a type conforms to that protocol, the compiler follows a rigorous series of steps to find the conforming type’s implementation to use at every call site. This is the case with your description property, which is required by CustomStringConvertible.
//Behavior that is added using a protocol extension, and not listed in the protocol’s interface, does not get this priority treatment. The compiler treats the protocol extension’s implementation as having equal weight with other implementations provided by the program, rather than as a default implementation to be overridden by concrete types.
//At each call site, as with a generic function, the compiler will select the best implementation it can with the information available. Specifically, the compiler will rely on the declared type of the variable or argument being used to access the property or method.
//Since title is now listed in the Exercise protocol, the compiler interprets the protocol extension’s implementation as a default implementation to be overridden by concrete implementations. It will always search for a concrete implementation and give preference to any that it finds.
//For now, when adding behavior to concrete types using a protocol extension, consider also declaring that behavior in the protocol itself to remove potential confusion over which implementation will be used at the call site.

//You previously learned that the two major differences between value types and reference types are inheritance and value/reference semantics. Now you know that while inheritance is not available to value types, many of its benefits are available via protocols and protocol extensions. This means that value types can fulfill your needs more frequently than you might previously have thought.

// Bronze Challenge
extension Collection {
    func count(where condition: (Element)->Bool) -> Int {
        var count: Int = 0
        for each in self {
            if condition(each) {
                count += 1
            }
        }
        return count
    }
}
    
let workouts: [Exercise] = [ellipticalWorkout, runningWorkout, tenKRun]
let hardWorkoutCount = workouts.count(where: { $0.caloriesBurned >= 500 })

// Silver Challenge
extension Sequence where Element: AdditiveArithmetic {
    var sum: Element {
        reduce(.zero, { $0 + $1 })
    }
}

[4, 8, 15, 16, 23, 42].sum
lround([80.5, 9.6].sum)

// MARK: Gold Challenge

// Sequence protocol
//protocol Sequence<Element>

//A sequence is a list of values that you can step through one at a time. The most common way to iterate over the elements of a sequence is to use a for-in loop:

let oneTwoThree = 1...3
for number in oneTwoThree {
    print(number)
}

let bugs = ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]
var hasMosquito = false
for bug in bugs {
    if bug == "Mosquito" {
        hasMosquito = true
        break
    }
}
print("'bugs' has a mosquito: \(hasMosquito)")
//The Sequence protocol provides default implementations for many common operations that depend on sequential access to a sequence’s values. For clearer, more concise code, the example above could use the array’s contains(_:) method, which every sequence inherits from Sequence, instead of iterating manually:
if bugs.contains("Mosquito") {
    print("Break out the bug spray.")
} else {
    print("Whew, no mosquitos!")
}
// Prints "Whew, no mosquitos!"
//for element in sequence {
//    if ... some condition { break }
//}
//
//for element in sequence {
//    // No defined behavior
//}

//Conforming to the Sequence Protocol
//Making your own custom types conform to Sequence enables many useful operations, like for-in looping and the contains method, without much effort. To add Sequence conformance to your own custom type, add a makeIterator() method that returns an iterator.
struct Countdown: Sequence, IteratorProtocol {
    var count: Int

    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}

let threeToGo = Countdown(count: 3)
for i in threeToGo {
    print(i)
}
//Expected Performance
//A sequence should provide its iterator in O(1). The Sequence protocol makes no other requirements about element access, so routines that traverse a sequence should be considered O(n) unless documented otherwise.
//

// MARK: Polymorphism and Protocol-Oriented Programming
//Polymorphism, meaning “having many forms,” allows you to write a single function that can accept different types.
//That particular flavor of polymorphism is more precisely known as runtime polymorphism or subclass polymorphism. Using protocol types as function arguments or return values is another example of runtime polymorphism.
//Classes that are related by inheritance are tied together tightly: It can be difficult to change a superclass without affecting its subclasses. Also, there is a small but observable performance penalty to runtime polymorphism due to how the compiler must implement functions that accept class arguments.

//Swift’s ability to add constraints to generics allows you to use another form of polymorphism, called compile-time polymorphism or parametric polymorphism. Generic functions with constraints are still true to the definition of polymorphism: You can write a single function that accepts different types.
//Compile-time polymorphic functions address both of the issues listed above that plague runtime polymorphism.
//Many different types can conform to a protocol, allowing them to be used as constraints in any generic function that requires a type conforming to that protocol – but the types can be otherwise unrelated, making it easy to change any one of them without affecting the others. Additionally, compile-time polymorphism generally does not have a performance penalty.

protocol User {
    var name: String { get }
    func validatePassword(_ pw: String) -> Bool
}

class LoginSession {
    var lastLogin: Date?
    var currentUser: User?
    
    func login(_ user: User, with password: String) {
        if user.validatePassword(password) {
            currentUser = user
        }
        print("\(user.name) logged in!")
    }
}

struct AppUser: User {
    var name: String
    private var password: String
    
    func validatePassword(_ pw: String) -> Bool {
#warning("This whole login flow is really insecure, by the way.")
        return password == pw
    }
}
