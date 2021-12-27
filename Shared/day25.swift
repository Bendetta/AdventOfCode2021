//
//  day25.swift
//  aoc2021
//
//  Created by Ben Liset on 12/27/21.
//

import Foundation

class day25: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day25.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day25.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day25.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day25.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var map = parseInput(input)
        
        var isMoving = true
        var steps = 0
        while isMoving {
            (map,isMoving) = step(map)
            steps += 1
        }
        return steps
    }
    
    private func runPart2(_ input: [String]) -> Int {
        return 0
    }
    
    private func parseInput(_ input: [String]) -> [[String]] {
        return input.map { line in line.map { String($0) }}
    }
    
    private func printRegion(_ region: [[String]]) {
        for row in 0..<region.count {
            var output = ""
            for col in 0..<region[row].count {
                output += region[row][col]
            }
            print(output)
        }
    }
    
    private func step(_ region: [[String]]) -> ([[String]],Bool) {
        let (rightStep,movedRight) = moveRight(region)
        let (downStep,movedDown) = moveDown(rightStep)
        
        return (downStep, movedRight || movedDown)
        
    }
    
    private func moveRight(_ region: [[String]]) -> ([[String]], Bool) {
        var updatedRegion = region
        var didMove = false
        
        for row in 0..<region.count {
            for col in 0..<region[row].count {
                if region[row][col] == ">" {
                    let nextCol = col < region[row].count - 1 ? col + 1 : 0
                    if region[row][nextCol] == "." {
                        updatedRegion[row][col] = "."
                        updatedRegion[row][nextCol] = ">"
                        didMove = true
                    }
                }
            }
        }
        
        return (updatedRegion,didMove)
    }
    
    private func moveDown(_ region: [[String]]) -> ([[String]], Bool) {
        var updatedRegion = region
        var didMove = false
        
        for row in 0..<region.count {
            for col in 0..<region[row].count {
                if region[row][col] == "v" {
                    let nextRow = row < region.count - 1 ? row + 1 : 0
                    if region[nextRow][col] == "." {
                        updatedRegion[row][col] = "."
                        updatedRegion[nextRow][col] = "v"
                        didMove = true
                    }
                }
            }
        }
        
        return (updatedRegion,didMove)
    }
}
