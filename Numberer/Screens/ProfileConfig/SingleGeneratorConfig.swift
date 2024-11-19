//
//  SingleGeneratorConfig.swift
//  Numberer
//
//  Created by Aron Winkler on 18/11/24.
//

import SwiftUI

struct SingleGeneratorConfig: View {
    @Binding public var profile: Profile
    var handleDelete: () -> Void

    func styled(background: Color = Color("PickerBg"), content: () -> some View)
        -> some View
    {
        return content()
            .padding(12).background(background)
            .cornerRadius(20)

    }
    
    private struct PresetLists: View {
        @Binding var selectedPresets: [String]
        @EnvironmentObject private var appState: AppState

        func getIsSelected(_ preset: String) -> Bool {
            for p in selectedPresets {
                if p == preset {
                    return true
                }
            }
            return false
        }

        func togglePreset(_ p: String) {
            if getIsSelected(p) {
                selectedPresets.removeAll { key in
                    return key == p
                }
            } else {
                selectedPresets.append(p)
            }
        }

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(appState.presets.indices, id: \.self) { idx in
                        let preset = appState.presets[idx]
                        let isSelected = getIsSelected(preset.key)
                        HStack {
                            Text(preset.name)
                        }.padding(.horizontal, 10).padding(.vertical, 4)
                            .background(
                                Rectangle().fill(
                                    isSelected ? .green : Color("PickerBg")
                                ).cornerRadius(8)
                            ).onTapGesture {
                                togglePreset(preset.key)
                            }
                    }
                }
            }
        }
    }

    var body: some View {
        VStack(spacing: 24) {
            styled {
                Picker(
                    "Limite inferiore",
                    selection: $profile.lower
                ) {
                    ForEach(1..<101) { option in
                        Text("\(option)").tag(option)
                    }
                }.pickerStyle(.navigationLink)
                    .foregroundStyle(
                        .primary)
            }

            styled {
                Picker(
                    "Limite superiore",
                    selection: $profile.upper
                ) {
                    ForEach(1..<101) { option in
                        Text("\(option)").tag(option)
                    }
                }.pickerStyle(.navigationLink)
                    .foregroundStyle(
                        .primary)
            }
            styled {
                Toggle(
                    "Escludi numeri già generati",
                    isOn: $profile.useExclude)
            }
            Spacer()
            styled(background: .red) {
                Button(action: handleDelete) {
                    Label(
                        "Elimina profilo",
                        systemImage: "trash.fill"
                    )
                    .foregroundColor(.white)
                }.frame(maxWidth: .infinity)
            }.padding(.top)
        }
    }
}
