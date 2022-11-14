import Foundation
import Darwin

struct Point {
    let x: Int
    let y: Int
    let label: String? = nil
}

// MARK: Equatable
extension Point /*Equatable*/ {
    static func ==(lhs: Point, rhs: Point) -> Bool {
        (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
}

// MARK: Comparable
extension Point: Comparable {
    static func <(lhs: Point, rhs: Point) -> Bool {
        return (lhs.x < rhs.x) && (lhs.y < rhs.y)
    }
}
let a = Point(x: 3, y: 4)
let b = Point(x: 3, y: 4)
let abEqual = (a == b)
let abNotEqual = (a != b)
let c = Point(x: 2, y: 6)
let d = Point(x: 3, y: 7)
let cdEqual = (c == d)
let cLessThanD = (c < d)

let cLessThanEqualD = (c <= d)
let cGreaterThanD = (c > d)
let cGreaterThanEqualD = (c >= d)

let pointRange = c..<d
pointRange.contains(a)
pointRange.contains(Point(x: -1, y: -1))

//The Equatable protocol has one requirement: an implementation of the == function. You have not implemented this function for Point – but just as the compiler can synthesize initializers, it can synthesize some other common function implementations.
//Among them, the compiler can synthesize == for an Equatable struct whose properties are all also Equatable. It will do the same for Equatable enums whose raw values or associated values are Equatable
//(It cannot synthesize == for classes.)
//Operator implementations can be written either as global functions or as static methods on the types they operate on. Protocols cannot require global functions, so the Equatable protocol declares its requirement in the form of a static method. In either case, the operator is the name of the function.

// MARK: Infix operators
precedencegroup ComparisonPrecedence {
    higherThan: LogicalConjunctionPrecedence
}
infix operator == : ComparisonPrecedence


//Note that – unlike for == and Equatable – the compiler cannot synthesize the required < function
//for you. You must provide your own implementation, carefully considering what it means for your program for one instance to be less than another.
//Swift does not need to compute all possible values that would fall within a range. An instance of Range only stores the lower bound and the upper bound. When you ask a range if it contains a value, the range compares the value to its bounds, with the exact comparison depending on its type. A half-open range like this one returns true if the value is greater than or equal to the lower bound and less than the upper bound.

// MARK: Protocol inheritance
//Comparable inherits from Equatable. You may be able to guess the implication of this inheritance. To conform to the Comparable protocol, you must also conform to the Equatable protocol (including, as you have seen, by supplying an implementation of the == operator). This relationship also means that a type does not have to explicitly declare conformance to Equatable if it declares conformance to Comparable.
// - Just remove Equatable from the extension

// MARK: Hashable
//In order for a type to be included in a Set or used as the key type in a Dictionary, it must be hashable. A type is hashable when it conforms to the Hashable protocol. Hashability has a straightforward purpose: the ability of a type to generate an integer based on its content.
let points: Set = [a, b, c]
points.intersection([b, c, d])
let pointNames: [Point:String] = [
    Point(x: 0, y: 0): "origin", a: "a", ]
//Similar to Equatable, the compiler will happily synthesize implementations of Hashable’s requirements for structs with all hashable stored properties and enums with no associated values (or all hashable associated values).
extension Point: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

// MARK: Custom hashing
//In Swift, the hash of an instance is an integer that is generated from the instance’s data. Comparing the hashes of two instances of a type can be a very fast way to check whether the instances are different – often much faster than comparing the instances using the == operator.
//By contrast, comparing two integers is blazing fast, and modern CPUs are often designed to make it even faster.
//If you want to know whether two strings are equal, you can first check their hashes, which takes nearly no time at all. If their hashes are different, then you know the strings are different.
//An ideal hashing algorithm is one that is fast to compute and unlikely to collide with another instance’s hash – but does not need to guarantee that two hashes will never be the same.
//To make lookups and comparisons as fast as possible, dictionaries use hashes as an initial check to ensure that dictionary keys are unique, and sets use hashes as an initial check to ensure the uniqueness of their contents
//Swift has a safe, fast hashing algorithm built in. All you have to do is tell Swift which properties of an instance should participate in the computation of its hash. Swift calls these properties that contribute to an equality comparison the instance’s essential components.
//To control which properties of an instance will contribute to its hash, you must provide your own implementation of the Hashable requirement. That requirement is an implementation of a method called hash(into:). Implement it in your Point extension:

// Bronze Challenge
extension Point {
    static func + (_ lhs: Point, _ rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

let aPlusB = a + b
print(aPlusB)

// Silver Challenge -> Stacks

// Gold Challenge
class Person {
    var name: String
    let age: Int
    
    weak var spouse: Person?
    
    init(name: String, age: Int, person: Person?) {
        self.name = name
        self.age = age
    }
}

let p1 = Person(name: "Alex", age: 23, person: nil)
let p2 = Person(name: "Bob", age: 32, person: nil)
let people = [p1, p2]
people.firstIndex(where: { $0.name == p1.name })

// Platinum Challenge
extension Person: Comparable {
    static func < (_ lhs: Person, _ rhs: Person) -> Bool {
        (lhs.name == rhs.name) && (lhs.age == rhs.age)
    }
    
    static func ==(_ lhs: Person, _ rhs: Person) -> Bool {
        (lhs.name == rhs.name) && (lhs.age == rhs.age)
    }
}

protocol EuclideanDistance: Comparable {
    associatedtype Element = Comparable
    static func distance(_ a: Element, _ b: Element) -> Double
}

extension Point: EuclideanDistance {
    static func distance(_ a: Point, _ b: Point) -> Double {
        let left = NSDecimalNumber(decimal: pow(Decimal(a.x - b.x), 2)).doubleValue
        let right = NSDecimalNumber(decimal: pow(Decimal(a.y - b.y), 2)).doubleValue
        
        return sqrt(left + right)
    }
}
let eGreaterThanF = (p1 > p2)
let eLessThanF = (p1 < p2)
let eEqualToF = (p1 == p2)

print(Point.distance(a, b))

// MARK: Custom Operators
infix operator +++

func +++(lhs: Person, rhs: Person) {
    lhs.spouse = rhs
    rhs.spouse = lhs
}


let matt = Person(name: "Matt", age: 23, person: nil)
let drew = Person(name: "Drew", age: 27, person: nil)

print(matt +++ drew)
print(matt)
print(drew)
//The implementation of +++ will assign each instance to the other’s spouse property. +++ does not state a precedencegroup, which means it is assigned to the DefaultPrecedence group.
precedencegroup DefaultPrecedence {
    higherThan: TernaryPrecedence
}
//precedencegroups offer a number of other options to define the custom operator. In addition to higherThan, another important option that you will often see is associativity.
//associativity defines how operations of the same priority group together. It takes one of two values, left or right.
//For example, the operators + and - both use the same precedencegroup (AdditionPrecedence) and therefore have the same priority. Both are also left associative. The associativity and precedence for the mathematical operators mean that the order of execution in the equation above is (4 + (3 * 3)) - 1. That is, 3 * 3 is evaluated first, because it has the highest priority, and its product associates to the left. That yields (4 + 9) - 1, which is 13 - 1, which is 12.
//Because +++ is intended to marry two Person instances together, it does not need to be chained together with multiple calls. For example, you would not see this code: matt +++ drew +++ someOtherInstance. Thus, you can take advantage of the default values for precedence and associativity.
