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
    
    // MARK: Day 8
    
    func test_day8Part1Sample() {
        let value = day8().runPart1Sample()
        XCTAssertEqual(value, 26)
    }
    
    func test_day8Part1Actual() {
        let value = day8().runPart1Actual()
        XCTAssertEqual(value, 301)
    }
    
    func test_day8Part2Sample() {
        let value = day8().runPart2Sample()
        XCTAssertEqual(value, 61229)
    }
    
    func test_day8Part2Actual() {
        let value = day8().runPart2Actual()
        XCTAssertEqual(value, 908067)
    }
    
    // MARK: Day 9
    
    func test_day9Part1Sample() {
        let value = day9().runPart1Sample()
        XCTAssertEqual(value, 15)
    }
    
    func test_day9Part1Actual() {
        let value = day9().runPart1Actual()
        XCTAssertEqual(value, 539)
    }
    
    func test_day9Part2Sample() {
        let value = day9().runPart2Sample()
        XCTAssertEqual(value, 1134)
    }
    
    func test_day9Part2Actual() {
        let value = day9().runPart2Actual()
        XCTAssertEqual(value, 736920)
    }
    
    // MARK: Day 10
    
    func test_day10Part1Sample() {
        let value = day10().runPart1Sample()
        XCTAssertEqual(value, 26397)
    }
    
    func test_day10Part1Actual() {
        let value = day10().runPart1Actual()
        XCTAssertEqual(value, 344193)
    }
    
    func test_day10Part2Sample() {
        let value = day10().runPart2Sample()
        XCTAssertEqual(value, 288957)
    }
    
    func test_day10Part2Actual() {
        let value = day10().runPart2Actual()
        XCTAssertEqual(value, 3241238967)
    }
    
    // MARK: Day 11
    
    func test_day11Part1Sample() {
        let value = day11().runPart1Sample()
        XCTAssertEqual(value, 1656)
    }
    
    func test_day11Part1Actual() {
        let value = day11().runPart1Actual()
        XCTAssertEqual(value, 1679)
    }
    
    func test_day11Part2Sample() {
        let value = day11().runPart2Sample()
        XCTAssertEqual(value, 195)
    }
    
    func test_day11Part2Actual() {
        let value = day11().runPart2Actual()
        XCTAssertEqual(value, 519)
    }
    
    // MARK: Day 12
    
    func test_day12Part1Sample() {
        let value = day12().runPart1Sample()
        XCTAssertEqual(value, 226)
    }
    
    func test_day12Part1Actual() {
        let value = day12().runPart1Actual()
        XCTAssertEqual(value, 4104)
    }
    
    func test_day12Part2Sample() {
        let value = day12().runPart2Sample()
        XCTAssertEqual(value, 3509)
    }
    
    func test_day12Part2Actual() {
        let value = day12().runPart2Actual()
        XCTAssertEqual(value, 119760)
    }
    
    // MARK: Day 13
    
    func test_day13Part1Sample() {
        let value = day13().runPart1Sample()
        XCTAssertEqual(value, 17)
    }
    
    func test_day13Part1Actual() {
        let value = day13().runPart1Actual()
        XCTAssertEqual(value, 724)
    }
    
    func test_day13Part2Sample() {
        let value = day13().runPart2Sample()
        //        #####
        //        #...#
        //        #...#
        //        #...#
        //        #####
        XCTAssertEqual(value, 16)
    }
    
    func test_day13Part2Actual() {
        let value = day13().runPart2Actual()
        //            .##..###....##.###..####.###..#..#.#...
        //            #..#.#..#....#.#..#.#....#..#.#..#.#...
        //            #....#..#....#.###..###..#..#.#..#.#...
        //            #....###.....#.#..#.#....###..#..#.#...
        //            #..#.#....#..#.#..#.#....#.#..#..#.#...
        //            .##..#.....##..###..####.#..#..##..####
        //  CPJBERUL
        XCTAssertEqual(value, 95)
    }
    
    // MARK: Day 14
    
    func test_day14Part1Sample() {
        let value = day14().runPart1Sample()
        XCTAssertEqual(value, 1588)
    }
    
    func test_day14Part1Actual() {
        let value = day14().runPart1Actual()
        XCTAssertEqual(value, 2010)
    }
    
    func test_day14Part2Sample() {
        let value = day14().runPart2Sample()
        XCTAssertEqual(value, 2188189693529)
    }
    
    func test_day14Part2Actual() {
        let value = day14().runPart2Actual()
        XCTAssertEqual(value, 2437698971143)
    }
    
    // MARK: Day 15
    
    func test_day15Part1Sample() {
        let value = day15().runPart1Sample()
        XCTAssertEqual(value, 40)
    }
    
    func test_day15Part1Actual() {
        let value = day15().runPart1Actual()
        XCTAssertEqual(value, 595)
    }
    
    func test_day15Part2Sample() {
        let value = day15().runPart2Sample()
        XCTAssertEqual(value, 315)
    }
    
    func test_day15Part2Actual() {
        let value = day15().runPart2Actual()
        XCTAssertEqual(value, 2914)
    }
    
    // MARK: Day 16
    
    func test_day16Part1Sample() {
        let value = day16().runPart1Sample()
        XCTAssertEqual(value, 31)
    }
    
    func test_day16Part1Actual() {
        let value = day16().runPart1Actual()
        XCTAssertEqual(value, 917)
    }
    
    func test_day16Part2Sample() {
        let value = day16().runPart2Sample()
        XCTAssertEqual(value, 54)
    }
    
    func test_day16Part2Actual() {
        let value = day16().runPart2Actual()
        XCTAssertEqual(value, 2536453523344)
    }
    
    // MARK: Day 17
    
    func test_day17Part1Sample() {
        let value = day17().runPart1Sample()
        XCTAssertEqual(value, 45)
    }
    
    func test_day17Part1Actual() {
        let value = day17().runPart1Actual()
        XCTAssertEqual(value, 6555)
    }
    
    func test_day17Part2Sample() {
        let value = day17().runPart2Sample()
        XCTAssertEqual(value, 112)
    }
    
    func test_day17Part2Actual() {
        let value = day17().runPart2Actual()
        XCTAssertEqual(value, 4973)
    }
    
    // MARK: Day 21
    
    func test_day21Part1Sample() {
        let value = day21().runPart1Sample()
        XCTAssertEqual(value, 739785)
    }
    
    func test_day21Part1Actual() {
        let value = day21().runPart1Actual()
        XCTAssertEqual(value, 805932)
    }
    
    func test_day21Part2Sample() {
        let value = day21().runPart2Sample()
        XCTAssertEqual(value, 444356092776315)
    }
    
    func test_day21Part2Actual() {
        let value = day21().runPart2Actual()
        XCTAssertEqual(value, 133029050096658)
    }
    
    // MARK: Day 22
    
    func test_day22Part1Sample() {
        let value = day22().runPart1Sample()
        XCTAssertEqual(value, 590784)
    }
    
    func test_day22Part1Actual() {
        let value = day22().runPart1Actual()
        XCTAssertEqual(value, 610196)
    }
    
    func test_day22Part2Sample() {
        let value = day22().runPart2Sample()
        XCTAssertEqual(value, 2758514936282235)
    }
    
    func test_day22Part2Actual() {
        let value = day22().runPart2Actual()
        // Not working for actual data
        XCTAssertEqual(value, 610196)
    }
    
    // MARK: Day 25
    
    func test_day25Part1Sample() {
        let value = day25().runPart1Sample()
        XCTAssertEqual(value, 58)
    }
    
    func test_day25Part1Actual() {
        let value = day25().runPart1Actual()
        XCTAssertEqual(value, 486)
    }
}
