//
//  TimeTrial.swift
//  ReflexTest
//
//  Created by Jonathan Lowe on 2/12/18.
//  Copyright © 2018 Jonathan Lowe. All rights reserved.
//

import Foundation

// Handle the trial and reporting of results.
class TimeTrial {
    private var results: TestResults
    
    // These track the time elapsed for the test.
    var timer: Timer?
    var timeElapsed: Int
    
    init() {
        results = TestResults()
        timeElapsed = 0
    }
    
    // Begin the timer for the trial.  Will return true if the timer was successfully started, or false if the trial is completed.
    func beginTimer() -> Bool {
        if (results.tests.count < 5) {
            timeElapsed = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            return true
        } else {
            return false
        }
    }
    
    @objc func updateTime() {
        timeElapsed += 1
    }
    
    // Complete the time trial and document the results.
    func stopTimer() {
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
            results.tests.append(timeElapsed)
            
            // Might as well calculate the average now too.
            results.calculateAverage()
        }
    }
    
    // Getters for the results
    func countCompletedTrials() -> Int {
        return results.tests.count
    }
    
    func returnResultsAsJSON() -> String {
        return results.reportResultsAsJSONString()
    }
    
    func returnAverage() -> Double {
        return results.average
    }
}
