# Complete iOS Snapshot Testing Setup Guide

This guide will help you create an iOS app with Fastlane snapshot testing from scratch, exactly like this project but with your own project name.

## 📋 Prerequisites

- macOS with Xcode 16.4+
- Fastlane installed (`gem install fastlane`)
- Git installed
- GitHub account (optional, for remote repository)

## 🎯 What You'll Build

- iOS SwiftUI app with multiple views
- Automated screenshot testing with Fastlane
- Multi-device screenshot generation (iPhone 16 + iPhone 16 Pro Max)
- Complete Git repository with version control

---

## Step 1: Create New iOS Project

### 1.1 Create Xcode Project
1. Open Xcode
2. Create a new project: **File → New → Project**
3. Choose **iOS → App**
4. Configure project:
   - **Product Name**: `temp_1` (or your desired name)
   - **Interface**: SwiftUI
   - **Language**: Swift
   - **Bundle Identifier**: `com.yourname.temp-1`
5. Choose save location
6. Click **Create**

### 1.2 Verify Project Structure
Your project should have:
```
temp_1/
├── temp_1.xcodeproj/
├── temp_1/
│   ├── temp_1App.swift
│   ├── ContentView.swift
│   └── Assets.xcassets/
├── temp_1Tests/
└── temp_1UITests/
```

---

## Step 2: Initialize Fastlane

### 2.1 Navigate to Project Directory
```bash
cd /path/to/your/temp_1
```

### 2.2 Initialize Fastlane
```bash
fastlane init
```
- Choose option **4** (Manual setup)
- Follow the prompts

### 2.3 Configure Appfile
Edit `fastlane/Appfile`:
```ruby
app_identifier("com.yourname.temp-1") # Your bundle identifier
# apple_id("[[APPLE_ID]]") # Your Apple Developer Portal username

# For more information about the Appfile, see:
#     https://docs.fastlane.tools/advanced/#appfile
```

---

## Step 3: Create Multi-View SwiftUI App

### 3.1 Create ContentView1.swift
Create `temp_1/ContentView1.swift`:

```swift
//
//  ContentView1.swift
//  temp_1
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
```

### 3.2 Create ContentView2.swift
Create `temp_1/ContentView2.swift`:

```swift
//
//  ContentView2.swift
//  temp_1
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
```

### 3.3 Update ContentView.swift
Replace the content of `temp_1/ContentView.swift`:

```swift
//
//  ContentView.swift
//  temp_1
//
//  Created by you on today's date.
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
```

---

## Step 4: Configure Fastlane

### 4.1 Update Fastfile
Replace `fastlane/Fastfile` content:

```ruby
# This file contains the fastlane.tools configuration
# You can find the documentation at https://docs.fastlane.tools
#
# For a list of all available actions, check out
#
#     https://docs.fastlane.tools/actions
#
# For a list of all available plugins, check out
#
#     https://docs.fastlane.tools/plugins/available-plugins
#

# Uncomment the line if you want fastlane to automatically update itself
# update_fastlane

default_platform(:ios)

platform :ios do
  desc "Run unit tests"
  lane :test do
    run_tests(
      project: "temp_1.xcodeproj",  # Update project name
      scheme: "temp_1",             # Update scheme name
      destination: "platform=iOS Simulator,name=iPhone 16,OS=latest",
      clean: true
    )
  end

  desc "Generate screenshots using Fastlane snapshot"
  lane :screenshots do
    snapshot
  end

  desc "Build app for screenshots (no tests)"
  lane :build_for_screenshots do
    gym(
      project: "temp_1.xcodeproj",        # Update project name
      scheme: "temp_1_Screenshots",       # Update scheme name
      skip_archive: true,
      skip_codesigning: true,
      destination: "generic/platform=iOS Simulator"
    )
    
    UI.success("✅ App built successfully for screenshots!")
    UI.message("📱 You can now manually take screenshots or use simulator")
  end

  desc "Run snapshot tests and generate screenshots"
  lane :snapshot_tests do
    # First run unit tests
    test
    
    # Then generate UI screenshots
    screenshots
    
    UI.success("✅ Snapshot testing completed!")
    UI.message("📸 Screenshots saved to: ./screenshots")
    UI.message("🧪 Unit test snapshots saved to: ./temp_1Tests/__Snapshots__")
  end

  desc "Setup snapshot testing (run this once)"
  lane :setup_snapshot do
    UI.message("🔧 Setting up snapshot testing...")
    UI.message("Please make sure to:")
    UI.message("1. Create temp_1_Screenshots scheme in Xcode")
    UI.message("2. Run 'bundle exec fastlane screenshots' to generate screenshots")
  end

  desc "Clean and rebuild project"
  lane :clean_build do
    clean_build_artifacts
    clear_derived_data
    
    gym(
      project: "temp_1.xcodeproj",        # Update project name
      scheme: "temp_1",                   # Update scheme name
      clean: true,
      skip_archive: true,
      skip_codesigning: true
    )
  end
end
```

