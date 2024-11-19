//
//  SlotGeneratorConfig.swift
//  Numberer
//
//  Created by Aron Winkler on 18/11/24.
//

import SwiftUI

struct SlotGeneratorConfig: View {
    @Binding var profile: Profile
    var handleDelete: () -> Void

    var body: some View {
        List {
            NavigationLink {
                BucketConfigScreen(bucket: $profile.buckets[0])
            } label: {
                Text("Slot 1")
            }
            NavigationLink {
                BucketConfigScreen(bucket: $profile.buckets[1])
            } label: {
                Text("Slot 2")
            }
            NavigationLink {
                BucketConfigScreen(bucket: $profile.buckets[2])
            } label: {
                Text("Slot 3")
            }
            NavigationLink {
                BucketConfigScreen(bucket: $profile.buckets[3])
            } label: {
                Text("Slot 4")
            }
            NavigationLink {
                BucketConfigScreen(bucket: $profile.buckets[4])
            } label: {
                Text("Slot 5")
            }
        }.background(.yellow)
    }
}