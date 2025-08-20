# temp_0 - iOS App with Snapshot Testing

This project is configured for comprehensive snapshot testing using both **swift-snapshot-testing** for unit tests and **Fastlane snapshot** for UI screenshot automation.

## 🚀 Quick Start

### Prerequisites
- Xcode 16.4+
- iOS 18.5+ deployment target
- Fastlane installed (✅ Already configured)

### Manual Setup Required

Since we cannot programmatically modify Xcode project files, you need to complete these steps:

1. **Add SnapshotTesting Package Dependency**
   - Open `temp_0.xcodeproj` in Xcode
   - Go to Project Settings → Package Dependencies
   - Add: `https://github.com/pointfreeco/swift-snapshot-testing`
   - Add to both `temp_0Tests` and `temp_0UITests` targets

2. **Configure Build Settings for UI Tests**
   - Select `temp_0UITests` target
   - Build Settings → Other Swift Flags
   - Add `-DFASTLANE_SNAPSHOT` to Debug configuration

3. **Add Generated Files to Xcode**
   - Add `temp_0UITests/SnapshotHelper.swift` to your UI test target
   - Add `temp_0Tests/SnapshotTests.swift` to your unit test target

## 📸 Snapshot Testing Types

### Unit Test Snapshots
- **File**: `temp_0Tests/SnapshotTests.swift`
- **Purpose**: Test individual SwiftUI views
- **Output**: `temp_0Tests/__Snapshots__/`
- **Usage**: Detects UI regressions in components

### UI Screenshots 
- **File**: `temp_0UITests/FastlaneSnapshotUITests.swift`
- **Purpose**: Full app screenshots across devices
- **Output**: `screenshots/` directory
- **Usage**: App Store screenshots, documentation

## 🛠 Available Fastlane Lanes

```bash
# Run unit tests with snapshot testing
fastlane test

# Generate app screenshots for multiple devices
fastlane screenshots

# Complete snapshot testing workflow (unit tests + screenshots)
fastlane snapshot_tests

# Show setup instructions
fastlane setup_snapshot

# Clean and rebuild project
fastlane clean_build
```

## 📱 Configured Devices

Screenshots will be generated for:
- iPhone 15 Pro
- iPhone 15 Pro Max
- iPhone SE (3rd generation)
- iPad Pro (12.9-inch) (6th generation)

## 🌍 Languages

Currently configured for:
- English (en-US)

*Edit `fastlane/Snapfile` to add more languages*

## 🗂 Project Structure

```
temp_0/
├── fastlane/
│   ├── Fastfile          # Fastlane lanes configuration
│   ├── Appfile           # App identifier configuration
│   └── Snapfile          # Screenshot devices & languages
├── temp_0/
│   ├── ContentView.swift # Main SwiftUI view
│   └── temp_0App.swift   # App entry point
├── temp_0Tests/
│   └── SnapshotTests.swift    # Unit snapshot tests
├── temp_0UITests/
│   ├── FastlaneSnapshotUITests.swift  # UI screenshot tests
│   └── SnapshotHelper.swift           # Fastlane snapshot helper
├── screenshots/          # Generated screenshots (created after first run)
└── SNAPSHOT_TESTING_SETUP.md  # Detailed setup instructions
```

## 🔄 Workflow

1. **First Time Setup**
   - Complete manual steps above
   - Run: `fastlane setup_snapshot`

2. **Generate Initial Snapshots**
   - Run: `fastlane snapshot_tests`
   - Commit reference images to version control

3. **Development Workflow**
   - Make UI changes
   - Run: `fastlane test` (unit snapshots)
   - Run: `fastlane screenshots` (UI screenshots)
   - Review and update snapshots as needed

## 🎯 Testing Strategy

### Unit Snapshot Tests
- Test different device sizes (iPhone, iPad)
- Test light/dark mode variations
- Test individual SwiftUI components
- Automatic failure on UI changes

### UI Screenshot Tests
- Full app flow screenshots
- Multi-device compatibility
- App Store ready images
- Localization support

## 🚨 Troubleshooting

### Common Issues

**Build Errors**: Ensure SnapshotTesting package is added to test targets

**Screenshot Failures**: Check that simulators are available and app launches properly

**Snapshot Mismatches**: Set `isRecording = true` in `SnapshotTests.swift` to record new reference images

### Getting Help

1. Check `SNAPSHOT_TESTING_SETUP.md` for detailed instructions
2. Run `fastlane setup_snapshot` for configuration tips
3. Verify Xcode project settings match requirements

## 📈 Next Steps

After completing setup:

1. **Expand Test Coverage**
   - Add more SwiftUI views to test
   - Test different app states and user flows
   - Add accessibility snapshot testing

2. **CI/CD Integration**
   - Add snapshot testing to your CI pipeline
   - Automate screenshot generation on releases
   - Set up visual regression detection

3. **Advanced Configuration**
   - Add more device types and languages
   - Configure custom launch arguments
   - Set up automated App Store screenshot upload

---

**Ready to start?** Complete the manual setup steps above, then run `fastlane snapshot_tests` to generate your first snapshots! 🎉
