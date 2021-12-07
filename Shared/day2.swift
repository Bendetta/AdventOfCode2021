//
//  day2.swift
//  aoc2021
//
//  Created by Ben Liset on 12/2/21.
//

import Foundation

class day2: Puzzle {
    enum Direction {
        case forward(Int)
        case up(Int)
        case down(Int)
        
        init?(_ value: String) {
            let parts = value.split(whereSeparator: \.isWhitespace)
            let magnitude = Int(parts[1])!
            switch(parts[0]) {
            case "up":
                self = Direction.up(magnitude)
            case "down":
                self = Direction.down(magnitude)
            case "forward":
                self = Direction.forward(magnitude)
            default:
                return nil
            }
        }
    }
    func runPart1Sample() -> Int {
        let input = Input.day2.sample
        return runPart1(input)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day2.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day2.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day2.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let directions = input.compactMap { Direction($0) }
        
        var horizontal = 0, depth = 0
        
        for dir in directions {
            switch (dir) {
            case .forward(let val):
                horizontal += val
            case .up(let val):
                depth -= val
            case .down(let val):
                depth += val
            }
        }
        return horizontal * depth
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let directions = input.compactMap { Direction($0) }
        
        var horizontal = 0, depth = 0, aim = 0
        
        for dir in directions {
            switch (dir) {
            case .forward(let val):
                horizontal += val
                depth += aim * val
            case .up(let val):
                aim -= val
            case .down(let val):
                aim += val
            }
        }
        return horizontal * depth
    }
}
