//
//  day22.swift
//  aoc2021
//
//  Created by Ben Liset on 12/22/21.
//

import Foundation

class day22: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day22.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day22.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day22.samplePart2)
    }
    
    func runPart2Actual() -> Int {
        return runPart1(Input.day22.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let cubes = input.map { parseInstruction($0) }
        var onCubes = Set<Cube>()
        
        for cube in cubes {
            let minX = max(cube.minPoint.0,-50), maxX = min(cube.maxPoint.0,50)
            let minY = max(cube.minPoint.1,-50), maxY = min(cube.maxPoint.1,50)
            let minZ = max(cube.minPoint.2,-50), maxZ = min(cube.maxPoint.2,50)
            guard minX < maxX, minY<maxY, minZ<maxZ else { continue }
            for x in minX...maxX {
                for y in minY...maxY{
                    for z in minZ...maxZ {
                        let newCube = Cube(minPoint: (x,y,z), maxPoint: (x,y,z), isOn: cube.isOn)
                        if cube.isOn {
                            onCubes.insert(newCube)
                        } else {
                            onCubes.remove(newCube)
                        }
                    }
                }
            }
        }
        return onCubes.count
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let cubes = input.map { parseInstruction($0) }
        var resultingCubes = [Cube]()
        
        for cube in cubes {
            var cubesToAdd = [Cube]()
            if cube.isOn {
                cubesToAdd.append(cube)
            }
            for otherCube in resultingCubes {
                if let intersection = cube.intersection(other: otherCube, isOn: !otherCube.isOn) {
                    cubesToAdd.append(intersection)
                }
            }
            resultingCubes.append(contentsOf: cubesToAdd)
        }
        
        let sum = resultingCubes.reduce(0) { $0 + $1.Volume * ($1.isOn ? 1 : -1) }
        return sum
    }
    
    typealias Point = (Int,Int,Int)
    
    struct Cube: Hashable {
        let minPoint: Point
        let maxPoint: Point
        let isOn: Bool
        
        func intersection(other: Cube, isOn: Bool) -> Cube? {
            if minPoint.0 > other.maxPoint.0 || maxPoint.0 < other.minPoint.0 ||
                minPoint.1 > other.maxPoint.1 || maxPoint.1 < other.minPoint.1 ||
                minPoint.2 > other.maxPoint.2 || maxPoint.2 < other.minPoint.2 {
                return nil
            }
            let xMin = max(minPoint.0, other.minPoint.0)
            let yMin = max(minPoint.1, other.minPoint.1)
            let zMin = max(minPoint.2, other.minPoint.2)
            
            let xMax = min(maxPoint.0, other.maxPoint.0)
            let yMax = min(maxPoint.1, other.maxPoint.1)
            let zMax = min(maxPoint.2, other.maxPoint.2)
            return Cube(minPoint: (xMin,yMin,zMin), maxPoint: (xMax,yMax,zMax), isOn: isOn)
        }
        
        var Volume: Int {
            (maxPoint.0 - minPoint.0 + 1) * (maxPoint.1 - minPoint.1 + 1) * (maxPoint.2 - minPoint.2 + 1)
        }
        
        static func == (lhs: day22.Cube, rhs: day22.Cube) -> Bool {
            return lhs.minPoint == rhs.minPoint && lhs.maxPoint == rhs.maxPoint
        }
        
        var hashValue: Int {
            return "\(minPoint.0),\(minPoint.1),\(minPoint.2)->\(maxPoint.0),\(maxPoint.1),\(maxPoint.2)".hashValue
        }
    }
    
    enum Instruction {
        case on(Point,Point)
        case off(Point,Point)
    }
    
    private func parseInstruction(_ text: String) -> Cube {
        let parts = text.components(separatedBy: " ")
        let ranges = parts[1].components(separatedBy: ",")
        let xRange = parseRange(ranges[0])
        let yRange = parseRange(ranges[1])
        let zRange = parseRange(ranges[2])
        let minPoint = (xRange.0, yRange.0, zRange.0)
        let maxPoint = (xRange.1, yRange.1, zRange.1)
        let isOn = parts[0] == "on"
        return Cube(minPoint: minPoint, maxPoint: maxPoint, isOn: isOn)
    }
    
    private func parseRange(_ text: String) -> (Int,Int) {
        let numberRange = text.components(separatedBy: "=")[1]
        let numbers = numberRange.components(separatedBy: "..")
        let min = Int(numbers[0])!
        let max = Int(numbers[1])!
        return (min,max)
    }
}
