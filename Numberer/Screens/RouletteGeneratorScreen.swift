//
//  RouletteGeneratorScreen.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct RouletteGeneratorScreen: View {
    public var profile: Profile
    @EnvironmentObject var appState: AppState
    @State private var generation: [String]? = nil

    func generate() {
        var partialGeneration: [String] = []
        for i in 0...4 {
            let options = GenerationUtils.getBucketOptions(
                profile.buckets[i], appState)
            if !options.isEmpty {
                partialGeneration.append(options.randomElement()!)
            }
        }
        withAnimation {
            generation = partialGeneration
        }

    }

    var body: some View {
        VStack {
            if let gen = generation {
                VStack {
                    ForEach(gen.indices, id: \.self) { idx in
                        let genned = gen[idx]
                        Text(genned)
                            .padding()
                            .foregroundStyle(.white).fontWeight(.bold)
                            .frame(width: 200)
                            .background(
                                Rectangle().fill(.blue).cornerRadius(20)
                            )
                    }
                }.transition(.move(edge: .top))
            }

            Button(action: generate) {
                Label("Genera", systemImage: "repeat")
                    .padding()
                    .foregroundStyle(.white).fontWeight(.bold)
                    .background(
                        Rectangle().fill(.green).cornerRadius(20)
                    )
            }.labelStyle(.iconOnly).padding(.top, 24)
        }
    }

}

#Preview {
    var appState = AppState()
    RouletteGeneratorScreen(profile: appState.profiles[0]).environmentObject(
        appState)
}
