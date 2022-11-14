import Foundation

// MARK: Extension

//Swift provides a feature called extensions that is designed for just these cases. Extensions allow you to add functionality to an existing type. You can extend structs, enums, and classes.
//You can use extensions on types to add:
//• computed properties
//• new initializers
//• protocol conformance
//• new methods
//• embedded types
extension Double {
    var squared: Double { self * self }
}
let sideLength: Double = 12.5
let area = sideLength.squared

struct Car {
    let make: String
    let model: String
    let year: Int
    
    var fuelLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0.0, "New value must be between 0 and 1.")
        }
     }
}

let firstCar = Car(make: "Benz",
                   model: "Patent-Motorwagen",
                   year: 1886,
                   fuelLevel: 0.5)

// MARK: Using extensions to add protocol conformance
// Extensions are great for grouping related chunks of functionality, like conforming to a protocol
extension Car: CustomStringConvertible {
    var description: String {
        return "\(year) \(make) \(model), fuel level: \(fuelLevel)"
    }
}
// NB: An extension can access the private declarations within a type as long as the extension and type are defined in the same file.

// MARK: Adding an initializer with an extension
//Recall that structs give you a free memberwise initializer if you do not provide your own. If you want to write a new initializer for your struct but do not want to lose the free memberwise or empty initializer, you can add the initializer to your type with an extension.
extension Car {
    init(make: String, model: String, year: Int) {
        self.init(make: make, model: model, year: year, fuelLevel: 1.0)
    }
}

var secondCar = Car(make: "VW", model: "Jetta", year: 2021)

// MARK: Nested types and extensions
extension Car {
    enum Era {
        case veteran, brass, vintage, modern
    }
    var era: Era {
        switch year {
        case ...1896:
            return .veteran
        case 1897...1919:
            return .brass
        case 1920...1930:
            return .vintage
        default:
            return .modern
        }
    }
}
//Notice the simplified syntax for declaring the cases of an enumeration: all on one line, separated by commas. This syntax is especially convenient for simple enums that do not need raw values or associated values.
print(secondCar.era)

// MARK: Extensions with methods
extension Car {
    mutating func emptyFuel(by amount: Double) {
        precondition(amount <= 1 && amount > 0,
                     "Amount to remove must be between 0 and 1.")
        fuelLevel -= amount
    }
    
    mutating func fillFuel() {
        fuelLevel = 1.0
    }
}
secondCar.fillFuel()
//Extensions are an incredibly flexible tool for enhancing the organization of your code and adding useful behavior to existing types. One caveat on something you might see in the wild: While extensions are primarily used to add new functionality, they can sometimes be used to replace existing functionality by implementing a method or computed property that already exists on a type. This is different from overriding a method in a subclass, and it is an advanced topic with limited utility and inherent risks.

// Silver challenge
extension Int {
    enum Value {
        case odd
        case even
    }
    
    var valueType: Value {
        self % 2 == 0 ? .even : .odd
    }
}
