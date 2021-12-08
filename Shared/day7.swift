//
//  day7.swift
//  aoc2021
//
//  Created by Ben Liset on 12/6/21.
//

import Foundation

class day7: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day7.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day7.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day7.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day7.actual)
    }
    
    func runPart1(_ input: [Int]) -> Int {
        let medianIndex = Int(ceil(Double(input.count)/2.0))
        let median = input.sorted()[medianIndex]
        let fuelCost = input.reduce(0, { $0 + (abs($1 - median))})
        return fuelCost
    }
    
    func runPart2(_ input: [Int]) -> Int {
        let sum = input.reduce(0.0, { $0 + Double($1)})
        let averageHigh = Int((sum/Double(input.count)).rounded())
        let averageLow = Int(sum/Double(input.count))
        
        let fuelCostHighAverage = input.reduce(0) { (acc, val) in
            let distance = abs(val-averageHigh)
            let cost = distance * (distance + 1) / 2
            return acc + cost
        }
        let fuelCostLowAverage = input.reduce(0) { (acc, val) in
            let distance = abs(val-averageLow)
            let cost = distance * (distance + 1) / 2
            return acc + cost
        }
        return min(fuelCostLowAverage, fuelCostHighAverage)
    }
}
