//
//  TahDoodleApp.swift
//  TahDoodle
//
//  Created by Azizbek Asadov on 15/11/22.
//

import SwiftUI

@main
struct TahDoodleApp: App {
    let taskStore = TaskStore()
    
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            ContentView(taskStore: taskStore)
                            .frame(minWidth: 200,
                                   maxWidth: 300,
                                   minHeight: 200)
            #else
            ContentView(taskStore: taskStore)
            #endif
        }
    }
    
//    You use the #if compiler control statement to ensure that the lines up to the subsequent #else statement are only compiled when building for macOS. Lines between the #else and the #endif statements will only be included when you are building for a different OS, which in this case would be iOS.
//    In the macOS-only block, you add a frame(...) modifier to specify constraints on the size of the window. The modifier accepts lots of arguments for size restrictions, but you only need to include the ones you want to deviate from the default.

}

// MARK: Accepting User Input
