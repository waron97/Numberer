//
//  NavRoot.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct NavRoot: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            ProfilesScreen().tabItem {
                Label("Generatore", systemImage: "number")
            }
            
            SettingsRoot().tabItem {
                Label("Impostazioni", systemImage: "desktopcomputer")
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var appState = AppState()
    NavRoot().environmentObject(appState)
}