### 4.2 Create Snapfile
Create `fastlane/Snapfile`:

```ruby
# Uncomment the lines below you want to change by removing the # in the beginning

# A list of devices you want to take the screenshots from
devices([
  "iPhone 16",
  "iPhone 16 Pro Max"
])

languages([
  "en-US"
  # Add more languages as needed
  # "de-DE",
  # "it-IT",
  # ["pt", "pt_BR"] # Portuguese with Brazilian locale
])

# The name of the scheme which contains the UI Tests
scheme("temp_1_Screenshots")  # Update scheme name

# Where should the resulting screenshots be stored?
output_directory("./screenshots")

# Clear all previously generated screenshots before creating new ones
clear_previous_screenshots(true)

# Choose which project/workspace to use
project("./temp_1.xcodeproj")  # Update project name

# Arguments to pass to the app on launch. See https://docs.fastlane.tools/actions/snapshot/#launch-arguments
# launch_arguments(["-favColor red"])

# For more information about all available options run
# fastlane action snapshot
```

---

## Step 5: Create Xcode Schemes

### 5.1 Create Screenshot Scheme
**CRITICAL STEP**: You must create a dedicated scheme for screenshots:

1. In Xcode: **Product → Scheme → Manage Schemes**
2. Select your main scheme (`temp_1`)
3. Click gear icon → **Duplicate**
4. Rename to `temp_1_Screenshots`
5. Click **Edit**
6. Go to **Build** tab
7. **Uncheck both test targets**:
   - ❌ `temp_1Tests`
   - ❌ `temp_1UITests`
8. Leave only: ✅ `temp_1` (main app)
9. Click **Close**

### 5.2 Make Scheme Shared
1. In **Manage Schemes**
2. Check **Shared** for `temp_1_Screenshots`
3. This ensures the scheme is saved in version control

---

## Step 6: Create UI Tests

### 6.1 Update UI Test File
Replace content of `temp_1UITests/temp_1UITests.swift`:

```swift
//
//  temp_1UITests.swift
//  temp_1UITests
//
//  Multi-view snapshot tests
//

import XCTest

@MainActor
final class temp_1UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        let app = XCUIApplication()
        setupSnapshot(app)              // @MainActor API
        app.launch()
    }

    func testTakeSnapshots() throws {
        let app = XCUIApplication()
        
        // Give the app more time to launch
        sleep(2)
        
        // Take initial screenshot of whatever is currently showing
        snapshot("01_AppLaunch")        // @MainActor API
        
        // Look for tab bar
        let tabBar = app.tabBars.firstMatch
        if tabBar.waitForExistence(timeout: 5) {
            
            // Try to find and tap Home tab
            let homeTab = app.tabBars.buttons.element(boundBy: 0) // First tab
            if homeTab.exists {
                homeTab.tap()
                sleep(1)
                snapshot("02_HomeTab")        // @MainActor API
            }
            
            // Try to find and tap Profile tab  
            let profileTab = app.tabBars.buttons.element(boundBy: 1) // Second tab
            if profileTab.exists {
                profileTab.tap()
                sleep(1)
                snapshot("03_ProfileTab")     // @MainActor API
            }
            
            // Go back to first tab
            if homeTab.exists {
                homeTab.tap()
                sleep(1)
                snapshot("04_BackToHome")     // @MainActor API
            }
        } else {
            // Fallback: just take a screenshot of whatever is showing
            snapshot("05_Fallback")           // @MainActor API
        }
    }
}
```

### 6.2 Generate SnapshotHelper
```bash
bundle exec fastlane snapshot update
```
- Choose **y** to update the helper file

---

## Step 7: Build and Test

### 7.1 Clean Build
```bash
bundle exec fastlane clean_build
```

### 7.2 Generate Screenshots
```bash
bundle exec fastlane screenshots
```

**Expected Output**: 8 screenshots (4 per device) showing your app's navigation flow.

---

## Step 8: Version Control Setup

### 8.1 Create .gitignore
Create `.gitignore`:

