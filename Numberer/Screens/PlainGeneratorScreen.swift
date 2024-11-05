//
//  PlainGeneratorScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct PlainGeneratorScreen: View {
    var profile: Profile
    @State private var number: Int = 5
    @State private var mustRefresh = false

    init(_ profile: Profile) {
        self.profile = profile
        if getOptions().count == 0 {
            self.mustRefresh = true
        }
    }

    private func getOptions() -> [Int] {
        if profile.lower > profile.upper {
            return []
        }
        let options = Array(profile.lower..<profile.upper + 1).filter {
            number in
            return !profile.exclude.contains(number)
        }
        return options
    }

    private func genNewNumber() {
        let options = getOptions()
        if options.isEmpty {
            mustRefresh = true
        } else {
            number = options.randomElement()!
        }

    }

    var body: some View {
        VStack {
            Text("\(number)")
                .bold()
                .font(.system(size: 100))
                .foregroundColor(.primary)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.background)
            .onTapGesture {
                genNewNumber()
            }

    }
}

#Preview {
    PlainGeneratorScreen(
        Profile(
            label: "Example", type: .plain, lower: 12, upper: 24, exclude: []))
}
