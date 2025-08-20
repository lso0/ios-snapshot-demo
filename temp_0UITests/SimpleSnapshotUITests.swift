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

        // Wait for the app to load
        let helloWorldText = app.staticTexts["Hello, world1!"]
        XCTAssertTrue(helloWorldText.waitForExistence(timeout: 5))

        // Take main screen snapshot
        snapshot("01MainScreen")        // @MainActor API
    }
}
