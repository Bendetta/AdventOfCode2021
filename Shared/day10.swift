//
//  day10.swift
//  aoc2021
//
//  Created by Ben Liset on 12/10/21.
//

import Foundation

class day10: Puzzle {
    
    let openingChars: [Character] = ["(", "[", "{", "<"]
    
    let closingPairs: [Character:Character] = [
        "(": ")",
        "[": "]",
        "{": "}",
        "<": ">"
    ]
    
    struct Stack<Element> {
        var items: [Element] = []
        mutating func push(_ item: Element) {
            items.append(item)
        }
        mutating func pop() -> Element {
            return items.removeLast()
        }
        func peek() -> Element? {
            return items.last
        }
    }
    
    func runPart1Sample() -> Int {
        return runPart1(Input.day10.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day10.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day10.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day10.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var illegalCharacters: [Character] = []
        
        for line in input {
            var stack = Stack<Character>()
            
            for char in line {
                if openingChars.contains(char) {
                    stack.push(char)
                } else {
                    let prevChar = stack.pop()
                    if char != closingPairs[prevChar] {
                        illegalCharacters.append(char)
                        break
                    }
                }
            }
        }
        
        let score = illegalCharacters.reduce(0, {
            var charScore: Int
            switch $1 {
            case ")": charScore = 3
            case "]": charScore = 57
            case "}": charScore = 1197
            case ">": charScore = 25137
            default: charScore = 0
            }
            return $0 + charScore
        })
        return score
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var autoCompletedLines = [String]();
        for line in input {
            var stack = Stack<Character>()
            var corruptedLine = false
            for char in line {
                if openingChars.contains(char) {
                    stack.push(char)
                } else {
                    let prevChar = stack.pop()
                    if char != closingPairs[prevChar] {
                        corruptedLine = true
                        break
                    }
                }
            }
            
            guard !corruptedLine else {
                print("Corrupted Line")
                continue
            }
            
            var missingChars = ""
            while stack.peek() != nil {
                let char = stack.pop()
                missingChars += String(closingPairs[char]!)
            }
            guard !missingChars.isEmpty else {
                print("No missing characters for \(line)")
                continue
            }
            autoCompletedLines.append(missingChars)
        }
        
        let scores = autoCompletedLines.map { line in
            return line.reduce(0, {
                var charScore: Int
                switch $1 {
                case ")": charScore = 1
                case "]": charScore = 2
                case "}": charScore = 3
                case ">": charScore = 4
                default: charScore = 0
                }
                return $0 * 5 + charScore
            })
        }.sorted()        
        
        return scores[scores.count/2]
    }
}
