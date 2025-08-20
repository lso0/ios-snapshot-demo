// SimpleSnapshotUITests.swift
import XCTest

@MainActor
final class SimpleSnapshotUITests: XCTestCase {

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
