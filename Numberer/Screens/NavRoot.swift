//
//  NavRoot.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct NavRoot: View {
    var body: some View {
        TabView {
            ProfilesScreen().tabItem {
                Label("Generatore", systemImage: "number")
            }
            
            ConfigScreen().tabItem {
                Label("Impostazioni", systemImage: "desktopcomputer")
            }
        }
    }
}

#Preview {
    NavRoot()
}
