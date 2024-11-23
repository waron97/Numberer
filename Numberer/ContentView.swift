//
//  ContentView.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    @Environment(\.scenePhase) var scenePhase
    @State var stateLoaded = false

    var body: some View {
        NavRoot().environmentObject(appState).task {
            do {
                if let restoredState = try await StatePersister().load() {
                    appState.profiles = restoredState.profiles
                    appState.presets = restoredState.presets
                } else {
                    print("No state to restore")
                }
            } catch {
                print("No state to restore")
            }
        }.onChange(of: scenePhase) { _, phase in
            if (phase == .inactive) {
                StatePersister.persistState(appState)
            }
        }
    }
}

#Preview {
    ContentView()
}
