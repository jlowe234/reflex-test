//
//  ReflexTestTests.swift
//  ReflexTestTests
//
//  Created by Jonathan Lowe on 2/12/18.
//  Copyright © 2018 Jonathan Lowe. All rights reserved.
//

import XCTest
@testable import ReflexTest

var timeTrialTest: TimeTrial!
class ReflexTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        timeTrialTest = TimeTrial()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        timeTrialTest = nil
        super.tearDown()
    }
    
    // Double check to insure you cant invalidate a timer that doesnt exist.
    func testNilTimerStopping() {
        XCTAssertNil(timeTrialTest.timer, "Timer should be nil")
        XCTAssertNoThrow(timeTrialTest.stopTimer(), "Timer stopping should not throw error")
    }
    
    // Verify the various states of the timer.
    func testTimerState() {
        XCTAssertNil(timeTrialTest.timer, "Timer should begin as nil.")
        XCTAssertTrue(timeTrialTest.beginTimer(), "Timer should return successfully.")
        XCTAssert((timeTrialTest.timer?.isValid)!, "Timer should be valid after beginning.")
        timeTrialTest.stopTimer()
        XCTAssertNil(timeTrialTest.timer, "Timer should be nil again.")
    }
    
    // Verify that only five trials can be completed.
    func testMaximumNumberOfTrials() {
        let expected = 5
        for index in 1...7 {
            if (index <= 5) {
                XCTAssertTrue(timeTrialTest.beginTimer(), "Timer should return successfully for 5 tries.")
                XCTAssertNotNil(timeTrialTest.timer, "Timer should exist.")
                XCTAssertTrue((timeTrialTest.timer?.isValid)!, "Timer should be valid.")
                timeTrialTest.stopTimer()
            } else {
                XCTAssertFalse(timeTrialTest.beginTimer(), "Timer should not return successfully after 5 trials.")
                XCTAssertNil(timeTrialTest.timer, "Timer should not exist.")
            }
        }
        
        XCTAssertEqual(timeTrialTest.countCompletedTrials(), expected, "There should be 5 trials logged.")
    }
    
    // Validate that the average is calculated correctly.
    func testAverage() {
        let expectedTestQty = 3
        let expectedAverage = 4.0
        for index in 1...3 {
            let promise = expectation(description: "Time trial completed")
            XCTAssertTrue(timeTrialTest.beginTimer(), "Timer should return successfully for 5 tries.")
            
            // Add 3 tests to the model. Stopping at 2, 4, 6.
            let interval = 2 * index
            Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: false, block: { _ in
                timeTrialTest.stopTimer()
                promise.fulfill()
            })
            
            waitForExpectations(timeout: 10, handler: nil)
        }
        
        XCTAssertEqual(timeTrialTest.countCompletedTrials(), expectedTestQty, "There should be 3 tests.")
        XCTAssertEqual(timeTrialTest.returnAverage(), expectedAverage, "Average time is not calculating correctly.")
    }
    
    // Validate the JSON outputs as expected.
    func testJSON() {
        let initExpected = TestResults()
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(initExpected)
            let expected = String(data: data, encoding: .utf8)
            
            XCTAssertEqual(timeTrialTest.returnResultsAsJSON(), expected!, "JSON does not output as expected")
        } catch {
            XCTFail("Couldn't create expectation because of \(error.localizedDescription)")
        }
    }
}
