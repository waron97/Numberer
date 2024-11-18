//
//  AppState.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import Foundation

enum ProfileType: String, Codable {
    case plain = "plain"
    case roulette = "roulette"
}

class Bucket: Identifiable, Codable {
    public var presets: [String]
    public var customItems: [String]

    init(presets: [String], customItems: [String]) {
        self.presets = presets
        self.customItems = customItems
    }
}

class PresetList: Identifiable, Codable {
    var key: String
    var items: [String]
    var name: String

    init(key: String, items: [String], name: String) {
        self.key = key
        self.items = items
        self.name = name
    }
}

class Profile: Identifiable, Codable {
    var label: String
    var type: ProfileType
    var lower: Int
    var upper: Int
    var exclude: [Int]
    var useExclude: Bool
    var key: String
    var buckets: [Bucket] = [
        Bucket(
            presets: ["nums-0-10"],
            customItems: [
                "Emma", "Aron", "Italo", "Annalisa", "Mamma", "Francesco",
            ]),
        Bucket(
            presets: [],
            customItems: [
                "Emma", "Aron", "Italo", "Annalisa", "Mamma", "Francesco",
            ]),
        Bucket(
            presets: [],
            customItems: [
                "Emma", "Aron", "Italo", "Annalisa", "Mamma", "Francesco",
            ]),
        Bucket(
            presets: [],
            customItems: [
                "Emma", "Aron", "Italo", "Annalisa", "Mamma", "Francesco",
            ]),
        Bucket(
            presets: [],
            customItems: [
                "Emma", "Aron", "Italo", "Annalisa", "Mamma", "Francesco",
            ]),
    ]

    init(
        label: String, type: ProfileType, lower: Int, upper: Int,
        useExclude: Bool = false, exclude: [Int] = []
    ) {
        self.key = NSUUID().uuidString
        self.label = label
        self.type = type
        self.lower = lower
        self.upper = upper
        self.useExclude = useExclude
        self.exclude = exclude
    }
}

class AppState: ObservableObject {
    @Published var profiles: [Profile]
    @Published var presets: [PresetList]

    init() {
        self.profiles = [
            Profile(
                label: "Generatore", type: .roulette, lower: 1, upper: 20,
                useExclude: true, exclude: [1, 2, 3])
        ]
        self.presets = [
            PresetList(
                key: "nums-0-10",
                items: [
                    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                ], name: "Numeri piccoli")
        ]
    }
}
