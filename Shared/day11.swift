//
//  day11.swift
//  aoc2021
//
//  Created by Ben Liset on 12/12/21.
//

import Foundation

class day11: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day11.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day11.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day11.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day11.actual)
    }
    
    func runPart1(_ input: [[Int]]) -> Int {
        let grid = Grid(layout: input)
        
        var flashCount = 0
        for _ in 0..<100 {
            flashCount += grid.update()
        }
        return flashCount
    }
    
    func runPart2(_ input: [[Int]]) -> Int {
        let grid = Grid(layout: input)
        
        var flashes = 0
        var step = 0
        while flashes != input[0].count * input.count {
            flashes = grid.update()
            step += 1
        }
        return step
    }
    
    class Grid {
        var layout: [[Int]]
        
        init(layout: [[Int]]) {
            self.layout = layout
        }
        
        func update() -> Int {
            var flashes = [String:Bool]()
            var toFlash = [(Int,Int)]()
            for row in 0..<layout.count {
                for col in 0..<layout[row].count {
                    let id = "\(row),\(col)"
                    layout[row][col] += 1
                    if layout[row][col] > 9 && !(flashes[id] ?? false) {
                        flashes[id] = true
                        toFlash.append((row,col))
                    }
                }
            }
            while toFlash.count > 0 {
                let currentFlash = toFlash.removeFirst()
                let neighbors = getNeighbords(row: currentFlash.0, col: currentFlash.1)
                for n in neighbors {
                    let id = "\(n.0),\(n.1)"
                    if layout[n.0][n.1] < 10 && !(flashes[id] ?? false) {
                        layout[n.0][n.1] += 1
                        if layout[n.0][n.1] > 9 {
                            flashes[id] = true
                            toFlash.append((n.0,n.1))
                        }
                    }
                }
            }
            
            for row in 0..<layout.count {
                for col in 0..<layout[row].count {
                    if layout[row][col] > 9 {
                        layout[row][col] = 0
                    }
                }
            }
            
            //print("flashes: \(flashes.count)")
            return flashes.count
        }
        
        func getNeighbords(row: Int, col: Int) -> [(Int,Int)] {
            var spots = [(Int,Int)]()
            if row > 0 {
                spots.append((row-1, col))
                if col > 0 {
                    spots.append((row-1, col-1))
                }
                if col < layout[row].count - 1 {
                    spots.append((row-1, col+1))
                }
            }
            if row < layout.count - 1 {
                spots.append((row+1, col))
                if col > 0 {
                    spots.append((row+1, col-1))
                }
                if col < layout[row].count - 1 {
                    spots.append((row+1, col+1))
                }
            }
            if col > 0 {
                spots.append((row, col-1))
            }
            if col < layout[row].count - 1 {
                spots.append((row, col+1))
            }
            return spots
        }
        
        func toString() -> String {
            var output = ""
            for row in 0..<layout.count {
                for col in 0..<layout[row].count {
                    output += String(layout[row][col])
                }
                output += "\n"
            }
            return output
        }
    }
}
