//
//  day21.swift
//  aoc2021
//
//  Created by Ben Liset on 12/21/21.
//

import Foundation

class day21: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day21.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day21.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day21.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day21.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let startingPositions = input.map { getStartingPosition($0) }
        
        let player1 = Player(position: startingPositions[0])
        let player2 = Player(position: startingPositions[1])
        var dieValue = 0
        var playerTurn = 1
        while player1.score < 1000 && player2.score < 1000 {
            var rolls = [Int]()
            for i in 1...3 {
                var roll = dieValue + i
                if roll > 100 { roll %= 100 }
                rolls.append(roll)
            }
            if playerTurn == 1 {
                player1.move(rolls: rolls)
                playerTurn = 2
            } else {
                player2.move(rolls: rolls)
                playerTurn = 1
            }
            dieValue += 3
        }
        print(player1.score)
        print(player2.score)
        print(dieValue)
        return min(player1.score,player2.score) * dieValue
    }
    
    private func runPart2(_ input: [String]) -> Int {
        return 0
    }
    
    private func getStartingPosition(_ str: String) -> Int {
        let number = str.components(separatedBy: ": ")[1]
        return Int(number)!
    }
    
    class Player {
        var position: Int
        var score = 0
        
        init(position: Int) {
            self.position = position
        }
        
        func move(rolls: [Int]) {
            let sum = rolls.reduce(0) { $0 + $1 }
            position = (position + sum) % 10
            if position == 0 { position = 10 }
            print("Moving player to \(position)")
            score += position
        }
    }
}
