//
//  SidebarFixed.swift
//  ThreeColumn
//
//  Created by Victor Araujo on 11/07/22.
//

/**
**What still doesn't work correctly:**
 - Scroll (elements go underneath the header and title bar drop shadow is not displayed)
 - Appearance of selection inside the sidebar (not being rendered using accentColor, probably because
   the sidebar list is not getting the focus when clicked).
 - Top margin of the sidebar is not the same as on the native macOS target.
*/
import SwiftUI
import Foundation

struct CatalystSidebarItem: ViewModifier {
    func body(content: Content) -> some View {
        content
            #if targetEnvironment(macCatalyst)
            /// **MAC CATALYST WORKAROUND:**
            /// - just fixing the padding of the sidebar list elements
            .listRowInsets(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
            #endif
    }
}

struct CatalystSidebarHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            #if targetEnvironment(macCatalyst)
            /// **MAC CATALYST WORKAROUND:**
            /// - just fixing the positioning of the sidebar headers
            .listRowInsets(EdgeInsets(top: 18, leading: 8, bottom: 4, trailing: 8))
            #endif
    }
}

extension View {
    func catalystSidebarItem() -> some View {
        modifier(CatalystSidebarItem())
    }
    
    func catalystSidebarHeader() -> some View {
        modifier(CatalystSidebarHeader())
    }
}

struct SidebarFixed: View {
    @FocusState private var isSidebarFocused: Bool
    @Binding var selectedTab: String?
    
    var body: some View {
        List {
            Section {
                Text("Middle column")
                    .catalystSidebarItem()
                    /// **MAC CATALYST WORKAROUND:**
                    /// - NavigationLink must be on the items background in order to hide the chevron
                    .background {
                        NavigationLink(tag: "A", selection: $selectedTab) {
                            MiddleColumnFixedSelection()
                        } label: {
                            EmptyView()
                        }
                    }
                
                Text("Section B")
                    .catalystSidebarItem()
                    /// **MAC CATALYST WORKAROUND:**
                    /// - NavigationLink must be on the items background in order to hide the chevron
                    .background {
                        NavigationLink(tag: "B", selection: $selectedTab) {
                            Text("Section B is selected")
                        } label: {
                            EmptyView()
                        }
                    }
            } header: {
                Text("First Header")
                    .catalystSidebarHeader()
            }
            
            Section {
                Text("Section C")
                    .catalystSidebarItem()
                    /// **MAC CATALYST WORKAROUND:**
                    /// - NavigationLink must be on the items background in order to hide the chevron
                    .background {
                        NavigationLink(tag: "C", selection: $selectedTab) {
                            Text("Section C is selected")
                        } label: {
                            EmptyView()
                        }
                    }
            } header: {
                Text("Second Header")
                    .catalystSidebarHeader()
            }
            
            Text("Sidebar is \(isSidebarFocused ? "" : "not ")focused")
                .catalystSidebarItem()
        }
        .focused($isSidebarFocused)
        #if targetEnvironment(macCatalyst)
        /// **MAC CATALYST WORKAROUND:**
        /// - Needed to set the .plain list style because the .sidebar list style adds
        ///   unconventional left/right padding and applies prominent headers (as of macOS 12.4).
        .listStyle(.plain)
        .navigationBarHidden(true)
        #endif
    }
}

