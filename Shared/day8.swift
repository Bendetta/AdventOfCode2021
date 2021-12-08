//
//  day8.swift
//  aoc2021
//
//  Created by Ben Liset on 12/8/21.
//

import Foundation

class day8: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day8.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day8.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day8.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day8.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var outputSegments = [1: 0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0]
        for line in input {
            let parts = line.split(separator: "|")
            let output = parts[1].split(whereSeparator: \.isWhitespace)
            output.forEach {
                outputSegments[$0.count]! += 1
            }
        }
        let oneSegmentLength = 2, fourSegmentLength = 4, sevenSegmentLength = 3, eightSegmentLength = 7
        return outputSegments[oneSegmentLength]! + outputSegments[fourSegmentLength]! + outputSegments[sevenSegmentLength]! + outputSegments[eightSegmentLength]!
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var total = 0
        for line in input {
            let parts = line.split(separator: "|")
            let patterns = parts[0].split(whereSeparator: \.isWhitespace)
            let output = parts[1].split(whereSeparator: \.isWhitespace)
            
            let one = patterns.first(where: { $0.count == 2 })!
            let four = patterns.first(where: { $0.count == 4 })!
            let seven = patterns.first(where: { $0.count == 3 })!
            let eight = patterns.first(where: { $0.count == 7 })!
            
            // 2, 3, 5
            var length5 = patterns.filter { $0.count == 5 }
            // 0, 6, 9
            var length6 = patterns.filter { $0.count == 6 }
            
            // 3 has all of 1
            let three = length5.first(where: { one.allSatisfy($0.contains)})!
            length5.removeAll(where: { $0 == three})
            
            // 9 has all of 3
            let nine = length6.first(where: { three.allSatisfy($0.contains)})!
            length6.removeAll(where: { $0 == nine })
            
            // 0 has all of 1
            let zero = length6.first(where: { one.allSatisfy($0.contains)})!
            length6.removeAll(where: { $0 == zero })
            
            // leaves us with 6
            let six = length6.first!
            
            // 6 has all of 5
            let five = length5.first(where: { $0.allSatisfy(six.contains)})!
            length5.removeAll(where: { $0 == five })
            
            // leaves us with 2
            let two = length5.first!
            
            let map = [
                String(zero.sorted()): "0",
                String(one.sorted()): "1",
                String(two.sorted()): "2",
                String(three.sorted()): "3",
                String(four.sorted()): "4",
                String(five.sorted()): "5",
                String(six.sorted()): "6",
                String(seven.sorted()): "7",
                String(eight.sorted()): "8",
                String(nine.sorted()): "9"]
            let numberString = output.map { map[String($0.sorted())]! }.joined()
            let number = Int(numberString)!
            total += number
        }
        return total
    }
    
    enum Segment {
        case top, topLeft, topRight, middle, bottomLeft, bottomRight, bottom
    }
    
    func generateMap(forPattern pattern: String, knownMapping: [Character: Segment]) -> [Character: Segment] {
        var updatedMapping = knownMapping
        switch pattern.count {
        case 2:
            return [pattern[0]: .topRight, pattern[1]: .bottomRight]
        case 3:
            for char in pattern {
                if knownMapping[char] == nil {
                    updatedMapping[char] = .top
                    break
                }
            }
            return updatedMapping
        case 4:
            var possibleSegments: [Segment] = [.topLeft, .middle]
            for char in pattern {
                if knownMapping[char] == nil {
                    updatedMapping[char] = possibleSegments.removeFirst()
                }
            }
            return updatedMapping
        case 7:
            var possibleSegments: [Segment] = [.bottomLeft, .bottom]
            for char in pattern {
                if knownMapping[char] == nil {
                    updatedMapping[char] = possibleSegments.removeFirst()
                }
            }
            return updatedMapping
        default:
            return knownMapping
        }
    }
}

fileprivate extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
