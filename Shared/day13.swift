//
//  day13.swift
//  aoc2021
//
//  Created by Ben Liset on 12/13/21.
//

import Foundation

class day13: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day13.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day13.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day13.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day13.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var (coords, folds) = parseInput(input)
        
        for instruction in folds.prefix(upTo: 1) {
            coords = fold(coords: coords, using: instruction)
        }
        return coords.count
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var (coords, folds) = parseInput(input)
        
        for instruction in folds {
            coords = fold(coords: coords, using: instruction)
        }
        printGridCoords(coords: coords)
        return coords.count
    }
    
    private func parseInput(_ input: [String]) -> ([Coord],[FoldInstruction]) {
        var coords = [Coord]()
        var folds = [FoldInstruction]()
        var maxX = 0, maxY = 0
        for line in input {
            guard !line.isEmpty else { continue }
            if let coord = parseCoordinate(line) {
                coords.append(coord)
                if coord.x > maxX {
                    maxX = coord.x
                }
                if coord.y > maxY {
                    maxY = coord.y
                }
            }
            else if let instruction = parseFoldingInstruction(line) {
                folds.append(instruction)
            }
        }
        return (coords,folds)
    }
    
    private func fold(coords: [Coord], using instruction: FoldInstruction) -> [Coord] {
        var updatedCoords = [Coord:Bool]()
        for coord in coords {
            switch instruction {
            case .horizontal(let maxY):
                if coord.y > maxY {
                    updatedCoords[(Coord(x: coord.x, y: maxY*2 - coord.y))] = true
                } else {
                    updatedCoords[coord] = true
                }
        
            case .vertical(let maxX):
                if coord.x > maxX {
                    updatedCoords[(Coord(x: maxX*2 - coord.x, y: coord.y))] = true
                } else {
                    updatedCoords[coord] = true
                }
            
            }
        }
        return updatedCoords.keys.map { $0 }
    }
    
    private func parseCoordinate(_ line: String) -> Coord? {
        let regex = try! NSRegularExpression(pattern: #"(\d+),(\d+)"#)
        guard let match = regex.firstMatch(in: line, options: [], range: NSRange(location: 0, length: line.utf8.count)),
              let xRange = Range(match.range(at: 1), in: line),
              let yRange = Range(match.range(at: 2), in: line),
              let x = Int(line[xRange]),
              let y = Int(line[yRange]) else {
                  return nil
              }
        return Coord(x: x, y: y)
    }
    
    private func parseFoldingInstruction(_ line: String) -> FoldInstruction? {
        let regex = try! NSRegularExpression(pattern: #"(y|x)=(\d+)"#)
        guard let match = regex.firstMatch(in: line, options: [], range: NSRange(location: 0, length: line.utf8.count)),
              let directionRange = Range(match.range(at: 1), in: line),
              let valueRange = Range(match.range(at: 2), in: line),
              let value = Int(line[valueRange]) else {
                  return nil
              }
        
        switch line[directionRange] {
        case "x": return .vertical(value)
        case "y": return .horizontal(value)
        default: return nil
        }
    }
    
    private func printGridCoords(coords: [Coord]) {
        let maxX = coords.max(by: { $0.x < $1.x })!.x
        let maxY = coords.max(by: { $0.y < $1.y })!.y
        var grid = Array(repeating: Array(repeating: false, count: maxX + 1), count: maxY + 1)
        for coord in coords {
            grid[coord.y][coord.x] = true
        }
        
        var string = ""
        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                if grid[row][col] {
                    string += "#"
                } else {
                    string += "."
                }
            }
            string += "\n"
        }
        print(string)
    }
    
    struct Coord: Hashable {
        let x: Int, y: Int
    }
    
    enum FoldInstruction {
        case vertical(Int)
        case horizontal(Int)
    }
}
