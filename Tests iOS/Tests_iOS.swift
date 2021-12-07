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
    
    // MARK: Day 4
    
    func test_day4Part1Sample() {
        let value = day4().runPart1Sample()
        XCTAssertEqual(value, 4512)
    }
    
    func test_day4Part1Actual() {
        let value = day4().runPart1Actual()
        XCTAssertEqual(value, 14093)
    }
    
    func test_day4Part2Sample() {
        let value = day4().runPart2Sample()
        XCTAssertEqual(value, 1924)
    }
    
    func test_day4Part2Actual() {
        let value = day4().runPart2Actual()
        XCTAssertEqual(value, 17388)
    }
    
    // MARK: Day 5
    
    func test_day5Part1Sample() {
        let value = day5().runPart1Sample()
        XCTAssertEqual(value, 5)
    }
    
    func test_day5Part1Actual() {
        let value = day5().runPart1Actual()
        XCTAssertEqual(value, 7085)
    }
    
    func test_day5Part2Sample() {
        let value = day5().runPart2Sample()
        XCTAssertEqual(value, 12)
    }
    
    func test_day5Part2Actual() {
        let value = day5().runPart2Actual()
        XCTAssertEqual(value, 20271)
    }
    
    // MARK: Day 6
    
    func test_day6Part1Sample() {
        let value = day6().runPart1Sample()
        XCTAssertEqual(value, 5934)
    }
    
    func test_day6Part1Actual() {
        let value = day6().runPart1Actual()
        XCTAssertEqual(value, 380758)
    }
    
    func test_day6Part2Sample() {
        let value = day6().runPart2Sample()
        XCTAssertEqual(value, 26984457539)
    }
    
    func test_day6Part2Actual() {
        let value = day6().runPart2Actual()
        XCTAssertEqual(value, 1710623015163)
    }
    
    // MARK: Day 7
    
    func test_day7Part1Sample() {
        let value = day7().runPart1Sample()
        XCTAssertEqual(value, 37)
    }
    
    func test_day7Part1Actual() {
        let value = day7().runPart1Actual()
        XCTAssertEqual(value, 339321)
    }
    
    func test_day7Part2Sample() {
        let value = day7().runPart2Sample()
        XCTAssertEqual(value, 168)
    }
    
    func test_day7Part2Actual() {
        let value = day7().runPart2Actual()
        XCTAssertEqual(value, 95476244)
    }
}
