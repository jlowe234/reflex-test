//
//  ReflexTestUITests.swift
//  ReflexTestUITests
//
//  Created by Jonathan Lowe on 2/12/18.
//  Copyright © 2018 Jonathan Lowe. All rights reserved.
//

import XCTest
@testable import ReflexTest

var app: XCUIApplication!
class ReflexTestUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Verify the initial state of the trial button.
    func testBeginButtonInit() {
        XCTAssert(app.buttons["Hold to start"].exists, "The button should exist with Hold to start as the title upon initialization")
    }
}
