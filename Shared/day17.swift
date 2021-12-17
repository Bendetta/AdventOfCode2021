//
//  day17.swift
//  aoc2021
//
//  Created by Ben Liset on 12/17/21.
//

import Foundation

class day17: Puzzle {
    typealias Velocity = (Int,Int)
    
    func runPart1Sample() -> Int {
        return runPart1(Input.day17.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day17.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day17.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day17.actual)
    }
    
    private func runPart1(_ input: String) -> Int {
        let targetArea = getTargetArea(input)
        let y = targetArea.y.min()!
        // highest point is when velocity = 0, and y decreases by 1, so the sum of 0..<y
        let sum = y*(y+1)/2;
        return sum;
    }
    
    private func runPart2(_ input: String) -> Int {
        let targetArea = getTargetArea(input)
        let candidates = generatePossibleVelocities(for: targetArea)
        var validShots = 0
        for velocity in candidates {
            if test(velocity: velocity, to: targetArea) {
                validShots += 1
            }
        }
        return validShots
    }
    
    private func test(velocity: Velocity, to target: TargetArea) -> Bool {
        var x = 0, y = 0
        var dx = velocity.0, dy = velocity.1
        while y >= target.y.min()! {
            x = x + dx
            y = y + dy
            dx = max(0, dx-1) // move to 0
            dy -= 1
            if target.x.contains(x) {
                if target.y.contains(y) {
                    return true
                }
            } else if dx == 0 {
                break
            }
        }
        return false
    }
    
    private func getTargetArea(_ string: String) -> TargetArea {
        let parts = string.replacingOccurrences(of: ",", with: "").components(separatedBy: " ")
        let xParts = parts[2]
        let yParts = parts[3]
        
        let xRangeParts = xParts.components(separatedBy: "=")[1].components(separatedBy: "..")
        let yRangeParts = yParts.components(separatedBy: "=")[1].components(separatedBy: "..")
        
        let xRange = Int(xRangeParts[0])!...Int(xRangeParts[1])!
        let yRange = Int(yRangeParts[0])!...Int(yRangeParts[1])!
        return TargetArea(x: xRange, y: yRange)
    }
    
    private func generatePossibleVelocities(for target: TargetArea) -> [Velocity] {
        var velocities = [Velocity]()
        // lower bound is sum of integers from 1 to x, otherwise will never reach x before velocity is 0
        let xVelocityMin = Int(sqrt(Double(target.x.min()!*2)))
        for x in xVelocityMin...target.x.max()! {
            for y in target.y.min()!...abs(target.y.min()!) {
                velocities.append((x,y))
            }
        }
        return velocities
    }
    
    struct TargetArea {
        let x: ClosedRange<Int>
        let y: ClosedRange<Int>
        
        func contains(_ position: (Int,Int)) -> Bool {
            return x.contains(position.0) && y.contains(position.1)
        }
    }
    
    
}
