//
//  ContentView2.swift
//  temp_0
//
//  Profile/Settings screen with different UI layout
//

import SwiftUI

struct ContentView2: View {
    @State private var profileImage = "person.crop.circle"
    @State private var bio = "iOS Developer passionate about SwiftUI and automation"
    @State private var isPrivateProfile = false
    @State private var selectedLanguage = "English"
    
    let languages = ["English", "Spanish", "French", "German"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Profile Header
                VStack(spacing: 15) {
                    Image(systemName: profileImage)
                        .font(.system(size: 100))
                        .foregroundColor(.purple)
                        .accessibilityIdentifier("profileImage")
                    
                    Text("John Doe")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .accessibilityIdentifier("profileName")
                    
                    Text("iOS Developer")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // Bio Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("About")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    TextEditor(text: $bio)
                        .frame(height: 80)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .accessibilityIdentifier("bioEditor")
                }
                .padding(.horizontal)
                
                // Settings Section
                VStack(spacing: 20) {
                    Text("Privacy Settings")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Private Profile")
                                .font(.body)
                            Text("Hide your profile from search")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Toggle("", isOn: $isPrivateProfile)
                            .accessibilityIdentifier("privateToggle")
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Language Preference")
                            .font(.body)
                        
                        Menu {
                            ForEach(languages, id: \.self) { language in
                                Button(language) {
                                    selectedLanguage = language
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedLanguage)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        .accessibilityIdentifier("languageMenu")
                    }
                }
                .padding(.horizontal)
                
                // Statistics Section
                HStack(spacing: 20) {
                    VStack {
                        Text("42")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Projects")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    
                    VStack {
                        Text("128")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Screenshots")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    
                    VStack {
                        Text("15")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Tests")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        // Edit profile action
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Edit Profile")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .accessibilityIdentifier("editProfileButton")
                    
                    Button(action: {
                        // Sign out action
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.square")
                            Text("Sign Out")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .accessibilityIdentifier("signOutButton")
                }
                .padding(.horizontal)
                
                Spacer(minLength: 20)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationView {
        ContentView2()
    }
}
