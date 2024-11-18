//
//  PlainGeneratorScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct PlainGeneratorScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var number: Int = 5
    @State private var mustRefresh = false

    var profileKey: String

    init(_ profileKey: String) {
        self.profileKey = profileKey
    }

    func getProfile() -> Profile {
        for p in self.appState.profiles {
            if p.key == self.profileKey {
                return p
            }
        }
        return Profile(
            label: "", type: .plain, lower: 1, upper: 20, useExclude: false)
    }

    private func getOptions() -> [Int] {
        let profile = getProfile()
        if profile.lower > profile.upper {
            return []
        }
        let options = Array(profile.lower..<profile.upper + 1).filter {
            number in
            return !profile.exclude.contains(number)
        }
        return options
    }

    func checkEmpty() {
        let options = getOptions()
        if options.isEmpty {
            withAnimation {
                mustRefresh = true
            }
        } else {
            withAnimation {
                mustRefresh = false
            }
        }
    }

    private func genNewNumber() {
        let profile = getProfile()
        checkEmpty()
        let options = getOptions()
        if options.isEmpty {
            return
        }
        number = options.randomElement()!
        if profile.useExclude {
            profile.exclude.append(number)
            checkEmpty()
        }

    }

    private func handleRefresh() {
        for otherProfile in appState.profiles {
            if otherProfile.key == profileKey {
                otherProfile.exclude = []
                checkEmpty()
            }
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Text("\(number)")
                    .bold()
                    .font(.system(size: 100))
                    .foregroundColor(.primary)
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(
                .background
            )
            .onTapGesture {
                genNewNumber()
            }

            VStack {
                if mustRefresh {
                    Button(action: handleRefresh) {
                        Label("Refresh", systemImage: "repeat").labelStyle(
                            .iconOnly
                        ).imageScale(.large)
                    }.frame(width: 48, height: 48).background(.orange)
                        .cornerRadius(
                            9999
                        ).foregroundStyle(.white).transition(
                            .opacity)
                }

            }.frame(
                maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

        }

    }
}

#Preview {
    @Previewable @StateObject var appState: AppState = AppState()
    PlainGeneratorScreen(appState.profiles[0].key).environmentObject(appState)
}
