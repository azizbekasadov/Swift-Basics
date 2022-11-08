//
//  Town.swift
//  MonsterTown
//
//  Created by Azizbek Asadov on 07/11/22.
//

import Foundation

struct Town {
    //    variables are called properties
    let region = "Middle"
    var mayor: Mayor
    
    var population = 5_422 {
        didSet(oldPopulation) {
            mayor.increaseAnxietyLevel()
            if oldPopulation > population {
                print("The population has changed to \(population)") // Bronse Challenge
                mayor.showMessage()
            }
        }
    }
                  
    var numberOfStoplights = 4
    
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
    
    func printDescription() {
        print("Population: \(self.population); \nnumber of stoplights: \(self.numberOfStoplights)")
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
