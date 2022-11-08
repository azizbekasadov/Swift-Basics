//
//  Mayor.swift
//  MonsterTown
//
//  Created by Azizbek Asadov on 09/11/22.
//

// Silver Challenge
import Foundation

struct Mayor {
    private var anxietyLevel: Int = 0 // Gold Challenge
    
    mutating func increaseAnxietyLevel() {
        anxietyLevel += 1
    }
    
    func showMessage() {
        print("I'm deeply saddened to hear about this latest tragedy. I promise that my office is looking into the nature of this rash of violence.")
    }
}
