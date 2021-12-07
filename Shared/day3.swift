//
//  day3.swift
//  aoc2021
//
//  Created by Ben Liset on 12/3/21.
//

import Foundation

class day3: Puzzle {
    
    func runPart1Sample() -> Int {
        return runPart1(Input.day3.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day3.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day3.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day3.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let lineLength = input.first!.count
        var ones = [Int].init(repeating: 0, count: lineLength)
        var zeroes = [Int].init(repeating: 0, count: lineLength)
        
        var gammaString = "", epsilonString = ""
        
        for line in input {
            for (index, char) in line.enumerated() {
                if char == "1" {
                    ones[index] += 1
                } else {
                    zeroes[index] += 1
                }
            }
        }
        
        for i in 0..<ones.count {
            assert(ones[i] != zeroes[i], "Ones and Zeroes match for \(i)")
            if ones[i] > zeroes[i] {
                gammaString += "1"
                epsilonString += "0"
            } else {
                gammaString += "0"
                epsilonString += "1"
            }
        }
        
        let gamma = convertToInt(binary: gammaString)
        let epsilon = convertToInt(binary: epsilonString)
        print("gamma: \(gamma)")
        print("epsilon: \(epsilon)")
        return gamma * epsilon
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let oxygenBinary = findCandidates(candidates: input, position: 0) { $0 >= $1 }.first!
        let oxygen = convertToInt(binary: oxygenBinary)
        
        let coBinary = findCandidates(candidates: input, position: 0) { $0 < $1}.first!
        let co = convertToInt(binary: coBinary)
        return oxygen * co
    }
    
    private func findCandidates(candidates: [String], position: Int, comparison: (Int,Int) -> Bool) -> [String] {
        if candidates.count <= 1 {
            return candidates
        }
        
        var ones = [String]()
        var zeroes = [String]()
        
        for candidate in candidates {
            if candidate[candidate.index(candidate.startIndex, offsetBy: position)] == "0" {
                zeroes.append(candidate)
            } else {
                ones.append(candidate)
            }
        }
        
        if comparison(ones.count, zeroes.count) {
            return findCandidates(candidates: ones, position: position + 1, comparison: comparison)
        } else {
            return findCandidates(candidates: zeroes, position: position + 1, comparison: comparison)
        }
    }
    
    private func convertToInt(binary: String) -> Int {
        var val = 0
        for (i, bit) in binary.reversed().enumerated() {
            if bit == "0" {
                continue
            }
            val += (pow(Decimal(2), i) as NSDecimalNumber).intValue
        }
        return val
    }
}
