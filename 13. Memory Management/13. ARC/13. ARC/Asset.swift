//
//  Asset.swift
//  13. ARC
//
//  Created by Azizbek Asadov on 14/11/22.
//

import Foundation

class Asset {
    typealias ValueChangeHandler = (Double) -> Void
    
    let name: String
    var value: Double {
        didSet {
            changeHandler(value - oldValue)
        }
    }
    var changeHandler: ValueChangeHandler
    
    weak var container: Vault?
    // MARK: Escaping and Non-Escaping Closures
    init(name: String, value: Double, changeHandler: @escaping ValueChangeHandler = {_ in}) {
        self.name = name
        self.value = value
        self.changeHandler = changeHandler
    }
    deinit {
        print("\(self) is being deallocated")
    }
    
//    When you assign a closure to a property of another object, you know that closure might exist for a while, and that objects that have been strongly captured by the closure cannot deallocate before the closure itself does. Setting a closure property always means that you must be on the lookout for possible reference cycles.
    
//    A closure argument like this that will not escape the function’s own scope is called non-escaping.
//    You do not need to worry about closure-captured strong reference cycles with non-escaping closure arguments.
//    when a function accepts a closure argument that it might store in a property or pass to another function, the closure is called escaping.
//    An attribute – a keyword prefixed with @ – gives the compiler extra information about a variable or function declaration.
//    When an app leaks memory, that memory still counts as part of the app’s total memory usage, even though it is no longer needed or useful.
}

extension Asset: CustomStringConvertible {
    var description: String {
        if let container = container {
            return "Asset(\(name), worth \(value), in \(container))"
        } else {
            return "Asset(\(name), worth \(value), not stored anywhere)"
        }
    }
}
//A weak reference is not included in the reference count of the instance it refers to. In this case, making container a weak reference means that when you assign Vault 13 as the container of the coin and the gem, Vault 13’s reference count does not increase. The only strong reference to Vault 13 is the vault13 variable in main.swift.
//What happens to a weak reference if the instance it refers to is deallocated? The weak reference is set to nil as soon as the instance begins to deallocate
//There are two requirements for weak references:
//• Weak references must always be declared as var, not let.
//• Weak references must always be declared as optional.
//When faced with two types that want references to each other, try to determine which one is the “parent” object in the relationship. That is the object that should “own” the other object with a strong reference.
//Not all strong reference cycles are caused by objects with explicit properties referring to one another. By default, closures also keep strong references to any class instances that they capture.

// MARK: Reference Cycles with Closures

extension Asset: Equatable {
    static func == (_ lhs: Asset, _ rhs: Asset) -> Bool {
        lhs.name == rhs.name
    }
}
