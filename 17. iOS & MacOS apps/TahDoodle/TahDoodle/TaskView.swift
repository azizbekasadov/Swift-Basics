//
//  TaskView.swift
//  TahDoodle
//
//  Created by Azizbek Asadov on 15/11/22.
//

import SwiftUI

struct TaskView: View {
    let title: String
    
    var body: some View {
        Text(title)
//            .padding(.vertical, 20)
            .font(.title3)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(title: "My Best List")
    }
}

//A view is an instance of a value type that conforms to the View protocol, which has only two requirements:
//    public protocol View {
//        associatedtype Body : View
//        @ViewBuilder var body: Self.Body { get }
//    }

//Every view has a body that is also a view, and you build a SwiftUI app by composing a view hierarchy of SwiftUI views, your own views, and the relationships among them.

//A hierarchy of views, with each of their bodies returning an instance of a different View-conforming associated type, can get very deep and complex. To spare you the gritty details of deep view hierarchy types, the body property is declared as returning the some View opaque type.

//PreviewProvider enables a type to be rendered in Xcode’s preview canvas. Xcode will search your file for a type conforming to PreviewProvider and use it to generate a preview of the view returned by its static previews property. Here, you return an instance of your TaskView type.

//Modifiers are methods that return a new type of view, creating a nested hierarchy. Here, you apply the padding(_:_:) modifier to the Text instance, which creates and returns a new view that contains the Text as its child view, with 50 points of padding above and below the Text. Then, you apply the background(_:) modifier to the padding view, which paints the entire padding view and its child view (the Text) with a yellow background.

//The order of modifiers is important, because it affects the resulting hierarchy. Move the background(_:) modifier to be applied before the padding(_:_:) modifier.

// MARK: Displaying Dynamic Data
