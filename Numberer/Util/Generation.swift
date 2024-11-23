//
//  Generation.swift
//  Numberer
//
//  Created by Aron Winkler on 19/11/24.
//

import Foundation

struct GenerationUtils {
    public static func getPreset(_ key: String, _ appState: AppState)
        -> PresetList?
    {
        for preset in appState.presets {
            if preset.key == key {
                return preset
            }
        }
        return nil
    }

    public static func getBucketOptions(_ bucket: Bucket, _ appState: AppState)
        -> [String]
    {
        var options: [String] = []
        options.append(contentsOf: bucket.customItems)
        for presetKey in bucket.presets {
            if let preset = getPreset(presetKey, appState) {
                options.append(contentsOf: preset.items)
            }
        }
        return options
    }

    public static func stringConformsToCsv(_ string: String) -> Bool {
        let pattern =
            #"^\s*([a-zA-Z]+(?:\s+[a-zA-Z]+)?)(\s*,\s*([a-zA-Z]+(?:\s+[a-zA-Z]+)?))*\s*$"#
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: string.utf16.count)
        return regex?.firstMatch(in: string, options: [], range: range) != nil
    }

    // Function to split a string by commas and trim whitespace
    public static func splitString(_ string: String) -> [String] {
        return
            string
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}
