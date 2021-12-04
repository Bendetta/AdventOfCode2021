//
//  day4.swift
//  aoc2021
//
//  Created by Ben Liset on 12/3/21.
//

import Foundation

struct day4 {
    
    func runPart1Sample() -> Int {
        return runPart1(Input.day4.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day4.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day4.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day4.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let bingoNumbers = input[0].split(whereSeparator: { $0 == "," }).map { Int($0)! }
        var boards = [BingoBoard]()
        for i in 1..<input.count where i % 5 == 1 {
            let card = input[i..<i+5]
            boards.append(BingoBoard(card))
        }
        
        for number in bingoNumbers {
            for board in boards {
                if board.markNumber(number) {
                    return number * board.getUnmarkedSum()
                }
            }
        }
        return 0
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var bingoNumbers = input[0].split(whereSeparator: { $0 == "," }).map { Int($0)! }
        var boards = [BingoBoard]()
        for i in 1..<input.count where i % 5 == 1 {
            let card = input[i..<i+5]
            boards.append(BingoBoard(card))
        }
        
        var number = bingoNumbers[0]
        var losingBoard = boards[0]
        repeat {
            number = bingoNumbers.removeFirst()
            var winningBoards = 0
            for (index, board) in boards.enumerated() {
                if board.markNumber(number) {
                    losingBoard = board
                    // Fixes out of index errors that occur when multiple boards win
                    // on the same number
                    boards.remove(at: index - winningBoards)
                    winningBoards += 1
                }
            }
        } while (boards.count > 0 && bingoNumbers.count > 0)
        return losingBoard.getUnmarkedSum() * number
    }
    
    class BingoBoard {
        
        struct Cell {
            let value: Int
            let row: Int
            let column: Int
            var marked: Bool
        }
        
        var cells: [Cell]
        var markedColumns: [Int:Int] = [
            0: 0,
            1: 0,
            2: 0,
            3: 0,
            4: 0]
        var markedRows: [Int:Int] = [
            0: 0,
            1: 0,
            2: 0,
            3: 0,
            4: 0]
        var markedNumbers: [Int:Bool] = [:]
        init(_ card: ArraySlice<String>) {
            var cells = [Cell]()
            for (rowIndex, row) in card.enumerated() {
                let vals = row.split(whereSeparator: \.isWhitespace)
                for colIndex in 0..<vals.count {
                    cells.append(Cell(value: Int(vals[colIndex])!, row: rowIndex, column: colIndex, marked: false))
                }
            }
            self.cells = cells
        }
        
        func markNumber(_ number: Int) -> Bool {
            for (index, cell) in cells.enumerated() {
                if cell.marked {
                    continue
                }
                if cell.value == number {
                    self.cells[index].marked = true
                    self.markedRows[cell.row]! += 1
                    self.markedColumns[cell.column]! += 1
                    return self.markedRows[cell.row] == 5 || self.markedColumns[cell.column] == 5
                }
            }
            return false
        }
        
        func getUnmarkedSum() -> Int {
            return self.cells.filter { !$0.marked }.reduce(0, { $0 + $1.value })
        }
    }
}