```gitignore
# Xcode
*.xcodeproj/*
!*.xcodeproj/project.pbxproj
!*.xcodeproj/*.xcscheme
!*.xcodeproj/project.xcworkspace/
!*.xcodeproj/project.xcworkspace/contents.xcworkspacedata
*.xcodeproj/project.xcworkspace/xcuserdata/
*.xcodeproj/xcuserdata/

# iOS
*.ipa
*.dSYM.zip
*.dSYM

# macOS
.DS_Store

# Fastlane
fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots/**/*.png
fastlane/test_output
fastlane/readme.md

# Build artifacts
build/
DerivedData/

# Swift Package Manager
.swiftpm/
Packages/
Package.resolved

# Bundler
vendor/
```

### 8.2 Initialize Git
```bash
git init
git add .
git commit -m "🎉 Initial commit: iOS app with Fastlane snapshot testing

✅ Features implemented:
- SwiftUI iOS app with multi-view TabView interface
- Complete Fastlane configuration for screenshot automation
- Working snapshot testing on iPhone 16 and iPhone 16 Pro Max
- Automated screenshot generation for ContentView1 and ContentView2
- HTML report generation for screenshot overview
- Xcode 16.4 compatibility with dedicated screenshot scheme"
```

### 8.3 Create GitHub Repository (Optional)
```bash
# Create remote repository
gh repo create your-project-name --public --description "iOS SwiftUI app with Fastlane snapshot testing" --clone=false

# Add remote and push
git remote add origin https://github.com/yourusername/your-project-name.git
git push -u origin main
```

---

## Step 9: Verification Checklist

### ✅ Verify Everything Works

1. **Build succeeds**: `bundle exec fastlane clean_build`
2. **Screenshots generate**: `bundle exec fastlane screenshots`
3. **8 screenshots created**:
   - iPhone 16: 4 screenshots
   - iPhone 16 Pro Max: 4 screenshots
4. **HTML report opens**: `open screenshots/screenshots.html`
5. **Git repository**: All files committed and pushed

---

## 🎯 Expected Results

After following this guide, you should have:

### 📱 **Screenshots Generated**:
```
screenshots/en-US/
├── iPhone 16-01_AppLaunch.png
├── iPhone 16-02_HomeTab.png
├── iPhone 16-03_ProfileTab.png
├── iPhone 16-04_BackToHome.png
├── iPhone 16 Pro Max-01_AppLaunch.png
├── iPhone 16 Pro Max-02_HomeTab.png
├── iPhone 16 Pro Max-03_ProfileTab.png
└── iPhone 16 Pro Max-04_BackToHome.png
```

### 🛠 **Available Fastlane Commands**:
- `bundle exec fastlane screenshots` - Generate all screenshots
- `bundle exec fastlane clean_build` - Clean and build project
- `bundle exec fastlane build_for_screenshots` - Build without tests
- `bundle exec fastlane setup_snapshot` - Show setup instructions

---

## 🚨 Troubleshooting

### Common Issues and Solutions

**1. "Testing" module conflict error**
- **Solution**: Ensure you created the `temp_1_Screenshots` scheme and excluded test targets from the Build tab

**2. UI tests fail to find elements**
- **Solution**: Verify accessibility identifiers match between SwiftUI views and UI tests

**3. Screenshots not generated**
- **Solution**: Check that the scheme is properly configured and shared

**4. Build failures**
- **Solution**: Run `bundle exec fastlane clean_build` first

**5. Simulator issues**
- **Solution**: Reset simulators with `bundle exec fastlane snapshot reset_simulators`

---

## 🎨 Customization Options

### Add More Devices
Edit `fastlane/Snapfile`:
```ruby
devices([
  "iPhone 16",
  "iPhone 16 Pro Max",
  "iPhone SE (3rd generation)",
  "iPad Pro (12.9-inch) (6th generation)"
])
```

### Add More Languages
```ruby
languages([
  "en-US",
  "es-ES",
  "fr-FR",
  "de-DE"
])
```

### Add More Views
1. Create new SwiftUI view files
2. Add them to the TabView in `ContentView.swift`
3. Update UI tests to navigate and capture them

---

## 🎉 Success Criteria

When you've completed this guide successfully, you should be able to:

✅ **Run one command** (`bundle exec fastlane screenshots`) and get professional screenshots
✅ **See your app** on multiple device sizes automatically
✅ **Navigate between views** and capture each screen
✅ **Generate App Store ready screenshots** for submission
✅ **Version control everything** with Git
✅ **Share your setup** with team members

---

## 📚 Additional Resources

- **Fastlane Documentation**: https://docs.fastlane.tools/actions/snapshot/
- **SwiftUI Accessibility**: https://developer.apple.com/documentation/swiftui/accessibility
- **Xcode Schemes**: https://developer.apple.com/documentation/xcode/customizing-the-build-schemes-for-a-project

---

**This guide will give you the exact same professional iOS snapshot testing setup!** 🚀
