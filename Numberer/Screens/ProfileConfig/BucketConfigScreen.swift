//
//  BucketConfigScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 18/11/24.
//

import SwiftUI

struct BucketConfigScreen: View {
    @Binding var bucket: Bucket
    @EnvironmentObject var appState: AppState
    @State private var newName: String = ""
    

    private struct PresetSelector: View {
        @Binding var presets: [String]
        @EnvironmentObject var appState: AppState

        var selectedColor = Color(red: 51 / 255, green: 1.0, blue: 69 / 255)

        func getIsSelected(_ preset: String) -> Bool {
            for p in presets {
                if p == preset {
                    return true
                }
            }
            return false
        }

        func togglePreset(_ preset: String) {
            let isSelected = getIsSelected(preset)
            if isSelected {
                presets.removeAll { p in
                    return p == preset
                }
            } else {
                presets.append(preset)
            }
        }

        func renderRow(_ preset: PresetList, _ isSelected: Bool) -> some View {
            return HStack(spacing: 24) {
                Label(preset.name, systemImage: "checkmark").labelStyle(
                    .titleOnly
                ).foregroundStyle(.foreground).frame(
                    maxWidth: .infinity, alignment: .leading)
                Image(systemName: "checkmark").foregroundStyle(.white)
                    .background(
                        Circle().fill(.green).frame(width: 24, height: 24)).opacity(isSelected ? 1 : 0)
            }
        }

        var body: some View {
            Section {
                ForEach(appState.presets.indices, id: \.self) { idx in
                    let preset = appState.presets[idx]
                    let isSelected = getIsSelected(preset.key)
                    Button {
                        togglePreset(preset.key)
                    } label: {
                        renderRow(preset, isSelected)
                    }
                }
            } header: {
                Text("Liste predefinite").padding(.bottom, 6)
            }
        }
    }
    
    

    var body: some View {
        List {
            Section {
                ForEach($bucket.customItems, id: \.self, editActions: .delete) {
                    $item in
                    Text(item)
                }
                HStack(spacing: 24) {
                    TextField("Nuovo elemento", text: $newName).frame(
                        maxWidth: .infinity)
                    Button {
                        bucket.customItems.append(newName)
                        newName = ""
                    } label: {
                        Label("Conferma", systemImage: "plus").labelStyle(
                            .iconOnly)
                    }
                }.deleteDisabled(true)
            } header: {
                Text("Elementi personalizzati").padding(.bottom, 6)
            }

            PresetSelector(presets: $bucket.presets)
        }
    }
}
