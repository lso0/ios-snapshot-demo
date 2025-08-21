# Quick Setup Checklist - iOS Snapshot Testing

Use this checklist to recreate the exact same setup in a new project.

## ⚡ Quick Steps (30 minutes)

### 1. Create Xcode Project (5 min)
- [ ] New iOS SwiftUI project
- [ ] Name: `temp_1` (or your choice)
- [ ] Bundle ID: `com.yourname.temp-1`

### 2. Initialize Fastlane (3 min)
```bash
cd /path/to/temp_1
fastlane init          # Choose option 4 (Manual)
```

### 3. Create Views (10 min)
- [ ] Copy `ContentView1.swift` from guide
- [ ] Copy `ContentView2.swift` from guide  
- [ ] Update `ContentView.swift` with TabView
- [ ] **Update all project names** in the code (temp_0 → temp_1)

### 4. Configure Fastlane (5 min)
- [ ] Update `fastlane/Appfile` with your bundle ID
- [ ] Copy `fastlane/Fastfile` from guide (update project names)
- [ ] Copy `fastlane/Snapfile` from guide (update project names)

### 5. Create Screenshot Scheme (3 min) **CRITICAL**
- [ ] Xcode: Product → Scheme → Manage Schemes
- [ ] Duplicate main scheme → Name: `temp_1_Screenshots`
- [ ] Edit scheme → Build tab → Uncheck BOTH test targets
- [ ] Make scheme **Shared**

### 6. Setup UI Tests (2 min)
- [ ] Copy UI test code from guide
- [ ] Run: `bundle exec fastlane snapshot update` (choose y)

### 7. Test & Generate (2 min)
```bash
bundle exec fastlane clean_build      # Verify build works
bundle exec fastlane screenshots     # Generate screenshots
```

## ✅ Success Verification

You should get **8 screenshots**:
- `iPhone 16-01_AppLaunch.png`
- `iPhone 16-02_HomeTab.png`
- `iPhone 16-03_ProfileTab.png`
- `iPhone 16-04_BackToHome.png`
- `iPhone 16 Pro Max-01_AppLaunch.png`
- `iPhone 16 Pro Max-02_HomeTab.png`
- `iPhone 16 Pro Max-03_ProfileTab.png`
- `iPhone 16 Pro Max-04_BackToHome.png`

## 🚨 Critical Points

### ⚠️ Most Common Mistake
**Not creating the dedicated screenshot scheme properly**
- Must exclude test targets from **Build** tab (not just Test tab)
- Must be marked as **Shared**

### ⚠️ Project Name Updates Required
Replace `temp_0` with your project name in:
- [ ] `fastlane/Fastfile` (3 locations)
- [ ] `fastlane/Snapfile` (2 locations)
- [ ] UI test file names and content

### ⚠️ Bundle Identifier Updates
Replace `com.wiktorg.temp-0` with your bundle ID in:
- [ ] `fastlane/Appfile`

## 🎯 One-Command Success

Once setup is complete, this single command generates all screenshots:
```bash
bundle exec fastlane screenshots
```

## 📱 Easy Device Expansion

Add more devices by editing `fastlane/Snapfile`:
```ruby
devices([
  "iPhone 16",
  "iPhone 16 Pro Max",
  "iPhone SE (3rd generation)",     # Add this
  "iPad Pro (12.9-inch) (6th generation)"  # Add this
])
```

## 🌍 Easy Language Expansion

Add more languages by editing `fastlane/Snapfile`:
```ruby
languages([
  "en-US",
  "es-ES",    # Spanish
  "fr-FR",    # French
  "de-DE"     # German
])
```

---

**Follow this checklist and you'll have professional iOS snapshot testing in 30 minutes!** ⚡
