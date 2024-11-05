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
            selected = selected >= appState.profiles.count ? selected - 1 : selected
        }
        
    }

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Profilo", selection: $selected) {
                    ForEach(appState.profiles.indices, id: \.self) { index in
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
                        styled {
                            VStack {
                                TextField(
                                    "Nome del nuovo profilo", text: $newName)
                            }
                        }
                        styled(background: .green) {
                            Button(action: handleCreate) {
                                Label("Crea profilo", systemImage: "check")
                                    .foregroundColor(.white)
                            }.frame(maxWidth: .infinity)
                        }.padding(.top)

                    } else {
                        Picker(
                            "Tipologia",
                            selection: $appState.profiles[selected].type
                        ) {
                            Text("Singolo").tag(ProfileType.plain)
                            Text("Slot").tag(ProfileType.roulette)
                        }.pickerStyle(.segmented)
                        styled {
                            Picker(
                                "Limite inferiore",
                                selection: $appState.profiles[selected].lower
                            ) {
                                ForEach(1..<101) { option in
                                    Text("\(option)").tag(option)
                                }
                            }.pickerStyle(.navigationLink).foregroundStyle(.primary)
                        }.padding(.top)
                        styled {
                            Picker(
                                "Limite superiore",
                                selection: $appState.profiles[selected].upper
                            ) {
                                ForEach(1..<101) { option in
                                    Text("\(option)").tag(option)
                                }
                            }.pickerStyle(.navigationLink).foregroundStyle(.primary)
                        }
                        styled {
                            Toggle("Escludi numeri già generati", isOn: $appState.profiles[selected].useExclude)
                        }
                        Spacer()
                        styled(background: .red) {
                            Button(action: handleDelete) {
                                Label("Elimina profilo", systemImage: "check")
                                    .foregroundColor(.white)
                            }.frame(maxWidth: .infinity)
                        }.padding(.top)
                    }

                }.frame(maxHeight: .infinity, alignment: .top).padding()
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var appState = AppState()
    ConfigScreen().environmentObject(appState)
}
