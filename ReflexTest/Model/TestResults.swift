//
//  TestResults.swift
//  ReflexTest
//
//  Created by Jonathan Lowe on 2/12/18.
//  Copyright © 2018 Jonathan Lowe. All rights reserved.
//

import Foundation

// Storage for the trial data.
struct TestResults: Codable {
    var tests: [Int]
    var average: Double
    
    init() {
        tests = []
        average = 0.0
    }
    
    // Calculate the average based on the tests that are available and store it.
    mutating func calculateAverage() {
        var total = 0
        total = tests.reduce(0, +)
        
        average = Double(total) / Double(tests.count)
    }
    
    func reportResultsAsJSONString() -> String {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            
            return jsonString ?? "There are no results."
        } catch {
            return error.localizedDescription
        }
    }
}
