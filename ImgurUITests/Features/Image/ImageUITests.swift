//
//  ImageUITests.swift
//  ImgurUITests
//
//  Created by Daniel Griso Filho on 30/01/23.
//

import XCTest

final class ImageUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testOpenDetailsView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.children(matching: .cell)
            .element(boundBy: 0).otherElements
            .containing(.image, identifier:"iCloud download")
            .element.tap()
        
        XCTAssertNotNil(app.staticTexts)
        
    }
    
    func testBackToList() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.children(matching: .cell)
            .element(boundBy: 0).otherElements
            .containing(.image, identifier:"iCloud download")
            .element.tap()
        
        XCTAssertNotNil(app.staticTexts)
        
        app.navigationBars.buttons["Gallery"].tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
