//
//  ContentView1.swift
//  temp_0
//
//  Main screen with enhanced UI elements
//

import SwiftUI

struct ContentView1: View {
    @State private var userName = ""
    @State private var isNotificationsEnabled = true
    @State private var selectedTheme = "Blue"
    
    let themes = ["Blue", "Green", "Purple", "Orange"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header Section
                VStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("Welcome Back!")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top)
                
                // User Input Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Personal Settings")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    TextField("Enter your name", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityIdentifier("userNameField")
                    
                    HStack {
                        Text("Enable Notifications")
                        Spacer()
                        Toggle("", isOn: $isNotificationsEnabled)
                            .accessibilityIdentifier("notificationsToggle")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Theme")
                        Picker("Theme", selection: $selectedTheme) {
                            ForEach(themes, id: \.self) { theme in
                                Text(theme).tag(theme)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accessibilityIdentifier("themePicker")
                    }
                }
                .padding(.horizontal)
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        // Save action
                    }) {
                        Text("Save Settings")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .accessibilityIdentifier("saveButton")
                    
                    NavigationLink(destination: ContentView2()) {
                        Text("Go to Profile")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .accessibilityIdentifier("profileButton")
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Main Screen")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView1()
}
