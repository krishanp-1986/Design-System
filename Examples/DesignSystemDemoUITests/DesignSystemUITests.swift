import XCTest

/// UI tests for the Design System demo app.
final class DesignSystemUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testCatalogTitleIsVisible() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Design System"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testBrandColorSectionExists() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Brand"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Typography"].exists)
        XCTAssertTrue(app.staticTexts["Light"].exists)
        XCTAssertTrue(app.staticTexts["Dark"].exists)
    }
}
