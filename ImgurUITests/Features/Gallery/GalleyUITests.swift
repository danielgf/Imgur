//
//  GalleyUITests.swift
//  ImgurUITests
//
//  Created by Daniel Griso Filho on 30/01/23.
//

import XCTest

final class GalleyUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testScrollList() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.element.swipeUp()
        app.collectionViews.element.swipeDown()
    }
    
    func testCellTap() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.element.tap()
        
    }
    
    func testNavigationTitle() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.navigationBars["Gallery"].staticTexts["Gallery"].label, "Gallery")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
