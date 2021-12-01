//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Ben Liset on 12/1/21.
//

import XCTest
@testable import aoc2021

class Tests_iOS: XCTestCase {

    func test_day1Part1Sample() {
        let value = day1().runPart1Sample()
        
        XCTAssertEqual(value, 7)
    }
    
    func test_day1Part1Actual() {
        let value = day1().runPart1Actual()
        
        XCTAssertEqual(value, 1298)
    }
    
    func test_day1Part2Sample() {
        let value = day1().runPart2Sample()
        
        XCTAssertEqual(value, 5)
    }
    
    func test_day1Part2Actual() {
        let value = day1().runPart2Actual()
        
        XCTAssertEqual(value, 1248)
    }
}
