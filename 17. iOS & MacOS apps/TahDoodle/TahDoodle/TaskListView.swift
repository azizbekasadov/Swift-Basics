//
//  TaskListView.swift
//  TahDoodle
//
//  Created by Azizbek Asadov on 15/11/22.
//
import SwiftUI
struct TaskListView: View {
    @ObservedObject var taskStore: TaskStore // Listener
//    The @ObservedObject property wrapper sets up the subscription to the @Published properties of an ObservableObject-conforming class. When the @Published properties update, the owning view (here, the TaskListView) will invalidate itself, just as it would with changes to a @State property.
    
//    Why the TaskListView and not the ContentView? Either would work. But invalidating the entire ContentView would be wasteful, as you don’t need the button and text field to also invalidate.
//    The TaskListView is the closest view to the List itself in the hierarchy that has a reference to the TaskStore. Invalidating the TaskListView invalidates as little of your hierarchy as possible while still getting the desired effect: a List refresh.
    
    var body: some View {
        List {
            ForEach(taskStore.tasks) { task in
                TaskView(title: task.title)
                    // MARK: Bronze Challenge
                #if os(macOS)
                    .contextMenu {
                        Button("Delete") {
                            taskStore.remove(task)
                        }
                    }
                #endif
                
//                The contextMenu(_:) modifier accepts a view builder closure containing views that will be used as the menu options for a right-click (or long-press, on iOS) contextual menu.
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let task = taskStore.tasks[index]
                    taskStore.remove(task)
                }
            }
            .animation(.easeOut, value: 1)
        }
        
//        Lists of user-editable content in iOS can allow the user to swipe across an item from right to left to reveal a Delete button. Tapping it removes that item from the list. To support this swipe-to-delete behavior, add an onDelete(_:) modifier to the ForEach that feeds the List:
    }
}

struct TaskListView_Preview: PreviewProvider {
    static var previews: some View {
        TaskListView(taskStore: .sample)
    }
}

//That strange List creation syntax is using a view builder
//Computed properties and function parameters of closure type can be marked with the @ViewBuilder attribute to allow syntax like what you use here: a newline-delimited (instead of comma-delimited) list of SwiftUI views that are automatically collected as children of the type the closure is passed to

// List init signature => init(@ViewBuilder content: () -> Content)
//Content is the generic placeholder for the type of the list’s content view. You are passing a view builder closure to the List initializer using trailing closure syntax.

//When the ForEach is filling the List’s view builder, it wants a way to uniquely identify each instance of Task, so it can track them even when their properties change. Swift’s Identifiable protocol exists to fill this need. Make Task conform to Identifiable:

//Why Identifiable and not Hashable, like dictionaries and sets use for testing uniqueness? Internally, the list will tie a task’s id to a row index for positioning its children. This has two consequences:
//• One instance’s id must never collide with another, or the List might accidentally order its children incorrectly when it updates. Recall from Chapter 25 that hash values are not guaranteed to be unique. They are only likely to be unique within a sample, to balance the performance of lookups in sets and dictionaries.
//• An instance’s id must be stable; it should not change when the instance’s other properties change. That way, the list can maintain correct ordering. As you have learned, the implementations of equality and hashability are generally data dependent and would produce different results before and after an instance’s essential data changed.
