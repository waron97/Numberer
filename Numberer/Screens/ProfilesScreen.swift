//
//  ProfilesScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct ProfilesScreen: View {
    @EnvironmentObject var appState: AppState
    
    func handleMove(_ from: Int, _ to: Int) {
        
    }

    var body: some View {
        NavigationSplitView {
            List(appState.profiles, id: \.key) { profile in
                NavigationLink {
                    if profile.type == .plain {
                        PlainGeneratorScreen(profile.key)
                    } else if profile.type == .roulette {
                        RouletteGeneratorScreen(profile: profile)
                    }
                } label: {
                    ProfileRow(profile: profile)
                }
            }.navigationTitle("Seleziona profilo")
                .navigationBarTitleDisplayMode(.inline)
        } detail: {
            Text("Select a profile")
        }
    }
}

#Preview {
    @Previewable @StateObject var appState = AppState()
    ProfilesScreen().environmentObject(appState)
}
