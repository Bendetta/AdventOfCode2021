//
//  day14.swift
//  aoc2021
//
//  Created by Ben Liset on 12/14/21.
//

import Foundation

class day14: Puzzle {
    func runPart1Sample() -> Int {
        let template = Input.day14.sample[0]
        let rules = Input.day14.sample[1].components(separatedBy: "\n")
        return runPart1(template: template, rules: rules)
    }
    
    func runPart1Actual() -> Int {
        let template = Input.day14.actual[0]
        let rules = Input.day14.actual[1].components(separatedBy: "\n")
        return runPart1(template: template, rules: rules)
    }
    
    func runPart2Sample() -> Int {
        let template = Input.day14.sample[0]
        let rules = Input.day14.sample[1].components(separatedBy: "\n")
        return runPart2(template: template, rules: rules)
    }
    
    func runPart2Actual() -> Int {
        let template = Input.day14.actual[0]
        let rules = Input.day14.actual[1].components(separatedBy: "\n")
        return runPart2(template: template, rules: rules)
    }
    
    private func runPart1(template: String, rules: [String]) -> Int {
        var pairMap = [String:String]()
        rules.forEach {
            guard !$0.isEmpty else { return }
            let parts = $0.components(separatedBy: "->")
            pairMap[parts[0].trimmingCharacters(in: .whitespaces)] = parts[1].trimmingCharacters(in: .whitespaces)
        }
        
        let newSequence = runSteps(template: template, pairs: pairMap, steps: 10)
        
        let elementQuantities = newSequence.reduce([Character:Int]()) { dict, char in
            let initialValue = dict[char] ?? 0
            var updatedDict = dict
            updatedDict[char] = initialValue + 1
            return updatedDict
        }.sorted { $0.value < $1.value }
        let highestValue = elementQuantities.last!
        let lowestValue = elementQuantities.first!
        return highestValue.value - lowestValue.value
    }
    
    private func runPart2(template: String, rules: [String]) -> Int {
        var pairMap = [String:String]()
        rules.forEach {
            guard !$0.isEmpty else { return }
            let parts = $0.components(separatedBy: "->")
            pairMap[parts[0].trimmingCharacters(in: .whitespaces)] = parts[1].trimmingCharacters(in: .whitespaces)
        }
        
        var templatePairs = [String:Int]()
        var characterCount = [String:Int]()
        for (index, char) in template.enumerated() {
            if characterCount[String(char)] == nil {
                characterCount[String(char)] = 1
            } else {
                characterCount[String(char)]! += 1
            }
            guard index < template.count - 1 else { break }
            
            let startIndex = template.index(template.startIndex, offsetBy: index)
            let endIndex = template.index(template.startIndex, offsetBy: index + 1)
            let pair = String(template[startIndex...endIndex])
            let initialValue = templatePairs[pair] ?? 0
            templatePairs[pair] = initialValue + 1
        }
        for _ in 0..<40 {
            let (newPairs, newChars) = generateNewPairs(sequencePairs: templatePairs, insertionRules: pairMap)
            templatePairs = newPairs
            characterCount.merge(newChars, uniquingKeysWith: { $0 + $1})
        }
        
        let charCount = characterCount.sorted { $0.value < $1.value }
        let highestValue = charCount.last!
        let lowestValue = charCount.first!
        return highestValue.value - lowestValue.value
    }
    
    private func runSteps(template: String, pairs: [String: String], steps: Int) -> String {
        guard steps > 0 else {
            return template
        }
        var newSequence = ""
        
        for (index, char) in template.enumerated() {
            newSequence += String(char)
            guard index < template.count - 1 else { break }
            let startIndex = template.index(template.startIndex, offsetBy: index)
            let endIndex = template.index(template.startIndex, offsetBy: index + 1)
            let pair = String(template[startIndex...endIndex])
            let insertedChar = pairs[pair]!
            newSequence += insertedChar
        }
        
        return runSteps(template: newSequence, pairs: pairs, steps: steps - 1)
    }
    
    private func generateNewPairs(sequencePairs: [String:Int], insertionRules rules: [String:String]) -> ([String:Int], [String:Int]) {
        var newDict = [String:Int]()
        var newCharacters = [String:Int]()
        for kvp in sequencePairs {
            guard let newChar = rules[kvp.key] else { assertionFailure("No match for \(kvp.key)")
                return ([:], [:])
            }
            
            let appearances = kvp.value
            let initialCharValue = newCharacters[newChar] ?? 0
            newCharacters[newChar] = initialCharValue + (1 * appearances)
            
            let newPair1 = String(kvp.key.first!) + newChar
            let initialValue1 = newDict[newPair1] ?? 0
            newDict[newPair1] = initialValue1 + (1 * appearances)
            
            let newPair2 = newChar + String(kvp.key.last!)
            let initialValue2 = newDict[newPair2] ?? 0
            newDict[newPair2] = initialValue2 + (1 * appearances)
        }
        return (newDict,newCharacters)
    }
}
