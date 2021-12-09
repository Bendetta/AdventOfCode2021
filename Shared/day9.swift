//
//  day9.swift
//  aoc2021
//
//  Created by Ben Liset on 12/9/21.
//

import Foundation

class day9: Puzzle {
    var heightMap = [[Int]]()
    var basinSpots = [(Int,Int)]()
    
    func runPart1Sample() -> Int {
        return runPart1(Input.day9.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day9.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day9.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day9.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        heightMap = input.map { line in
            return line.map{ Int(String($0))! }
        }
        let lowPointCoords = findLowPoints(row: 0, column: 0, foundLowPoints: [])
        
        let lowPointHeights = lowPointCoords.map { heightMap[$0.0][$0.1] }
        let sum = lowPointHeights.reduce(0, { $0 + $1 + 1 })
        return sum
    }
    
    private func runPart2(_ input: [String]) -> Int {
        heightMap = input.map { line in
            return line.map{ Int(String($0))! }
        }
        let lowPointCoords = findLowPoints(row: 0, column: 0, foundLowPoints: [])
        let basinSizes = lowPointCoords.map {
            findBasinSize(coord: $0)
        }
        let biggestBasins = basinSizes.sorted(by: {$0 > $1}).prefix(upTo: 3)
        return biggestBasins.reduce(1, { $0 * $1 })
    }
    
    private func findLowPoints(row: Int, column: Int, foundLowPoints: [(Int,Int)]) -> [(Int,Int)] {
        let colLength = heightMap[0].count
        if row >= heightMap.count && column >= colLength {
            return foundLowPoints
        }
        
        let currentHeight = heightMap[row][column]
        var adjacentHeights = [Int]()
        if row > 0 {
            adjacentHeights.append(heightMap[row-1][column])
        }
        if row < heightMap.count - 1 {
            adjacentHeights.append(heightMap[row+1][column])
        }
        if column > 0 {
            adjacentHeights.append(heightMap[row][column-1])
        }
        if column < colLength - 1 {
            adjacentHeights.append(heightMap[row][column+1])
        }
        
        var newLowPoints = foundLowPoints
        if adjacentHeights.allSatisfy({ $0 > currentHeight }) {
            newLowPoints.append((row,column))
        }
        
        if column < colLength - 1 {
            return findLowPoints(row: row, column: column+1, foundLowPoints: newLowPoints)
        }
        if row < heightMap.count - 1 {
            return findLowPoints(row: row+1, column: 0, foundLowPoints: newLowPoints)
        }
        return newLowPoints
    }
    
    private func findBasinSize(coord:(Int,Int)) -> Int {
        let row = coord.0, col = coord.1
        let height = heightMap[row][col]
        basinSpots.append((row,col))
        return 1 +
        findBasinSize(row: row + 1, col: col, previousValue: height) +
        findBasinSize(row: row, col: col + 1, previousValue: height) +
        findBasinSize(row: row - 1, col: col, previousValue: height) +
        findBasinSize(row: row, col: col - 1, previousValue: height)
    }
    
    private func findBasinSize(row: Int, col: Int, previousValue: Int) -> Int {
        if row < 0 || row >= heightMap.count || col < 0 || col >= heightMap[0].count {
            return 0
        }
        
        let height = heightMap[row][col]
        if height >= 9 || height < previousValue {
            return 0
        }
        
        if basinSpots.contains(where: { $0.0 == row && $0.1 == col}) {
            return 0
        }
        
        basinSpots.append((row,col))
        return 1 +
        findBasinSize(row: row + 1, col: col, previousValue: height) +
        findBasinSize(row: row, col: col + 1, previousValue: height) +
        findBasinSize(row: row - 1, col: col, previousValue: height) +
        findBasinSize(row: row, col: col - 1, previousValue: height)
    }
}
