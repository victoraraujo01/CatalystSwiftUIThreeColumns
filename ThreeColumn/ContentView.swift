//
//  SwiftUICatalystTests.swift
//  Pushcut
//
//  Created by Victor Araujo on 23/05/22.
//  Copyright © 2022 Simon Leeb. All rights reserved.
//

import SwiftUI

#if targetEnvironment(macCatalyst)
/// **MAC CATALYST WORKAROUND:**
/// - needed to stop Catalyst from hiding the sidebar by default
extension UISplitViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.show(.primary)
    }
}
#endif

struct ContentView: View {
    @State var selectedTab: String?
    
    var body: some View {
        NavigationView {
            SidebarFixed(selectedTab: $selectedTab)
            Text("Middle column")
            Text("Detail column")
        }
    }
}
