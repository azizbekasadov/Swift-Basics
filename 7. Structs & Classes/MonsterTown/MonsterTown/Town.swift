//
//  Town.swift
//  MonsterTown
//
//  Created by Azizbek Asadov on 07/11/22.
//

import Foundation

struct Town {
    //    variables are called properties
    let region: String
    var mayor: Mayor
    
    var population: Int {
        didSet(oldPopulation) {
            mayor.increaseAnxietyLevel()
            if oldPopulation > population {
                print("The population has changed to \(population)") // Bronse Challenge
                mayor.showMessage()
            }
        }
    }
                  
    var numberOfStoplights: Int
    
    // MARK: Nested Types
    // Nested types are types that are defined within another enclosing type. They are often used to support the functionality of a type and are not intended to be used separately from that type. Enumerations are frequently nested.
    enum Size {
        case small
        case medium
        case large
    }
    
    
    // MARK: Lazy Stored Properties
//  Sometimes a stored property’s value cannot be assigned immediately. The necessary information may
//  be available, but computing the values of a property immediately would be costly in terms of memory
//  or time. Or, perhaps a property depends on factors external to the type that will be unknown until
//  after the instance is created. These circumstances call for lazy loading.

//   `lazy` loading means that the calculation of the property’s value will not occur until the first time it is needed
//    lazy var townSize: Size = {
//        switch population {
//        case 0...10_000:
//            return Size.small
//        case 10_001...100_000:
//            return Size.medium
//        default:
//            return Size.large
//        }
//    }()
    
    // Computed property
    var townSize: Size {
        switch population {
        case 0...10_000:
            return Size.small
        case 10_001...100_000:
            return Size.medium
        default:
            return Size.large
        }
    }
    
//    You must provide computed properties with an explicit type annotation so that the compiler can verify that the computed value is of the correct type.
    
    // MARK: Custom Initializers
    init(region: String, population: Int, stoplights: Int, mayor: Mayor) {
        self.region = region
        self.population = population
        self.mayor = mayor
        numberOfStoplights = stoplights
    }
    // MARK: Init Delegation
    init(population: Int, stoplights: Int, mayor: Mayor) {
        self.init(region: "N/A", population: population, stoplights: stoplights, mayor: mayor)
    }
    
    // MARK: Failable init
    init?(region: String, population: Int, _stoplights: Int, mayor: Mayor) {
        guard population > 0 else {
            return nil
        }
        self.region = region
        self.population = population
        self.mayor = mayor
        numberOfStoplights = _stoplights
    }
    
    //  The Swift compiler allows you to set a value for a constant property one time during
//  initialization. Remember, the goal of initialization is to ensure that a type’s properties
//  have values after initialization completes.
    
    func printDescription() {
        print("Population: \(self.population); \nnumber of stoplights: \(self.numberOfStoplights); region: \(region)")
    }
    
    mutating func changePopulation(by amount: Int) {
        population = population > 0 ? population + amount : 0
    }
    
//    The mutating keyword asks the compiler to make the implicit self argument inout, so that the instance method can make changes to the original value the method was called on, instead of a copy.
}

// Recall that functions and closures are first-class types and that properties can reference functions and closures.
// Stored properties cannot access each other's values when setting their initial values, as doing so would unsafely reference self
// properties marked with lazy are calculated only one time

// MARK: Computed Property

// You can use computed properties with any class, struct, or enum that you define. Computed properties do
// not store values like the properties that you have been working with thus far. Instead, a computed property
// provides a getter and optional setter to retrieve or set the property’s value. This difference allows the
// value of a computed property to change, unlike the value of a lazy stored property.

// MARK: Comp. Property -> getters & setters (accessors)
// Computed properties can also be declared with both a getter and a setter. A getter allows you to read data
// from a property. A setter allows you to write data to the property. Properties with both a getter and a
// setter are called read/write.

// ?? -> nil coalescing operator

// MARK: Property Observers
// Property observers watch for and respond to changes in a given property. Property observation is available
// to any stored property that you define and is also available to any property that you inherit. You cannot
// use property observers with computed properties that you define
//You can observe changes to a property in one of two ways:
// • when a property is about to change, via willSet
// • when a property did change, via didSet

// MARK: Type properties
// properties that can exist once, on the type itself, and are called type properties
// Value types (structures and enumerations) can take both stored and computed type properties. As with type methods, type properties on value types begin with the static keyword.
// Classes can also have stored and computed type properties, which use the same static syntax as structs. Subclasses cannot override a type property from their superclass.
// If you want a subclass to be able to provide its own implementation of the property, you use the class keyword instead.

// MARK: Initializer delegation
// You can define initializers to call other initializers on the same type. This procedure is called initializer delegation. It is typically used to provide multiple paths for creating an instance of a type.
// In value types (enumerations and structures), initializer delegation is relatively
// straightforward. Because value types do not support inheritance, initializer delegation only
// involves calling another initializer defined on the type.

//For value types, such as structs, initialization is principally responsible for ensuring that all the instance’s stored properties have been initialized and given appropriate values.
//That statement is true for classes as well, but class initialization is a bit more complicated due to classes' inheritance relationships. It can be thought of as unfolding in two sequential phases.
//In the first phase, a class’s designated initializer is eventually called (either directly or by delegation from a convenience initializer). At this point, all the properties declared on the class are initialized with appropriate values inside the designated initializer’s definition.
//Next, a designated initializer delegates up to its superclass’s designated initializer. The designated initializer on the superclass then ensures that all its own stored properties are initialized with appropriate values, which is a process that continues until the class at the top of the inheritance chain is reached. The first phase is now complete.
//The second phase begins, providing an opportunity for a class to further customize the values held by its stored properties. For example, a designated initializer can modify properties on self after it calls to the superclass’s designated initializer. Designated initializers can also call instance methods on self. Finally, initialization reenters the convenience initializer, providing it with an opportunity to perform any customization on the instance.
//The instance is fully initialized after these two phases, and all its properties and methods are available for use.
