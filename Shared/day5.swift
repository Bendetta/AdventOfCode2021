//
//  day5.swift
//  aoc2021
//
//  Created by Ben Liset on 12/4/21.
//

import Foundation

struct day5 {
    func runPart1Sample() -> Int {
        return runPart1(Input.day5.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day5.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day5.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day5.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var lineMap = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
        for line in input {
            let parts = line.replacingOccurrences(of: "->", with: "~").split(separator: "~")
            let start = parts[0].trimmingCharacters(in: .whitespaces).split(separator: ",")
            let x1 = Int(start[0])!
            let y1 = Int(start[1])!
            let end = parts[1].trimmingCharacters(in: .whitespaces).split(separator: ",")
            let x2 = Int(end[0])!
            let y2 = Int(end[1])!
            if x1 == x2 {
                for y in min(y1,y2)...max(y1,y2) {
                    lineMap[x1][y] += 1
                }
            }
            else if y1 == y2 {
                for x in min(x1,x2)...max(x1,x2) {
                   lineMap[x][y1] += 1
                }
            }
        }
        let overlaps = lineMap.flatMap { $0 }.filter { $0 > 1 }.count
        return overlaps
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var lineMap = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
        for line in input {
            let parts = line.replacingOccurrences(of: "->", with: "~").split(separator: "~")
            let start = parts[0].trimmingCharacters(in: .whitespaces).split(separator: ",")
            let x1 = Int(start[0])!
            let y1 = Int(start[1])!
            let end = parts[1].trimmingCharacters(in: .whitespaces).split(separator: ",")
            let x2 = Int(end[0])!
            let y2 = Int(end[1])!
            if x1 == x2 {
                for y in min(y1,y2)...max(y1,y2) {
                    lineMap[x1][y] += 1
                }
            }
            else if y1 == y2 {
                for x in min(x1,x2)...max(x1,x2) {
                   lineMap[x][y1] += 1
                }
            } else {
                var xNums = [Int](min(x1,x2)...max(x1,x2))
                if x1 > x2 {
                    xNums = xNums.reversed()
                }
                var yNums = [Int](min(y1,y2)...max(y1,y2))
                if y1 > y2 {
                    yNums = yNums.reversed()
                }
                for i in 0..<xNums.count {
                    let x = xNums[i], y = yNums[i]
                    lineMap[x][y] += 1
                }
            }
        }
        let overlaps = lineMap.flatMap { $0 }.filter { $0 > 1 }.count
        return overlaps
    }
}
