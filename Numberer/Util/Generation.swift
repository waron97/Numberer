//
//  Generation.swift
//  Numberer
//
//  Created by Aron Winkler on 19/11/24.
//

import Foundation

struct GenerationUtils {
    public static func getPreset(_ key: String, _ appState: AppState) -> PresetList? {
        for preset in appState.presets {
            if preset.key == key {
                return preset
            }
        }
        return nil
    }
    
    public static func getBucketOptions(_ bucket: Bucket, _ appState: AppState) -> [String] {
        var options: [String] = []
        options.append(contentsOf: bucket.customItems)
        for presetKey in bucket.presets {
            if let preset = getPreset(presetKey, appState) {
                options.append(contentsOf: preset.items)
            }
        }
        return options
    }
}
