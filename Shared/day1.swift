//
//  day1.swift
//  aoc2021
//
//  Created by Ben Liset on 12/1/21.
//

import Foundation

struct day1 {
    
    func runPart1Sample() -> Int {
        let input = Input.day1.part1sample
        
        return runPart1(input);
    }
    
    func runPart1Actual() -> Int {
        let input = Input.day1.part1actual
        
        return runPart1(input);
    }
    
    func runPart2Sample() -> Int {
        let input = Input.day1.part1sample
        
        return runPart2(input);
    }
    
    func runPart2Actual() -> Int {
        let input = Input.day1.part1actual
        
        return runPart2(input);
    }
    
    private func runPart1(_ input: [Int]) -> Int {
        var previousValue = input.first!
        
        var increased = 0, decreased = 0
        
        for value in input.suffix(from: 1) {
            if value > previousValue {
                increased += 1
            } else if value < previousValue {
                decreased += 1
            }
            previousValue = value
        }
        
        return increased
    }
    
    private func runPart2(_ input: [Int]) -> Int {
        var previousValue = input[0] + input[1] + input[2]
        
        var increased = 0, decreased = 0
        
        for i in 1...input.count-3 {
            let sum = input[i] + input[i+1] + input[i+2]
            if sum > previousValue {
                increased += 1
            } else if sum < previousValue {
                decreased += 1
            }
            previousValue = sum
        }
        
        return increased
    }
    
}
