//
//  day6.swift
//  aoc2021
//
//  Created by Ben Liset on 12/6/21.
//

import Foundation

struct day6 {
    func runPart1Sample() -> Int {
        return runPart1(Input.day6.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day6.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day6.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day6.actual)
    }
    
    private func runPart1(_ input: [Int]) -> Int {
        var fish = input.map { Fish(withTimer: $0)}
        
        for _ in 0..<80 {
            var newSpawns = [Fish]()
            fish.forEach {
                if let newFish = $0.tick() {
                    newSpawns.append(newFish)
                }
            }
            fish.append(contentsOf: newSpawns)
        }
        return fish.count
    }
    
    private func runPart2(_ input: [Int]) -> Int {
        var fish = Array(repeating: 0, count: 9)
        for state in input {
            fish[state] += 1
        }
        
        for _ in 0..<256 {
            var newState = Array(repeating: 0, count: 9)
            let spawnedFish = fish[0]
            for index in 1..<fish.count {
                newState[index-1] = fish[index]
            }
            newState[6] += spawnedFish
            newState[8] += spawnedFish
            fish = newState
        }
        return fish.reduce(0, { return $0 + $1 })
    }
    
    class Fish {
        var timer: Int
        
        init(withTimer timer: Int) {
            self.timer = timer
        }
        
        func tick() -> Fish? {
            self.timer -= 1
            if timer < 0 {
                self.timer = 6
                return Fish(withTimer: 8)
            } else {
                return nil
            }
        }
    }
}
