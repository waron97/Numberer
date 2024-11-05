//
//  ContentView.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    
    var body: some View {
        NavRoot().environmentObject(appState)
    }
}

#Preview {
    ContentView()
}
