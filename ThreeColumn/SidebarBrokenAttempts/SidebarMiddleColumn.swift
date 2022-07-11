//
//  SidebarMiddleColumn.swift
//  ThreeColumn
//
//  Created by Victor Araujo on 11/07/22.
//

/**
**Fixes:**
 - Prominence of the headers
 - Padding between the sidebar and the selection rounded rectangle
**Doesn't work correctly:**
 - Scroll (elements go underneath the header and title bar drop shadow is not displayed)
 - Reverts to default behavior of displaying chevrons for each NavigationLink
 - Vertical spacing between sidebar sections
 - Padding inside the selection rounded rectangle
 - Appearance of selection inside the sidebar (not being rendered using accentColor)
*/
import SwiftUI
import Foundation

struct SidebarMiddleColumn: View {
    @FocusState private var isSidebarFocused: Bool
    @Binding var selectedTab: String?
    
    var body: some View {
        List {
            Section {
                NavigationLink(tag: "A", selection: $selectedTab) {
                    MiddleColumnRingSelection()
                } label: {
                    Text("Middle column")
                }
                NavigationLink(tag: "B", selection: $selectedTab) {
                    Text("Section B is selected")
                } label: {
                    Text("Section B")
                }
            } header: {
                Text("First Header")
            }
            
            Section {
                NavigationLink(tag: "C", selection: $selectedTab) {
                    Text("Section C is selected")
                } label: {
                    Text("Section C")
                }
            } header: {
                Text("Second Header")
            }
            
            Text("Sidebar is \(isSidebarFocused ? "" : "not ")focused")
        }
        .focused($isSidebarFocused)
        /// **MAC CATALYST WORKAROUND:**
        /// - Needed to set the .plain list style because the .sidebar list style adds unconventional
        ///   left/right padding and applies only prominent headers (as of macOS 12.4).
        .listStyle(.plain)
        
        #if targetEnvironment(macCatalyst)
        .navigationBarHidden(true)
        #endif
    }
}

