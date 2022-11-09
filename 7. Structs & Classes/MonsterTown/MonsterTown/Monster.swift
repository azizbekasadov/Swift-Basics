//
//  Monster.swift
//  MonsterTown
//
//  Created by Azizbek Asadov on 07/11/22.
//

import Foundation

// Classes can always mutate
class Monster {
    static let isTerrifying = true
    
    var town: Town?
    var name: String
    
    /*final*/ func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
    
    required init(town: Town?, monsterName: String) {
        self.town = town
        name = monsterName
    }
    
    
    class func makeSpookyNoise() -> String {
        return "Brains..."
    }
    
    class var spookyNoise: String {
        return "Brains..."
    }
}

// Subclass
class Zombie: Monster {
    var walksWithLimp: Bool
    /*internal*/ private(set) var isFallingApart: Bool
    
//  You use the syntax internal private(set) to specify that the getter should be internal and the
//  setter should be private. You could use public, internal, or private for either, with one restriction:
//  The setter cannot be more visible than the getter.
    
    override func terrorizeTown() {
        if !isFallingApart {
            town?.changePopulation(by: -10)
        }
        super.terrorizeTown()
    }
    
    func regenerate() {
        walksWithLimp = false
    }
    
    // Designated init
    init(limp: Bool, fallingApart: Bool, town: Town?, monsterName: String) {
            walksWithLimp = limp
            isFallingApart = fallingApart
            super.init(town: town, monsterName: monsterName)
    }

    convenience init(limp: Bool, fallingApart: Bool) {
        self.init(limp: limp, fallingApart: fallingApart, town: nil, monsterName: "Fred")
        if walksWithLimp {
            print("This zombie has a bad knee.")
        }
    }
    
    // Required Init
    required init(town: Town?, monsterName: String) {
        walksWithLimp = false
        isFallingApart = false
        super.init(town: town, monsterName: monsterName)
    }
    
    //    final class func makeSpookyNoise() -> String {
    //        return "Brains..."
    //    }
    override class var spookyNoise: String {
        return "Brains..."
    }
    
    deinit {
        print("Zombie \(name) is no longer with us.")
    }
}
// super is a feature of inheritance, it is not available to enums or structs, which do not support inheritance. It is invoked to borrow or override functionality from a superclass.

// Just as class types contain only a reference to the instance, and not the entire instance itself,
// the same is true for function arguments of class types - including the implicit self argument of
// class instance methods. Since self is already a reference to the instance, and not a copy of it,
// the self implicit argument does not need to be made inout, so the mutating keyword is not used with
// class instance methods.

// Silver Challenge
class Vampire: Monster {
    var thralls: [Vampire] = []
    
    var victimPool: Int {
            get {
                return town?.population ?? 0
            }
            set(newVictimPool) {
                town?.population = newVictimPool
            }
    }
    
    override func terrorizeTown() {
        super.terrorizeTown()
        town?.changePopulation(by: -1)
        
        if let population = town?.population, population > 1 {
            thralls.append(Vampire(town: town, monsterName: "BRaBRa"))
        }
    }
}

// Type methods
struct Square {
    static func numberOfSides() -> Int {
        return 4
    }
}

// Type methods on classes use the class keyword. Here is a type method on the Zombie class that represents the universal zombie catchphrase.
// a class method is that subclasses can override that method to provide their own implementation.

// NB: type methods cannot call instance methods or work with any instance properties, because an instance is not available for use at the type level.

// MARK: Properties

// Properties model the characteristics of the entity that a type represents
// They do this by associating values with the type. The values properties can take may be constant or variable values. Classes, structures, and enumerations can all have properties.
// Properties can either be stored or computed

// 1. Stored properties allocate memory to hold on to the property's value between accesses.
// 2. Computed properties are like lightweight functions, using other properties, variables, and functions to calculate a new value each time they are accessed

// MARK: Controlling getter and setter visibility
// If a property has both a getter and a setter, you can control the visibility of the two independently
// internal private(set) var isFallingApart = false. That means, for example, that if you make the getter internal, you cannot use public(set), because public is more visible than internal.

// • property syntax
// • stored versus computed properties
// • read-only and read/write properties
// • lazy loading and lazy properties
// • property observers
// • type properties
// • access control

// MARK: Automatic initializer inheritance
// Classes do not typically inherit their superclass’s initializers. This feature of Swift is
// intended to prevent subclasses from inadvertently providing initializers that do not set values
// on all the properties of the subclass type, because subclasses frequently add properties that
// do not exist in the superclass. Requiring subclasses to have their own initializers helps
// prevent types from being partially initialized with incomplete initializers.

// If your subclass provides default values for all new properties it adds, then there are two scenarios in which it will inherit its superclass’s initializers:
// • If the subclass does not implement any designated initializers, it will inherit its superclass’s designated initializers.
// • If the subclass provides all its superclass’s designated initializers – either by overriding or by inheriting them – it will inherit all the superclass’s convenience initializers.

// MARK: convenience keyword
// This keyword tells the compiler that the initializer will need to delegate to another initializer on the class, eventually calling to a designated initializer.
