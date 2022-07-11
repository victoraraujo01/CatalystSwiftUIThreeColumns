//
//  MiddleColumnSimple.swift
//  ThreeColumn
//
//  Created by Victor Araujo on 11/07/22.
//

/**
**Doesn't work correctly:**
 - Row separators are hidden when view is first shown, but alternating between items of the sidebar makes them appear again. the .listRowSeparator modified does not work for the whole list.
 - Appearance of selection rectangle (expected to be a rounded rectangle and change foreground color to white)
 - Selection indicator is not the expected rounded rectangle and foreground color is not being changed
 - Horizontal padding between the list and the selection rectangle
*/
import Foundation
import SwiftUI

struct MiddleColumnSimple: View {
    @FocusState private var isListFocused: Bool
    @State var selectedItem: String?

    var body: some View {
        List {
            NavigationLink(tag: "First", selection: $selectedItem) {
                Text("First")
            } label: {
                Text("First")
            }

            NavigationLink(tag: "Second", selection: $selectedItem) {
                Text("Second")
            } label: {
                Text("Second")
            }

            Text(isListFocused ? "List is focused" : "List is not focused")
        }
        .focused($isListFocused)
        #if targetEnvironment(macCatalyst)
        .navigationBarHidden(true)
        #endif
    }
}
