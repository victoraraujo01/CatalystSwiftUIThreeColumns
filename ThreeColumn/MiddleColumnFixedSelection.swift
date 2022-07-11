//
//  MiddleColumnFixedSelection.swift
//  ThreeColumn
//
//  Created by Victor Araujo on 11/07/22.
//

/**
**What still doesn't work correctly:**
 - Row separators are hidden when view is first shown, but alternating between items of the sidebar makes them appear again.
   The .listRowSeparator modified does not work for the whole list. When applied to the list elements, it partially works but
   doesn't hide the separators that appear below the end of the list (can only be fixed with SwiftUI-Introspect).
*/
import Foundation
import SwiftUI

struct CatalystListItem: ViewModifier {
    var isSelected: Bool
    var isListFocused: Bool
    
    func body(content: Content) -> some View {
        content
            #if targetEnvironment(macCatalyst)
            /// **MAC CATALYST WORKAROUND:**
            /// - need to set a custom row background in order to replicate the correct background appearance
            ///   of selections on the middle column on macOS. If this is not implemented, Catalyst renders a
            ///   square with some strange "ring-like" selections when list is not focused.
            .foregroundColor(isSelected ? (isListFocused ? Color.white : Color.primary) : Color.primary)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(isSelected ? (isListFocused ? Color.blue : Color(UIColor.systemFill)) : Color(UIColor.systemBackground))
            )
            /// **MAC CATALYST WORKAROUND (currently not working):**
            /// - this was an attempt to hide the list separator but it does not hide the separators created automatically
            ///   by Catalyst between the last element of the list and the bottom of the window
            .listRowSeparator(.hidden)
            /// **MAC CATALYST WORKAROUND:**
            /// - just fixing the padding of the list elements
            .listRowInsets(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            #endif
    }
}

extension View {
    func catalystListItem(isSelected: Bool, isListFocused: Bool) -> some View {
        modifier(CatalystListItem(isSelected: isSelected, isListFocused: isListFocused))
    }
}

// MARK: - Middle Column Implementation

struct MiddleColumnFixedSelection: View {
    @FocusState private var isListFocused: Bool
    @State var selectedItem: String?
    @State var elements = Array(1...10)

    var body: some View {
        ScrollViewReader { proxy in
            List(elements, id: \.self) { element in
                Text("Element \(element)")
                    .catalystListItem(isSelected: selectedItem == "\(element)", isListFocused: isListFocused)
                    /// **MAC CATALYST WORKAROUND:**
                    /// - NavigationLink must be on the items background in order to hide the chevron
                    .background {
                        NavigationLink(tag: "\(element)", selection: $selectedItem) {
                            Text("Element \(element)")
                        } label: {
                            EmptyView()
                        }
                    }
            }
            .onChange(of: selectedItem) { newValue in
                guard let element = Int(newValue ?? "1") else { return }
                proxy.scrollTo(element)
            }
            /// **MAC CATALYST WORKAROUND:**
            /// - need to track if list is focused in order to correctly render the selected item's background
            .focused($isListFocused)
            #if targetEnvironment(macCatalyst)
            /// **MAC CATALYST WORKAROUND:**
            /// - need to reset list style (setting to .plain) in order to apply the correct padding to the middle column
            .listStyle(.plain)
            .padding(10)
            .navigationBarHidden(true)
            #endif
        }
        
        Text(isListFocused ? "List is focused" : "List is not focused")
        
        Button {
            let newElement = elements.count + 1
            elements.append(newElement)
            selectedItem = "\(newElement)"
        } label: {
            Text("Add and select new element")
        }
    }
}
