//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Ben Liset on 12/1/21.
//

import XCTest
@testable import aoc2021

class Tests_iOS: XCTestCase {

    // MARK: Day 1
    
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
    
    // MARK: Day 2
    
    func test_day2Part1Sample() {
        let value = day2().runPart1Sample()
        XCTAssertEqual(value, 150)
    }
    
    func test_day2Part1Actual() {
        let value = day2().runPart1Actual()
        XCTAssertEqual(value, 1936494)
    }
    
    func test_day2Part2Sample() {
        let value = day2().runPart2Sample()
        XCTAssertEqual(value, 900)
    }
    
    func test_day2Part2Actual() {
        let value = day2().runPart2Actual()
        XCTAssertEqual(value, 1997106066)
    }
    
    // MARK: Day 3
    
    func test_day3Part1Sample() {
        let value = day3().runPart1Sample()
        XCTAssertEqual(value, 198)
    }
    
    func test_day3Part1Actual() {
        let value = day3().runPart1Actual()
        XCTAssertEqual(value, 3277364)
    }
    
    func test_day3Part2Sample() {
        let value = day3().runPart2Sample()
        XCTAssertEqual(value, 230)
    }
    
    func test_day3Part2Actual() {
        let value = day3().runPart2Actual()
        XCTAssertEqual(value, 5736383)
    }
}
