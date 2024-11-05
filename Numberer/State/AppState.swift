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

class Profile: Identifiable, Codable {
    var label: String
    var type: ProfileType
    var lower: Int
    var upper: Int
    var exclude: [Int]
    var useExclude: Bool

    init(
        label: String, type: ProfileType, lower: Int, upper: Int,
        useExclude: Bool = false, exclude:[Int] = []
    ) {
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

    init() {
        self.profiles = [
            Profile(
                label: "Generatore", type: .plain, lower: 1, upper: 20,
                useExclude: true, exclude: [1, 2, 3])
        ]
    }
}
