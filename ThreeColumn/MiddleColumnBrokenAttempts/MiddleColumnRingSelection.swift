//
//  MiddleColumnSimple.swift
//  ThreeColumn
//
//  Created by Victor Araujo on 11/07/22.
//

/**
**Doesn't work correctly:**
 - Row separators are hidden when view is first shown, but alternating between items of the sidebar makes them appear again. the .listRowSeparator modified does not work for the whole list. When applied to the list elements, partially work but doesn't hide the separators that appear below the end of the list
 - Appearance of selection rectangle (expected to be a rounded rectangle and change foreground color to white)
 - Horizontal padding between the list and the selection rectangle
 - When a new element is added and the NavigationLink selection binding is updated
*/
import Foundation
import SwiftUI

struct MiddleColumnRingSelection: View {
    @FocusState private var isListFocused: Bool
    @State var selectedItem: String?
    @State var elements = Array(1...10)

    var body: some View {
        List(elements, id: \.self) { element in
            NavigationLink(tag: "\(element)", selection: $selectedItem) {
                Text("Element \(element)")
            } label: {
                Text("Element \(element)")
            }
            #if targetEnvironment(macCatalyst)
            .listRowSeparator(.hidden)
            #endif
        }
        .focused($isListFocused)
        #if targetEnvironment(macCatalyst)
        .navigationBarHidden(true)
        #endif
        
        Text(isListFocused ? "List is focused" : "List is not focused")
        Button {
            let newElement = elements.randomElement()!
            selectedItem = "\(newElement)"
        } label: {
            Text("Select random element")
        }
        
        Button {
            let newElement = Int.random(in: 0...100)
            elements.append(newElement)
            selectedItem = "\(newElement)"
        } label: {
            Text("Add and select new element")
        }
    }
}
