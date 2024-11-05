//
//  RouletteGeneratorScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct RouletteGeneratorScreen:View {
    var profile: Profile
    
    init(_ profile: Profile) {
        self.profile = profile
    }
    
    var body: some View {
        Text("Roulette")
    }
}

#Preview {
    RouletteGeneratorScreen(Profile(label: "Profile", type: .roulette, lower: 10, upper: 20, exclude: []))
}
