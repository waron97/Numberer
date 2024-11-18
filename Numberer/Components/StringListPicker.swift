//
//  StringListPicker.swift
//  Numberer
//
//  Created by Aron Winkler on 05/11/24.
//

import SwiftUI

struct StringListPicker: View {
    public var label: String
    @Binding public var bucket: Bucket
    @State var newItem: String = ""

    func handleAdd() {
        withAnimation {
            bucket.customItems.insert(newItem, at: 0)
        }
        newItem = ""
    }

    func removeBucketItem(_ item: String) -> () -> Void {
        func doRemove() {
            let idx = bucket.customItems.firstIndex(of: item) ?? -1
            if idx >= 0 {
                withAnimation {
                    bucket.customItems.remove(at: idx)
                }
                
            }
        }
        return doRemove
    }

    var body: some View {
        VStack {
            HStack {
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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach($bucket.customItems, id: \.self) { $value in
                        HStack {
                            Text(value)
                            Button(action: removeBucketItem(value)) {
                                Label("", systemImage: "trash").labelStyle(
                                    .iconOnly).foregroundStyle(.red)
                            }
                        }.padding(.horizontal, 10).padding(.vertical, 4).background(Rectangle().fill(Color("PickerBg")).cornerRadius(8)).transition(.scale)
                    }
                }
            }.padding(.top, 6)
        }
    }
}
