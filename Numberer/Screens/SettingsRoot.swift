//
//  SettingsRoot.swift
//  Numberer
//
//  Created by Aron Winkler on 18/11/24.
//

import SwiftUI

struct SettingsRoot: View {
    func styled(_ content: () -> some View) -> some View {
        return content().padding(.vertical, 12).fontWeight(.semibold).font(
            .system(size: 18))
    }

    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    ConfigScreen()
                } label: {
                    styled {
                        Text("Profili")
                    }
                }
                NavigationLink {
                    PresetsConfigScreen()
                } label: {
                    styled {
                        Text("Preset")
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var appState = AppState()
    SettingsRoot().environmentObject(appState)
}
