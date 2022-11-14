import Foundation

@propertyWrapper public struct Percentage {
    private var storage: Double
    private var upperBound: Double
    
    public init(wrappedValue: Double, upperBound: Double = 1) {
        storage = wrappedValue
        self.upperBound = upperBound
    }
    
    public var wrappedValue: Double {
        set {
            storage = newValue
        } get {
            return storage.clamped(to: 0...upperBound) //max(min(storage, upperBound), 0)
        }
    }
        
    public var projectedValue: Double { storage }
}
//The only requirements for a property wrapper are a variable named wrappedValue and an initializer whose first argument is called wrappedValue, which must be of the same type as the variable.
//Since a property wrapper exists to manipulate data coming into or out of a property, the wrappedValue is generally a computed property, and the property wrapper will often have a private property to store a value between accesses.

// MARK: Additional configuration
//Here, you add a new property, upperBound, that will be used as the highest value that can be stored in a @Percentage variable. You update the initializer to accept and store a value for the upperBound, with a default value of 1. Last, you update the wrappedValue setter to compare new values to the provided upperBound.
//Here, you project the value of storage without clamping it. That value can be accessed by prefixing a wrapped variable’s name with $. Test your ability to access this projected value in the main playground:

//Gold Challenge
//The majority of property wrappers are generic. Since the point of defining a property wrapper is to make a reusable tool, you will usually want to make your property wrappers generic so that they are as broadly useful as possible.
//Right now, the Percentage property wrapper can only accept values of type Double. That is limiting; what if someone wants to store a Float?
//Modify Percentage to allow its wrapped value to be any floating-point number.
//Hint: This will require you to define Percentage as a generic data structure, which you learned about in Chapter 21. Look closely at the documentation for the Float and Double types. Do they have anything in common that you could use as a constraint on your generic type?
//For bonus points, upgrade your solution to the bronze challenge by eliminating the warningValue feature and instead allowing @Logged to wrap a property of any type that conforms to CustomStringConvertible.
