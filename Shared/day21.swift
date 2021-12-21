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
        let startingPositions = input.map { getStartingPosition($0) }
        var game = QuantumGame(player1: startingPositions[0], player2: startingPositions[1])

        while !game.isGameOver {
            game.takeATurn()
        }
        return game.winners
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
    
    struct DiracDie {
        /// index is sum of three rolls of 3-sided die,
        /// value is the number of combinations that generate that sum
        static let threeRollCombinations: [Int] = {
            var probs: [Int] = Array<Int>(repeating: 0, count: 10)

            for a in 1...3 {
                for b in 1...3 {
                    for c in 1...3 {
                        probs[a+b+c] += 1
                    }
                }
            }

            return probs
        }()
    }

    struct PositionScore: Hashable {
        var position: Int
        var score: Int
    }

    struct QuantumGame {
        var turnNumber = 1

        /// Count the number of potential universes where each player is at
        /// different possible (position, score) states on this turn,
        /// tracking only the states that have not yet won
        var player1Positions: [PositionScore: Int]
        var player2Positions: [PositionScore: Int]

        /// Accumulate the number of potential universes where each
        /// player has won on/before this turn
        var player1Wins: Int = 0
        var player2Wins: Int = 0

        /// The number of *remaining* universes where each player
        /// has not yet reached a winning score
        /// Note: playerNRemainingUniverses == sum of values of playerNPositions
        var player1RemainingUniverses: Int = 1
        var player2RemainingUniverses: Int = 1

        init(player1: Int, player2: Int) {
            self.player1Positions = [PositionScore(position: player1, score: 0): 1]
            self.player2Positions = [PositionScore(position: player2, score: 0): 1]
        }

        mutating func takeATurn() {
            let positions = (turnNumber % 2 == 1) ? player1Positions : player2Positions

            /// Number of possibilities for each non-winning (position, score) state following this turn
            var newPositionScoreCounts = [PositionScore: Int]()

            /// Number of possibilities in which the player hasn't won on this turn
            var possibleNonWins: Int = 0

            /// Number of possibilities in which the player won on this turn
            var possibleWins: Int = 0

            for (startingPositionScore, startingCount) in positions {
                for rollValue in 3...9 {
                    let rollCombinations = DiracDie.threeRollCombinations[rollValue]
                    let newPosition = ((startingPositionScore.position + rollValue - 1) % 10) + 1
                    let newScore = startingPositionScore.score + newPosition

                    let possibilities = startingCount * rollCombinations

                    if newScore >= 21 {
                        possibleWins += possibilities
                    } else {
                        let newPositionScore = PositionScore(position: newPosition, score: newScore)
                        newPositionScoreCounts[newPositionScore, default: 0] += possibilities
                        possibleNonWins += possibilities
                    }
                }
            }

            if turnNumber % 2 == 1 {
                player1Positions = newPositionScoreCounts
                player1RemainingUniverses = possibleNonWins
                /// Note that we've been keeping tracking of the possibilities for the two players
                /// independently of each other:
                /// Total number of possible universes in which the player won on this turn is
                /// actually (number of win possibilities on this turn for this player) times
                /// (number of possibilities for the opponent where they have not yet won)
                player1Wins += possibleWins * player2RemainingUniverses
            } else {
                player2Positions = newPositionScoreCounts
                player2RemainingUniverses = possibleNonWins
                player2Wins += possibleWins * player1RemainingUniverses
            }

            turnNumber += 1
        }

        var isGameOver: Bool {
            return player1RemainingUniverses <= 0 || player2RemainingUniverses <= 0
        }
        
        var winners: Int {
            max(player1Wins, player2Wins)
        }
    }
}
