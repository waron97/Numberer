//
//  PresetEditorItem.swift
//  Numberer
//
//  Created by Aron Winkler on 18/11/24.
//

import SwiftUI

struct PresetEditorItem: View {
    @Binding public var items: [String]
    @Binding public var name: String
    public var onSave: (() -> Void)? = nil
    public var onDelete: (() -> Void)? = nil

    @State private var newName: String = ""
    @State private var isPresentingConfirm: Bool = false

    func handleAdd() {
        items.insert(newName, at: 0)
        newName = ""
    }

    func handleRemove(idx: Int) -> () -> Void {
        func doRemove() {
            withAnimation {
                items.remove(at: idx)
            }
        }
        return doRemove
    }

    func renderNewField() -> some View {
        return HStack {
            VStack {
                TextField(
                    "Aggiungi elemento", text: $newName
                )
            }.padding(12).background(Color("PickerBg"))
                .cornerRadius(20)
            Button(action: handleAdd) {
                Label("", systemImage: "plus").labelStyle(.iconOnly)
                    .foregroundStyle(.white)
            }.imageScale(.large).background(
                Circle().fill(.green).frame(width: 40, height: 40)
            ).frame(width: 40, height: 40)
        }
    }

    func renderNameField() -> some View {
        return VStack {
            TextField(
                "Nome lista", text: $name
            )
        }.padding(12).background(Color("PickerBg"))
            .cornerRadius(20)
    }

    func renderList() -> some View {
        return List {
            ForEach(items.indices, id: \.self) { idx in
                HStack {
                    Text(items[idx]).frame(
                        maxWidth: .infinity, alignment: .leading
                    )

                }.padding(.vertical, 12).frame(
                    maxWidth: .infinity, alignment: .leading
                )
            }.onDelete { indexSet in
                items.remove(atOffsets: indexSet)
            }
        }.frame(maxHeight: .infinity)
    }

    func handleSave() {
        onSave!()
    }

    func renderSaveButton() -> some View {
        return VStack {
            Button(action: handleSave) {
                Label("Crea configurazione", systemImage: "check").fontWeight(
                    .bold
                ).foregroundStyle(.white)
            }.frame(maxWidth: .infinity).frame(height: 48).background(
                Rectangle().fill(.green).cornerRadius(20)
            ).labelStyle(.titleOnly)
        }.padding()
    }
    
    func renderDeleteButton() -> some View {
        return VStack {
            Button(action: {
                isPresentingConfirm = true
            }) {
                Label("Elimina configurazione", systemImage: "check").fontWeight(
                    .bold
                ).foregroundStyle(.white)
            }.frame(maxWidth: .infinity).frame(height: 48).background(
                Rectangle().fill(.red).cornerRadius(20)
            ).labelStyle(.titleOnly)
        }.padding().confirmationDialog("Sei sicuro di voler procedere", isPresented: $isPresentingConfirm, actions: {
            Button("Elimina preset", role: .destructive) {
                onDelete!()
            }
        }, message: {
            Text("Questa operazione è permanente")
        })
    }

    var body: some View {
        VStack {
            VStack {
                renderNameField()
                Divider().padding(.vertical, 6)
                renderNewField()
            }.padding()
            renderList()
            if onSave != nil {
                renderSaveButton()
            }
            if onDelete != nil {
                renderDeleteButton()
            }
        }
    }
}
