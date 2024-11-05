//
//  ProfileRow.swift
//  Numberer
//
//  Created by Aron Winkler on 04/11/24.
//

import SwiftUI

struct ProfileRow: View {
    var profile: Profile
    var muted = Color("TextMuted")

    init(profile: Profile) {
        self.profile = profile
    }
    
    func getType() -> String {
        if (profile.type == .plain) {
            return "Singolo"
        } else if (profile.type == .roulette) {
            return "Slot"
        }
        return "NA"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(profile.label).fontWeight(.semibold).font(.system(size: 18))
            HStack {
                Text(getType()).foregroundColor(muted)
                Circle()
                    .fill(muted)
                    .frame(width: 6, height: 6)
                Text("\(profile.lower)-\(profile.upper)").foregroundColor(muted)
                Circle()
                    .fill(muted)
                    .frame(width: 6, height: 6)
                Text("\(profile.exclude.count) esclusi").foregroundColor(muted)
            }
        }
    }
}
