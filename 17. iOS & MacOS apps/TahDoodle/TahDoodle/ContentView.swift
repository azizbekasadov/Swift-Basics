//
//  ContentView.swift
//  TahDoodle
//
//  Created by Azizbek Asadov on 15/11/22.
//

import SwiftUI

struct ContentView: View {
    let taskStore: TaskStore
    
    var body: some View {
        VStack {
            NewTaskView(taskStore: taskStore)
            TaskListView(taskStore: taskStore)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(taskStore: .sample)
    }
}

//ContentView. It is merely a View that comes as a part of the SwiftUI App template, whose name makes it a good top-level view for your hierarchy.

//When you need to compose multiple children of a view (such as a button, a text input field, and a list), it can be useful to factor a subset of the children into a helper property of the owning view. To see what this looks like, add a newTaskView property to the ContentView.

//As you saw previously, the List type is designed to arrange any number of child views in a scrolling list. That is not what you want for the newTaskView and TaskListView, because you do not want the controls in the newTaskView to ever be offscreen. SwiftUI also offers three stacking types that allow you to arrange a few views to fill the available space:

//HStack -> Arranges its children in a horizontal row, like framed pictures on a shelf.
// VStack -> Creates a vertical stack similar to a List, but without scrolling.
//ZStack -> Creates a stack of views arranged like cards piled on a table, where those higher in the stack are in front of (and can cover up) views lower in the stack. A ZStack is most useful when the views in the stack have different geometries or opacities, to allow those in the back to show.

// MARK: Sharing references to value-type data
//Now you can add a text field for the user to type their new task’s title in. Create a TextField and embed it, along with the Button, in an HStack
//The TextField type represents a single-line text input control. When the user taps it, a keyboard is presented, allowing them to enter text in the text field. The first argument to this TextField initializer is the placeholder text, which appears in a faded color to show the user where they can type.

//The newTaskTitle uses an instance of the State property wrapper struct to manage its value, as indicated by the @State property wrapper attribute. The property wrapper will store your string in its wrappedValue and return it any time you access your newTaskTitle property.
//The @State property wrapper lends your SwiftUI code some very important features. Any time a @State property’s value changes, the owning view will invalidate itself, which tells SwiftUI to re- create the view and redraw it on the screen. This process re-creates and redraws any of the view’s children as well

//Because newTaskTitle is marked @State, any time its value changes, the ContentView will be invalidated and re-created. That process will re-create the TextField and Button as well – and as the Button is re-created, so is its action closure, which captures an up-to-date copy of the newTaskTitle string to use.

//Since String is a value type, passing a string to the TextField would pass an immutable copy of the value, preventing the TextField from updating your newTaskTitle as the user types. SwiftUI solves this problem with a type related to the @State property wrapper called Binding.

//Binding provides a similar behavior – bidirectional access to a value stored elsewhere – but for stored properties instead of functions.
//This way, the object with the binding can reach back to the value’s owner and modify the original value, rather than a copy of it.
//The projected value of a @State property returns
//an instance of Binding holding a reference to the property’s wrapped value. So when you pass $newTaskTitle to the text argument of the TextField initializer, you are not passing the string itself, but a binding to it. Any time the text in the text field changes, the text field will use this binding to update the value of newTaskTitle.

//What does the text field actually do with the binding you give it? When a view wants a property to hold a reference to value-type data that it does not own, it can declare its property using the @Binding property wrapper attribute, as TextField does for its text
//Ex.  @Binding private var text: String

//SwiftUI does a great deal of work to ensure that the invalidation and redrawing process is as fast and lightweight as possible. The @State and @Binding property wrappers give SwiftUI views the best of two worlds: the shared data access of reference types with the optimizations available to value types.

//The disabled(_:) modifier accepts any Boolean expression. If the expression is true, then the
//modified view will be disabled until it is invalidated and redrawn, evaluating the expression anew.

// The button’s action closure, which instantiates the new Task instance, does not need persistent bidirectional access to newTaskTitle, like the text field does. When the button is tapped, its
//action closure will execute once, creating a new task instance with whatever the current value of newTaskTitle happens to be.

// MARK: Interlude: Troubleshooting with property observers
//There is your new task, so you can rule out the button and the task store as the source of the problem. That means the list is not updating when the task store does. You will fix this shortly by changing the task store to publish its updates in a way the list can observe, so that the list knows to update as well.

// MARK: Observing Changes to the Store (Observers ~ Listeners)

