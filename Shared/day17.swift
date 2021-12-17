//
//  day17.swift
//  aoc2021
//
//  Created by Ben Liset on 12/17/21.
//

import Foundation

class day17: Puzzle {
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
        let candidates = generatePossibleVelocities(for: targetArea)
        var highestProbe: Probe!
        for velocity in candidates {
            let probe = Probe(withVelocity: velocity)
            if highestProbe == nil {
                highestProbe = probe
            }
            var isFinished = false
            while !isFinished {
                isFinished = probe.move(towards: targetArea)
            }
            if targetArea.contains((probe.x, probe.y)) {
                if highestProbe.highestAltitude < probe.highestAltitude {
                    highestProbe = probe
                }
            }
        }
        return highestProbe.highestAltitude
    }
    
    private func runPart2(_ input: String) -> Int {
        let targetArea = getTargetArea(input)
        let candidates = generatePossibleVelocities(for: targetArea)
        var validShots = [(Int,Int)]()
        for velocity in candidates {
            let probe = Probe(withVelocity: velocity)
            var isFinished = false
            while !isFinished {
                isFinished = probe.move(towards: targetArea)
            }
            if targetArea.contains((probe.x, probe.y)) {
                validShots.append(velocity)
            }
        }
        return validShots.count
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
    
    private func generatePossibleVelocities(for target: TargetArea) -> [(Int,Int)] {
        var velocities = [(Int,Int)]()
        for x in 0...target.x.max()! {
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
    
    class Probe {
        var x = 0
        var y = 0
        
        var velocity: (Int,Int)
        var positions = [(0,0)]
        
        var highestAltitude: Int {
            return positions.max(by: { $0.1 < $1.1 })!.1
        }
        
        init(withVelocity velocity: (Int,Int)) {
            self.velocity = velocity
        }
        
        func move(towards target: TargetArea) -> Bool {
            x += velocity.0
            y += velocity.1
            positions.append((x,y))
            
            let dX = velocity.0 < 0 ? 1 : -1 // towards 0
            let newVelocityX = max(0, velocity.0 + dX)
            let newVelocityY = velocity.1 - 1
            self.velocity = (newVelocityX, newVelocityY)
            
            return isPastOrIn(target: target)
        }
        
        private func isPastOrIn(target: TargetArea) -> Bool {
            if target.contains((x,y)) {
                return true
            }
            
            // check X
            let xDir = velocity.0
            if xDir == 0 && !target.x.contains(x) {
                return true
            }
            if xDir > target.x.max()! {
                return true
            }
            
            // check Y
            if y < target.y.min()! {
                return true
            }
            
            return false
        }
    }
}
