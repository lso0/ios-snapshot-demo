//
//  ContentView1.swift
//  temp_0
//
//  Created by wgm0 on 20/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world1!")
        }
        .accessibilityIdentifier("contentView1Root")
        .padding()
    }
}

#Preview {
    ContentView()
}
