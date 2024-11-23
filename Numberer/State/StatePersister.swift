//
//  StatePersister.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import Foundation

class PersistedState: Identifiable, Codable {
    var profiles: [Profile] = []
    var presets: [PresetList] = []
    
    init(profiles: [Profile], presets: [PresetList]) {
        self.profiles = profiles
        self.presets = presets
    }
}

class StatePersister {
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("numberer.appState")
    }

    func load() async throws -> PersistedState? {
        let task = Task<PersistedState?, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return nil
            }
            let restoredState = try JSONDecoder().decode(
                PersistedState.self, from: data)
            return restoredState
        }
        let restoredState = try await task.value
        return restoredState
    }

    func save(_ state: PersistedState) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(state)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    public static func persistState(_ state: AppState) {
        let _ = Task {
            let persister = StatePersister()
            let persistedState = PersistedState(profiles: state.profiles, presets: state.presets)
            do {
                try await persister.save(persistedState)
            } catch {
                print("Failed to persist state")
            }
        }
    }
}
