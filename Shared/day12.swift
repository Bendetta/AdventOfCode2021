//
//  day12.swift
//  aoc2021
//
//  Created by Ben Liset on 12/12/21.
//

import Foundation

class day12: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day12.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day12.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day12.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day12.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var pathsCount = 0
        let neighbours = adjacencyList(input)
        
        func continuePath(currentNode: String, cavesVisited: Set<String>) {
            neighbours[currentNode]?.filter { !cavesVisited.contains($0) || $0.isLargeCave }.forEach {
                if ($0 == "end") {
                    pathsCount += 1
                } else {
                    continuePath(
                        currentNode: $0,
                        cavesVisited: cavesVisited.unionWithOne(element: $0)
                    )
                }
            }
        }
        
        continuePath(currentNode: "start", cavesVisited: Set(["start"]))
        return pathsCount
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var pathsCount = 0
        let neighbours = adjacencyList(input)
        
        func continuePath(currentNode: String, cavesVisited: Set<String>, smallCaveVisitedTwice: String?) {
            neighbours[currentNode]?.forEach {
                if ($0 == "end") {
                    pathsCount += 1
                } else if ($0.isSmallCave && cavesVisited.contains($0)) {
                    if (smallCaveVisitedTwice == nil && !["start", "end"].contains($0)) {
                        continuePath(
                            currentNode: $0,
                            cavesVisited: cavesVisited,
                            smallCaveVisitedTwice: $0
                        )
                    }
                } else {
                    continuePath(
                        currentNode: $0,
                        cavesVisited: cavesVisited.unionWithOne(element: $0),
                        smallCaveVisitedTwice: smallCaveVisitedTwice
                    )
                }
            }
        }
        
        continuePath(currentNode: "start", cavesVisited: Set(["start"]), smallCaveVisitedTwice: nil)
        return pathsCount
    }
    
    private func adjacencyList(_ lines: [String]) -> [String : Set<String>] {
        var result = [String : Set<String>]()
        
        lines.forEach {
            let parts = $0.components(separatedBy: "-")
            let start = parts[0]
            let end = parts[1]
            
            result[start] = (result[start] ?? Set()).unionWithOne(element: end)
            result[end] = (result[end] ?? Set()).unionWithOne(element: start)
        }
        
        return result
    }
}

fileprivate extension String {
    var isSmallCave: Bool {
        first!.isLowercase
    }
    
    var isLargeCave: Bool {
        !isSmallCave
    }
}

fileprivate extension Set {
    func unionWithOne(element: Element) -> Set<Element> {
        union(Set([element]))
    }
}
