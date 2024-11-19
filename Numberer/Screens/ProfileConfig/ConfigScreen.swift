//
//  ConfigScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct ConfigScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var selected: Int = 0
    @State private var newName: String = ""

    func styled(background: Color = Color("PickerBg"), content: () -> some View)
        -> some View
    {
        return content()
            .padding(12).background(background)
            .cornerRadius(20)

    }

    func handleCreate() {
        appState.profiles.append(
            Profile(
                label: newName, type: .plain, lower: 1, upper: 20,
                useExclude: false))
        selected = appState.profiles.count - 1
        newName = ""
    }

    func handleDelete() {
        if appState.profiles.count > 1 {
            appState.profiles.remove(at: selected)
            selected =
                selected >= appState.profiles.count ? selected - 1 : selected
        }

    }

    func renderNewProfile() -> some View {
        return VStack {
            styled {
                VStack {
                    TextField(
                        "Nome del nuovo profilo", text: $newName
                    )
                }
            }
            styled(background: .green) {
                Button(action: handleCreate) {
                    Label("Crea profilo", systemImage: "plus")
                        .foregroundColor(.white).frame(
                            maxWidth: .infinity)
                }.frame(maxWidth: .infinity)
            }.padding(.top)
        }.padding()
    }

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Profilo", selection: $selected) {
                    ForEach(appState.profiles.indices, id: \.self) {
                        index in
                        let profile = appState.profiles[index]
                        Text(
                            profile.label
                        ).tag(index)
                    }
                    Text("Nuovo profilo").tag(-1)
                }.pickerStyle(.menu)
                Divider()
                VStack {
                    if selected == -1 {
                        renderNewProfile()
                    } else {
                        Picker(
                            "Tipologia",
                            selection: $appState.profiles[selected].type
                        ) {
                            Text("Singolo").tag(ProfileType.plain)
                            Text("Slot").tag(ProfileType.roulette)
                        }.pickerStyle(.segmented).padding(24)

                        if appState.profiles[selected].type == .plain {

                            SingleGeneratorConfig(
                                profile: $appState.profiles[selected],
                                handleDelete: handleDelete).padding(.horizontal, 24)

                        } else {
                            SlotGeneratorConfig(
                                profile: $appState.profiles[selected],
                                handleDelete: handleDelete)

                        }

                    }

                }
            }

        }
    }
}

#Preview {
    @Previewable @StateObject var appState = AppState()
    ConfigScreen().environmentObject(appState)
}
