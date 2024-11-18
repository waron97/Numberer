//
//  RouletteGeneratorScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct RouletteGeneratorScreen: View {
    public var profile: Profile
    @State var generatorStates: [GeneratorState] = [
        .running, .running, .running, .running, .running,
    ]
    
    func handleTap() {
        let running = generatorStates.filter({state in
            state == .running
        })
        
        if running.count > 0 {
            let firstRunning = generatorStates.firstIndex(where: { state in
                state == .running
            })
            generatorStates[firstRunning!] = .stopped
        } else {
            generatorStates = [.running, .running, .running, .running, .running]
        }
        
    }

    var body: some View {
        VStack {
            if profile.buckets[0].customItems.count > 0 {
                RouletteGenerator(
                    bucket: profile.buckets[0], state: generatorStates[0])
                Spacer()
            }

            if profile.buckets[1].customItems.count > 0 {
                RouletteGenerator(
                    bucket: profile.buckets[1], state: generatorStates[1])
                Spacer()
            }

            if profile.buckets[2].customItems.count > 0 {
                RouletteGenerator(
                    bucket: profile.buckets[2], state: generatorStates[2])
                Spacer()
            }

            if profile.buckets[3].customItems.count > 0 {
                RouletteGenerator(
                    bucket: profile.buckets[3], state: generatorStates[3])
                Spacer()
            }

            if profile.buckets[4].customItems.count > 0 {
                RouletteGenerator(
                    bucket: profile.buckets[4], state: generatorStates[4])
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(
            .vertical, 200
        ).background(.background).onTapGesture {
            handleTap()
        }
    }
}

#Preview {
    var appState = AppState()
    RouletteGeneratorScreen(profile: appState.profiles[0])
}
