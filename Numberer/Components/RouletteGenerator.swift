//
//  RouletteGenerator.swift
//  Numberer
//
//  Created by Aron Winkler on 06/11/24.
//

import SwiftUI

enum GeneratorState {
    case running
    case stopped
}

struct RouletteGenerator: View {
    public var bucket: Bucket
    public var state: GeneratorState
    @EnvironmentObject var appState: AppState

    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State private var index = 0

    func getPreset(_ key: String) -> PresetList {
        for list in appState.presets {
            if list.key == key {
                return list
            }
        }
        return PresetList(key: "", items: [], name: "")
    }

    func getOptions() -> [String] {
        var allOptions: [String] = []
        for customItem in bucket.customItems {
            allOptions.append(customItem)
        }
        for listKey in bucket.presets {
            let preset = getPreset(listKey)
            for item in preset.items {
                allOptions.append(item)
            }
        }
        return allOptions
    }

    func update() {
        if self.state == .stopped {
            return
        }
        let options = getOptions()
        if options.count > 0 {
            index = Int.random(in: 0..<options.count)
        } else {
            index = 0
        }

    }

    var body: some View {
        let options = getOptions()
        if index < options.count {
            Text("\(options[index])").font(.system(size: 32)).onReceive(timer) {
                value in
                update()
            }
        }
    }
}

#Preview {
    RouletteGenerator(
        bucket: Bucket(presets: [], customItems: ["Aron", "Emma"]),
        state: .running)
}
