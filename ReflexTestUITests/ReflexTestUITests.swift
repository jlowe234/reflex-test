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
    
    // Verify that the prompt is not updated on a tap
    func testBeginButtonPress() {
        let holdToStartButton = app.buttons["Hold to start"]
        let resultsLabel = app.staticTexts["Tap the green circle."]
        holdToStartButton.tap()
        XCTAssertFalse(resultsLabel.exists, "This label should not appear after a tap.")
    }
    
    // Verify that the long press begins a trial and waits 3-7 seconds to do so.
    func testBeginButtonLongPress() {
        let expectedElapsedMin = 3
        let expectedElapsedMax = 7
        var elapsedTime = 0
        let promise = expectation(description: "Circle updated.")
        let holdToStartButton = app.buttons["Hold to start"]
        
        holdToStartButton.press(forDuration: 1.1)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            elapsedTime += 1
            
            let resultsLabel = app.staticTexts["Tap the green circle."]
            
            if (resultsLabel.exists) {
                timer.invalidate()
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThanOrEqual(elapsedTime, expectedElapsedMin, "The update should have occurred after 3 seconds.")
        XCTAssertLessThanOrEqual(elapsedTime, expectedElapsedMax, "The update should have occurred within 7 seconds.")
    }
    
    // Verify that the circle is able to be clicked.
    func testCircleClick() {
        let holdToStartButton = app.buttons["Hold to start"]
        let circle = app.otherElements.containing(.button, identifier:"Hold to start").children(matching: .image).element
        
        holdToStartButton.press(forDuration: 1.1)
        
        let interimLabel = app.staticTexts["Tap the green circle."]
        
        if (interimLabel.waitForExistence(timeout: 10)) {
            circle.tap()
        } else {
            XCTFail("Green circle didn't appear in a timely fashion.")
        }
        
        let resultsLabel = app.staticTexts["Please repeat the trial by holding the button again."]
        
        XCTAssert(resultsLabel.exists, "The label should display the trial repeat message.")
    }
    
    // Test the full trial.
    func testFullIteration() {
        let holdToStartButton = app.buttons["Hold to start"]
        let circle = app.otherElements.containing(.button, identifier:"Hold to start").children(matching: .image).element
        
        for _ in 1...5 {
            holdToStartButton.press(forDuration: 1.1)
            let resultsLabel = app.staticTexts["Tap the green circle."]
            
            if (resultsLabel.waitForExistence(timeout: 10)) {
                circle.tap()
            } else {
                XCTFail("Green circle didn't appear in a timely fashion.")
            }
        }
        
        let expected = app.staticTexts["Your trial results are in: \r {\"tests\":[0,0,0,0,0],\"average\":0}"]
        XCTAssert(expected.exists, "The trial results should display.")
    }
}
