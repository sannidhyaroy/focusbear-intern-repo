//
//  ContentView.swift
//  Sample App
//
//  Created by Sannidhya Roy on 03/06/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "hand.wave")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello Xcode!")
                    .font(.title)
            }
            Text("Built on \(Date().formatted(date: .long, time: .omitted))!")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
