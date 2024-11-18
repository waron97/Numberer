//
//  PresetsConfigScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 18/11/24.
//

import SwiftUI

struct PresetsConfigScreen: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView {
            NavigationLink {
                PresetEditor(presetKey:"").navigationTitle("Nuova lista")
            } label: {
                Text("Nuova lista predefinita").fontWeight(.bold).frame(
                    maxWidth: .infinity
                )
                .frame(width: .infinity, height: 48).background(.green)
                .foregroundStyle(
                    .white
                ).cornerRadius(20)
            }
            
            Divider().padding(.vertical, 6)

            VStack {
                ForEach(appState.presets, id: \.key) { preset in
                    NavigationLink {
                        PresetEditor(presetKey: preset.key).navigationTitle("\(preset.name)")
                    } label: {
                        Text(preset.name).fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(width: .infinity, height: 48).background(
                                .blue
                            ).foregroundStyle(
                                .white
                            ).cornerRadius(20)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding().navigationTitle("Configura presets")
    }
}

#Preview {
    PresetsConfigScreen()
}
