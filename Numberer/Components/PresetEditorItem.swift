//
//  PresetEditorItem.swift
//  Numberer
//
//  Created by Aron Winkler on 18/11/24.
//

import SwiftUI

struct PresetEditorItem: View {
    @Environment(\.scenePhase) var scenePhase
    @Binding public var items: [String]
    @Binding public var name: String
    public var onSave: (() -> Void)? = nil
    public var onDelete: (() -> Void)? = nil

    @State private var newName: String = ""
    @State private var isPresentingConfirm: Bool = false

    @State private var importSheetOpen = false
    @State private var noContentAlert = false

    func handleAdd() {
        if newName != "" {
            items.insert(newName, at: 0)
            newName = ""
        }

    }

    func handleRemove(idx: Int) -> () -> Void {
        func doRemove() {
            _ = withAnimation {
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
        return List($items, id: \.self, editActions: .delete) { $item in
            HStack {
                Text(item).frame(
                    maxWidth: .infinity, alignment: .leading
                )

            }.padding(.vertical, 12).frame(
                maxWidth: .infinity, alignment: .leading
            )

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
                Label("Elimina configurazione", systemImage: "check")
                    .fontWeight(
                        .bold
                    ).foregroundStyle(.white)
            }.frame(maxWidth: .infinity).frame(height: 48).background(
                Rectangle().fill(.red).cornerRadius(20)
            ).labelStyle(.titleOnly)
        }.padding().confirmationDialog(
            "Sei sicuro di voler procedere", isPresented: $isPresentingConfirm,
            actions: {
                Button("Elimina preset", role: .destructive) {
                    onDelete!()
                }
            },
            message: {
                Text("Questa operazione è permanente")
            })
    }

    func openImportModal() {
        let pasteboard = UIPasteboard.general
        if let _ = pasteboard.string {
            importSheetOpen = true
        } else {
            noContentAlert = true
        }
    }

    var body: some View {
        ZStack {
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

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        openImportModal()
                    } label: {
                        Label("", systemImage: "clipboard.fill").labelStyle(
                            .iconOnly
                        ).foregroundStyle(.white)
                    }.frame(width: 48, height: 48).background(
                        Circle().fill(.orange)
                    ).padding(.bottom, 60)
                }.padding()
            }
        }.sheet(isPresented: $importSheetOpen) {
            ClipboardImport(
                selection: $items, open: $importSheetOpen)
        }.alert("Nessun testo trovato negli appunti", isPresented: $noContentAlert) {}
    }
}
