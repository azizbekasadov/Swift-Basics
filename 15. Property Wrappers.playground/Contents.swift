import Foundation
// Example
//struct Car {
//    private var fuelLevelStorage: Double = 1.0
//    var fuelLevel: Double {
//        set {
//            fuelLevelStorage = max(min(newValue, 1), 0)
//        }
//        get {
//            return fuelLevelStorage
//        }
//    }
//}

//The set block clamps to the range of 0.0 through 1.0 by storing a value of 1.0 when the value is too high or storing a value of 0.0 when the value is too low.

// MARK: Property wrapper
// A property wrapper is a specialized enum, struct, or class that you define to hold and manipulate a wrapped value that uses computed properties internally.
// You can wrap a stored property of any other type in an instance of your wrapper type – and your code becomes much less cluttered and more readable as a result.

struct Car {
    @Percentage var fuelLevel: Double = 1.0
    @Percentage var wiperFluidLevel: Double = 0.5
    // MARK: Additional configuration
    @Percentage(upperBound: 2.0) var stereoVolume: Double = 1.0
    
    // Same as: (see below)
//    private var _fuelLevel = Percentage(wrappedValue: 1.0)
//    var fuelLevel: Double {
//        get { return _fuelLevel.wrappedValue }
//        set { _fuelLevel.wrappedValue = newValue }
//    }
    
}

extension Car: CustomStringConvertible {
    var description: String {
        return "fuelLevel: \(fuelLevel), wrapped by \(_fuelLevel)"
        // _fuelLevel -> Accessing the Wrapper Itself
    }
}


var myCar = Car()
print(myCar)
myCar.fuelLevel = 1.1
print("Fuel:", myCar.fuelLevel)
myCar.stereoVolume = 2.5
print("Volume:", myCar.stereoVolume)
print("Projected volume:", myCar.$stereoVolume)
//When you declare a data structure as a @propertyWrapper, that type can then be used with the @ symbol as a custom attribute. Then, when you declare a property using a property wrapper attribute such as @Percentage, the compiler rewrites your property declaration to use an instance of the wrapper type (Percentage) to handle the storage and transformation of its value.

// MARK: Accessing the Wrapper Itself
//A type with a wrapped property, such as Car and its fuelLevel, can access the wrapper object directly – rather than its wrappedValue – by prefixing the wrapped property name with an underscore ( _ ).
//Inside the implementation of Car – and even in an extension on Car in the same file – you can access the Percentage instance that is wrapping the fuelLevel property via its underscore-prefixed version, _fuelLevel. But note that it is private to the Car type. For example, you would not be able to print myCar._fuelLevel from outside the struct or its extension

// MARK: Projecting Related Values
myCar.$stereoVolume
//Bronze Challenge
//Open the completed MonsterTown project that you worked on from Chapter 15 to Chapter 17.
//Define a property wrapper type in that project called Logged that logs changes to a wrapped property and logs when a property’s value gets too low. Its wrappedValue should be an Int. Its initializer should take and store a second Int argument called warningValue.
//Every time a @Logged property’s value changes, a message should print to the console containing the old value and the new value. If the value drops below the warningValue, an additional message should be logged indicating that the value is getting too low.
//Mark the population property of the Town type as @Logged with a warningValue of 50. Now, every time a town’s population changes, the change is printed to the console – and if a town’s population drops below 50, the additional warning message is printed.
//This means that you can get rid of the didSet property observer of the population property. (It also means that any time you want to make any property log its changes, you can make it a @Logged property.)
//Test that your property wrapper works by assigning different values to a town’s population in main.swift.

//Silver Challenge
//The syntax max(min(someValue, 1), 0) is not very intuitive. It takes a moment of reading to understand that this is clamping a value to be between 0 and 1.
//In a new file in your PercentageClamping playground’s Sources, define an extension to give all floating-point numbers a clamped(to:) method. The method should accept an instance of ClosedRange, so that it can be called like someValue.clamped(to: 0...1).
//Update your Percentage struct to use it instead of the current, difficult-to-read formula.
////Hint: You may need to refer back to what you learned about Self in Chapter 22 on protocol extensions.
