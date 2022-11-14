//
//  Vault.swift
//  13. ARC
//
//  Created by Azizbek Asadov on 14/11/22.
//

import Foundation

class Vault {
    let number: Int
    private(set) var assets = [Asset]()
    
    // MARK: Tin Challenge
    var totalValue: Double {
        var result: Double = 0.0
        assets.forEach {
            result += $0.value
        }
        return result
    }
    
    init(number: Int) {
        self.number = number
    }
    deinit {
        print("\(self) is being deallocated")
    }
    
    //Bronze Challenge
    func remove(_ asset: Asset) -> Asset? {
        guard let index = assets.firstIndex(of: asset) else {
            return nil
        }
        
        return assets.remove(at: index)
    }
    
    func store(_ asset: Asset) {
        asset.container = self
        asset.changeHandler = { [weak self, weak asset] (change) in
            print("\(String(describing: asset)) has changed value by \(change). New total value: \(String(describing: self?.totalValue))")
        }
//        // Use of a capture list
//        asset.changeHandler = { [self] (change) in
//            print("An asset has changed value by \(change). New total value: \(totalValue)")
//        }
        assets.append(asset)
    }
}

extension Vault: CustomStringConvertible {
    var description: String {
        return "Vault(\(number))"
    }
}

//The #warning expression is special. It causes a compiler warning with the specified message. There is also an #error expression to force a compiler error. These expressions are very handy when you are deep in code and need to leave yourself a reminder to come back and fix or finish something.
//To change the capture semantics of a closure to capture references weakly, you can use a capture list.

//Prior to the introduction of Swift in 2014, macOS and iOS applications were written in Objective-C, with some C and possibly even C++. ARC was introduced for Objective-C in 2011.
//class SomeOtherClass { }
//
//class SomeClass {
//    private var someObject = SomeOtherClass()
//    
//    func setSomeObject(newObject: SomeOtherClass) {
//        // Increment ref count of new instance to keep it alive
//        newObject.retain()
//        // Decrement ref count of old instance; it might deallocate
//        someObject.release()
//        // Actually assign our property to refer to the new instance
//        someObject = newObject
//    }
//}
//
//SomeClass().setSomeObject(newObject: SomeOtherClass())
