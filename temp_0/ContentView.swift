//
//  ContentView.swift
//  temp_0
//
//  Created by wgm0 on 20/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ContentView1()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .accessibilityIdentifier("homeTab")
            
            ContentView2()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .accessibilityIdentifier("profileTab")
        }
    }
}

#Preview {
    ContentView()
}
