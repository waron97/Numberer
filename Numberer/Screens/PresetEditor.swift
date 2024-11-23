//
//  PresetEditor.swift
//  Numberer
//
//  Created by Aron Winkler on 18/11/24.
//

import SwiftUI

struct PresetEditor: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss

    @State private var newName: String = ""
    @State private var newItems: [String] = []
    @State private var toast: Toast? = nil
    

    var presetKey: String

    init(presetKey: String) {
        self.presetKey = presetKey
    }

    func handleRemove(idx: Int) -> () -> Void {
        func doRemove() {
            if presetKey == "" {
                let _ = withAnimation {
                    newItems.remove(at: idx)
                }
            } else {
                let presetIdx = getPresetIndex()
                appState.presets[presetIdx].items.remove(at: idx)
            }
        }
        return doRemove
    }

    func getPresetList() -> PresetList {
        for p in self.appState.presets {
            if p.key == presetKey {
                return p
            }
        }
        return PresetList(key: "key", items: [], name: "Name")
    }

    func getPresetIndex() -> Int {
        for idx in self.appState.presets.indices {
            if appState.presets[idx].key == presetKey {
                return idx
            }
        }
        return -1
    }

    func handleCreate() {
        if newName == "" {
            toast = Toast(
                style: .error, message: "Selezionare un nome prima di salvare")
            return
        }
        let key = NSUUID().uuidString
        let newPreset = PresetList(key: key, items: newItems, name: newName)
        appState.presets.append(newPreset)
        dismiss()
    }

    func handleDelete(_ key: String) {
        appState.presets.removeAll(where: { p in
            return p.key == key
        })
        for profile in appState.profiles {
            for bucket in profile.buckets {
                bucket.presets.removeAll(where: { p in
                    return p == key
                })
            }
        }
        dismiss()
    }

    var body: some View {
        if presetKey == "" {
            PresetEditorItem(
                items: $newItems, name: $newName, onSave: handleCreate
            ).toastView(toast: $toast)

        } else {
            let presetIdx = getPresetIndex()
            if presetIdx >= 0 {
                let preset = $appState.presets[presetIdx]
                PresetEditorItem(
                    items: preset.items, name: preset.name,
                    onDelete: {
                        handleDelete(preset.key.wrappedValue)
                    })
            }

        }

    }
}
