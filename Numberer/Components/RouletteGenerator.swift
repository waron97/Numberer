//
//  RouletteGenerator.swift
//  Numberer
//
//  Created by Aron Winkler on 06/11/24.
//

import SwiftUI

enum GeneratorState {
    case running
    case stopped
}

struct RouletteGenerator: View {
    public var bucket: Bucket
    public var state: GeneratorState
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State private var index = 0
    
    func update() {
        if self.state == .stopped {
            return
        }
        if bucket.customItems.count > 0 {
            index = Int.random(in: 0..<bucket.customItems.count)
        } else {
            index = 0
        }
        
    }
    
    var body: some View {
        Text("\(bucket.customItems[index])").font(.system(size:32)).onReceive(timer) { value in
            update()
        }
    }
}

#Preview {
    RouletteGenerator(bucket: Bucket(presets: [], customItems: ["Aron", "Emma"]), state: .running)
}
