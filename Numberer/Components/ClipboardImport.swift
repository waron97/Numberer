//
//  ClipboardImport.swift
//  Numberer
//
//  Created by Aron Winkler on 20/11/24.
//

import SwiftUI

struct ClipboardImport: View {
    @Binding var selection: [String]
    @Binding var open: Bool

    var body: some View {
        let imports = UIPasteboard.general.string!
        VStack {
            List {
                Section {
                    ForEach(GenerationUtils.splitString(imports), id: \.self) { record in
                        Text(record)
                    }
                } header: {
                    Text(
                        "Ci sono elementi nei tuoi appunti che possono essere importati"
                    )
                }

                Section {
                    Button {
                        selection.insert(contentsOf: GenerationUtils.splitString(imports), at: 0)
                        selection = Array(Set(selection))
                        open = false
                    } label: {
                        Label("Importa", systemImage: "checkmark").labelStyle(.titleOnly)
                    }

                    Button(role: .destructive) {
                        open = false
                    } label: {
                        Label("Non importare", systemImage: "xmark").labelStyle(.titleOnly)
                    }

                } header: {
                    Text("Azioni")
                }

            }
        }.frame(maxHeight: .infinity, alignment: .top).padding()
    }
}

#Preview {
    @Previewable @State var items = ["IT1", "IT2"]
    @Previewable @State var open = true
    ClipboardImport(selection: $items, open: $open)
}
