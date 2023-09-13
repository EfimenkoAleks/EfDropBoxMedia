//
//  EfDropBoxMediaUITests.swift
//  EfDropBoxMediaUITests
//
//  Created by user on 13.09.2023.
//

import XCTest

final class EfDropBoxMediaUITests: XCTestCase {
    
    func test_myFirstTest() {
            // element queries
            let app = XCUIApplication()
            let mainTable = app.tables

            let item1Cell = mainTable.staticTexts["Item 1"]
            let item2Cell = mainTable.staticTexts["Item 2"]
            let item3Cell = mainTable.staticTexts["Item 3"]
            let item4Cell = mainTable.staticTexts["Item 4"]

            // test
            app.launch()

            // check cells
            XCTAssert(item1Cell.exists)
            XCTAssert(item2Cell.exists)
            XCTAssert(item3Cell.exists)
            XCTAssert(item4Cell.exists)

            // navigate to detail
            item1Cell.tap()

            // navigate to detail
            item4Cell.tap()
        }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let button = app.buttons["ButtonIdentifier"]
        XCTAssertTrue(button.exists)
        button.tap()
        
        let label = app.staticTexts["LabelIdentifier"]
        XCTAssertEqual(label.label, "Expected Label Text")
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
