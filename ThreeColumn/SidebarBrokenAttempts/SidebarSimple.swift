//
//  SidebarNormal.swift
//  ThreeColumn
//
//  Created by Victor Araujo on 11/07/22.
//

import SwiftUI
import Foundation

/**
**Doesn't work correctly:**
 - Sidebar Headers (which cannot be changed with the .headerProminence modifier)
 - Vertical spacing between sidebar sections
 - Padding between the sidebar and the selection rounded rectangle
 - Appearance of selection inside the sidebar (not being rendered using accentColor)
*/
struct SidebarSimple: View {
    @Binding var selectedTab: String?
    
    var body: some View {
        List {
            Section {
                NavigationLink(tag: "A", selection: $selectedTab) {
                    Text("Section A is selected")
                } label: {
                    Text("Section A")
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
        }
        .listStyle(.sidebar)
        
        #if targetEnvironment(macCatalyst)
        .navigationBarHidden(true)
        #endif
    }
}

