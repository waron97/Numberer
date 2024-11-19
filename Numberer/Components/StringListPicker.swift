//
//  StringListPicker.swift
//  Numberer
//
//  Created by Aron Winkler on 05/11/24.
//

import SwiftUI

struct StringListPicker: View {
    public var label: String
    @EnvironmentObject var appState: AppState
    @Binding public var bucket: Bucket
    @State var newItem: String = ""

    func handleAdd() {
        withAnimation {
            bucket.customItems.insert(newItem, at: 0)
        }
        newItem = ""
    }

    func renderNewItem() -> some View {
        return HStack {
            TextField(
                self.label, text: $newItem
            ).padding(12).background(Color("PickerBg"))
                .cornerRadius(20)
            Button(action: handleAdd) {
                Label("", systemImage: "plus").labelStyle(.iconOnly)
                    .foregroundStyle(.white)
            }.imageScale(.large).background(
                Circle().fill(.green).frame(width: 40, height: 40)
            ).frame(width: 40, height: 40)
        }
    }
    
    private struct CustomItemsPicker : View {
        @Binding var selected: [String]
        
        func removeBucketItem(_ item: String) {
            let idx = selected.firstIndex(of: item) ?? -1
            if idx >= 0 {
                withAnimation {
                    selected.remove(at: idx)
                }
            }
        }
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach($selected, id: \.self) { $value in
                        HStack {
                            Text(value)
                            Button {
                                removeBucketItem(value)
                            } label: {
                                Label("", systemImage: "trash").labelStyle(
                                    .iconOnly
                                ).foregroundStyle(.red)
                            }
                        }.padding(.horizontal, 10).padding(.vertical, 4).background(
                            Rectangle().fill(Color("PickerBg")).cornerRadius(8)
                        ).transition(.scale)
                    }
                }
            }.padding(.top, 6)
        }
    }

    private struct PresetLists: View {
        @Binding var selectedPresets: [String]
        @EnvironmentObject private var appState: AppState
        
        var selectedColor = Color(red: 51/255, green: 1.0, blue: 69/255)

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
                                    isSelected ? selectedColor : Color("PickerBg")
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
        VStack(spacing: 16) {
            renderNewItem()
            CustomItemsPicker(selected: $bucket.customItems)
            PresetLists(selectedPresets: $bucket.presets)
        }
    }
}
