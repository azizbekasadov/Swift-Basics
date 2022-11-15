//
//  NewTaskView.swift
//  TahDoodle
//
//  Created by Azizbek Asadov on 15/11/22.
//

import SwiftUI

// MARK: Silver Challenge
struct NewTaskView: View {
    let taskStore: TaskStore
    @State var newTaskTitle: String = ""
    
    var body: some View {
        HStack {
            TextField("Something to do", text: $newTaskTitle)
            Button("Add Task") {
                let task = Task(title: newTaskTitle)
                taskStore.add(task)
                newTaskTitle = ""
//                Note that this assignment to newTaskTitle will, as before, invalidate the content view, causing the button and text field to be redrawn (empty this time).
            }.disabled(newTaskTitle.isEmpty)
        }.padding()
    }
}
