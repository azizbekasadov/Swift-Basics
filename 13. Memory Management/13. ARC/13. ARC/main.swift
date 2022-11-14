//
//  main.swift
//  13. ARC
//
//  Created by Azizbek Asadov on 14/11/22.
//

import Foundation

class Simulation {
    func run() {
        let vault13 = Vault(number: 13)
        print("Created \(vault13)")
        var coin: Asset = Asset(name: "Rare Coin", value: 1_000.0)
        var gem: Asset = Asset(name: "Big Diamond", value: 5_000.0)
        let poem: Asset = Asset(name: "Magnum Opus", value: 0.0)
        vault13.store(coin)
        vault13.store(gem)
        print(isKnownUniquelyReferenced(&gem))
//        You have created two strong reference cycles, which is the term for when two instances have strong references to each other.
        print("Created some assets: \([coin, gem, poem])")
        coin.value += 137
        print(vault13.remove(coin))
        print(vault13)
    }
}
let simulation = Simulation()
simulation.run()
dispatchMain()

//The Xcode Memory Graph Debugger is a great tool to use when you want to look for memory leaks. It will show you the shape of the leak (the other objects and references involved), which can help you figure out how to fix them.

// MARK: Breaking Strong Reference Cycles with weak
//The solution to a strong reference cycle is to break the cycle. You could manually break the cycles by looping over each asset and setting its container to nil while you have access to those variables (before the function ends), but that would be tedious and error prone.
//Instead, Swift provides a keyword to get the same effect automatically. Modify Asset to make the container property a weak reference instead of a strong reference.
//By default, any variable or constant of reference type is a strong reference. Closure-captured references are no different, and the strong reference exists as long as the closure does.
//Since the compiler cannot be sure that the value of a property like totalValue will not change after the closure is created, the closure instead captures the object that owns the property, so that it can access the property and read any fresh or computed value it may have.
