import Foundation

// MARK: Basic Enums

//(Pascal case): PascalCasedType.
enum TextAlignment {
    case left
    case right
    case center
}

// You define an enumeration with the enum keyword followed by the name of the enumeration.
// The opening brace ({) opens the body of the enum, and it must contain at least one case statement
// that declares the possible values for the enum. Here, you include three.

// MARK: Instances ~ Enums
var alignment = TextAlignment.left
alignment = .right

// MARK: If-Else statements with Enums
if alignment == .right {
    // TODO
}

// MARK: Switch statements with Enums
switch alignment {
case .left: break
case .right: break
case .center: break
}

//MARK: Enumerations with Raw Values
enum TextAlignment1: Int {
    case left
    case right
    case center
    case justify
}
// Specifying a raw value type for TextAlignment gives a distinct raw value of that type (Int, here) to each case.
// The default behavior for integer raw values is that the first case gets raw value 0, the next case gets raw
// value 1, and so on. Confirm this by printing some interpolated strings.

print(TextAlignment1.center.rawValue)

// You are not limited to the default behavior for raw values. If you prefer, you can specify the raw value for
// each case.
enum TextAlignment2: Int {
    case left = 10
    case right = 20
    case center = 30
    case justify = 40
}

// When are raw values in an enumerations useful? The most common reason for using raw values is to store or
// transmit the enum to a system that does not know about your TextAlignment type. Instead of writing functions
// to transform a variable holding an enum, you can use rawValue to convert the variable to its raw value.

// MARK: Converting raw values to enum types

TextAlignment1.justify.rawValue
//alignment.rawValue
// Create a raw value
let myRawValue = 20
// Try to convert the raw value into a TextAlignment
if let myAlignment = TextAlignment1(rawValue: myRawValue) {
    // Conversion succeeded!
    print("successfully created \(myAlignment) from \(myRawValue)")
} else {
    // Conversion failed
    print("\(myRawValue) has no corresponding TextAlignment case")
}


// MARK: Creating enums with Strings
enum ProgrammingLanguage: String {
    case swift
    case objectiveC = "objective-c"
    case c
    case cpp = "c++"
    case java
}
// just as the compiler will automatically provide integer raw values if you do not set them yourself, it will automatically use the name of a case as its string raw value. So once you have declared that an enum has string raw values, you do not need to assign values if they match the case names.

// MARK: Methods in enums
enum LightBulb {
    case on
    case off
    
    func surfaceTemperature(forAmbientTemperature ambient: Double) -> Double {
        switch self {
        case .on:
            return ambient + 150.0
        case .off:
            return ambient
        }
    }
    
    //    mutating, which makes the implicit self argument mutable
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}
// All Swift methods have a self argument, which is used to access the instance on which the method is called
var bulb = LightBulb.on
let ambientTemperature = 77.0
var bulbTemperature = bulb.surfaceTemperature(forAmbientTemperature:
                                                ambientTemperature)

var on = LightBulb.on
on.toggle()
// In Swift, an enumeration is a value type, and, by default, methods on value types are not allowed to make changes to self.

// MARK: Associated Values ~ enums

// Associated values allow you to attach data to instances of an enumeration, and different cases can have
// different types of associated values.

enum ShapeDimensions {
    // point has no associated value - it is dimensionless
    case point
    // square's associated value is the length of one side
    case square(side: Double)
    // rectangle's associated value defines its width and height
    case rectangle(width: Double, height: Double)
    // right Triangle -> 1/2 * a * h
    case rightTriangle(side: Double, height: Double) // -> Silver Challenge
    
    func area() -> Double {
        switch self {
        case .point:
            return 0
        case let .square(side: side):
            return side * side
        case let .rectangle(width: w, height: h):
            return w * h
        case let .rightTriangle(side: side, height: height):
            return 0.5 * side * height
        }
    }
    
    // Bronze Challenge
    func perimeter() -> Double {
        switch self {
        case .point: return 0
        case let .rectangle(width: w, height: h):
            return (w + h) * 2
        case let .square(side: side):
            return side * 4
        case let .rightTriangle(side: side, height: height):
            return (side + height) + sqrt(pow(side, 2) + pow(height, 2))
        }
    }
}

// The point case has no associated data, so it requires no extra memory. The square case has an associated
// Double, so it requires one Double’s worth of memory (8 bytes). The rectangle case has two associated Doubles,
// so it requires 16 bytes of memory. The actual size of an instance of ShapeDimensions is 17 bytes: enough room
// to store rectangle, if necessary, plus 1 byte to keep track of which case the instance actually is.

// MARK: Recursive Enumerations
// Swift can introduce a layer of indirection -> use the keyword indirect to instruct the compiler to instead store the enum’s data behind a pointer.
indirect enum FamilyTree {
    case noKnownParents
    case oneKnownParent(name: String, ancestors: FamilyTree)
    case twoKnownParents(fatherName: String,
                         paternalAncestors: FamilyTree,
                         motherName: String,
                         maternalAncestors: FamilyTree)
}
// How does using a pointer solve the “infinite memory” problem? The compiler now knows to store a pointer
// to the associated data, putting the data somewhere else in memory rather than making the instance of FamilyTree
// big enough to hold the data. The size of an instance of FamilyTree is now 8 bytes on a 64-bit architecture
// – the size of one pointer
// It is worth noting that you do not have to mark the entire enumeration as indirect: You can also mark individual recursive cases as indirect
enum FamilyTree1 {
    case noKnownParents
    indirect case oneKnownParent(name: String, ancestors: FamilyTree1)
    indirect case twoKnownParents(fatherName: String,
                                  paternalAncestors: FamilyTree1,
                                  motherName: String,
                                  maternalAncestors: FamilyTree1)
}
let fredAncestors = FamilyTree.twoKnownParents(
            fatherName: "Fred Sr.",
            paternalAncestors: .oneKnownParent(name: "Beth", ancestors: .noKnownParents),
            motherName: "Marsha",
            maternalAncestors: .noKnownParents
)
