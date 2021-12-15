//
//  day15.swift
//  aoc2021
//
//  Created by Ben Liset on 12/14/21.
//

import Foundation

class day15: Puzzle {
    
    var visitedNodes: [String:Bool] = [:]
    
    func runPart1Sample() -> Int {
        return runPart1(Input.day15.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day15.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day15.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day15.actual)
    }
    
    private func runPart1(_ input: [[Int]]) -> Int {
        let riskMap = RiskMap(input: input, withTiling: 1)
        let distance = riskMap.getShortestPath()
        riskMap.printPath()
        return distance
    }
    
    private func runPart2(_ input: [[Int]]) -> Int {
        let riskMap = RiskMap(input: input, withTiling: 5)
        let distance = riskMap.getShortestPath()
        riskMap.printPath()
        return distance
    }
    
    class RiskMap {
        let width, totalWidth: Int
        let height, totalHeight: Int
        let tiling: Int
        
        let array: [Int]
        var minCostAtIndex: [Int?]
        
        init(input: [[Int]], withTiling tiling: Int) {
            self.tiling = tiling
            self.width = input[0].count
            self.height = input.count
            self.array = input.flatMap { $0 }
            
            
            self.totalWidth = width * tiling
            self.totalHeight = height * tiling
            self.minCostAtIndex = [Int?](repeating: nil, count: totalWidth * totalHeight)
            self.minCostAtIndex[0] = 0
        }
        
        private func getIncrementalCost(x: Int, y: Int) -> Int {
            let basicCost = Int(array[width * (y % height) + (x % width)])
            
            if tiling == 1 {
                return basicCost
            }
            
            let tile_x = x / width
            let tile_y = y / width
            
            return 1 + ((basicCost + tile_x + tile_y - 1) % 9)
        }
        
        func getShortestPath() -> Int {
            var queue = Heap<QueueElem>()
            queue.insert(QueueElem(x: 0, cost: 0))
            
            var inQueue = Set<Int>()
            inQueue.insert(0)
            
            while let elem = queue.removeMax() {
                let (index, minCost) = (elem.x, elem.cost)
                inQueue.remove(index)
                
                let y = index / totalWidth
                let x = index % totalWidth
                
                for (dx, dy) in [(-1, 0), (0, -1), (1, 0), (0, 1)] {
                    
                    let xx = x + dx
                    let yy = y + dy
                    
                    if xx < 0 || xx >= totalWidth || yy < 0 || yy >= totalHeight {
                        continue
                    }
                    
                    let newIndex = totalWidth * yy + xx
                    let incrementalCost = getIncrementalCost(x: xx, y: yy)
                    
                    let newCost = minCost + incrementalCost
                    
                    let oldCost = minCostAtIndex[newIndex]
                    
                    if oldCost == nil || oldCost! > newCost {
                        minCostAtIndex[newIndex] = newCost
                        
                        if inQueue.insert(newIndex).inserted {
                            queue.insert(QueueElem(x: newIndex, cost: newCost))
                        }
                    }
                }
            }
            return minCostAtIndex[totalWidth * totalHeight - 1]!
        }
        
        func printPath() {
            var string = ""
            
            let visitedNodes = findVisitedPaths(visited: Set<Int>(), currentIndex: minCostAtIndex.count-1).sorted()
            for row in 0..<totalHeight {
                for col in 0..<totalWidth {
                    let index = totalHeight * row + col
                    if visitedNodes.contains(index) {
                        string += "█"
                    } else {
                        string += String(getIncrementalCost(x: row, y: col))
                    }
                }
                string += "\n"
            }
            print(string)
        }
        
        private func findVisitedPaths(visited:Set<Int>, currentIndex: Int) -> Set<Int> {
            var updatedVisited = visited
            updatedVisited.insert(currentIndex)
            if currentIndex == 0 {
                return updatedVisited
            }
            let y = currentIndex / totalWidth
            let x = currentIndex % totalWidth
            
            var nextValues = [(Int,Int)]()
            if y > 0 {
                let newIndex = totalWidth * (y-1) + x
                if let newValue = minCostAtIndex[newIndex] {
                    nextValues.append((newValue, newIndex))
                }
            }
            if x > 0 {
                let newIndex = totalWidth * y + (x-1)
                if let newValue = minCostAtIndex[newIndex] {
                    nextValues.append((newValue, newIndex))
                }
            }
            if y < totalHeight - 1 {
                let newIndex = totalWidth * (y+1) + x
                if let newValue = minCostAtIndex[newIndex] {
                    nextValues.append((newValue, newIndex))
                }
            }
            if x < totalWidth - 1 {
                let newIndex = totalWidth * y + (x+1)
                if let newValue = minCostAtIndex[newIndex] {
                    nextValues.append((newValue, newIndex))
                }
            }
            if nextValues.count > 0 {
                let smallest = nextValues.sorted(by: { $0.0 < $1.0 }).first!
                return findVisitedPaths(visited: updatedVisited, currentIndex: smallest.1)
            }
            return updatedVisited
        }
    }
    
    struct Heap<T: Comparable> {
        var elems: [T]
        
        init() {
            self.elems = [T]()
        }
        
        func parentIndex(of index: Int) -> Int? {
            
            assert(index < self.elems.count)
            
            if index == 0 {
                return nil
            }
            
            return (index - 1) / 2
        }
        
        mutating func insert(_ x: T) {
            var i = self.elems.count
            self.elems.append(x)
            
            while let parent = parentIndex(of: i) {
                if self.elems[i] <= self.elems[parent] {
                    return
                }
                
                // heap[i] > heap[parent], heap-condition violated.
                self.elems.swapAt(parent, i)
                
                // Fixed heap-condition at parent, now heap-condition at parent's
                // parent may be violated.
                
                i = parent
            }
        }
        
        mutating func removeMax() -> T? {
            
            if self.elems.isEmpty {
                return nil
            }
            
            if self.elems.count == 1 {
                return self.elems.removeFirst()
            }
            
            let result = self.elems.first
            self.elems[0] = self.elems.removeLast()
            
            let n = self.elems.count
            
            var parent = 0
            while parent < n {
                
                var x = self.elems[parent]
                
                var maxChildIndex: Int?
                if (2 * parent + 1) < n && self.elems[2 * parent + 1] > x {
                    x = self.elems[2 * parent + 1]
                    maxChildIndex = 2 * parent + 1
                }
                
                if (2 * parent + 2) < n && self.elems[2 * parent + 2] > x {
                    x = self.elems[2 * parent + 2]
                    maxChildIndex = 2 * parent + 2
                }
                
                guard let maxChildIndex = maxChildIndex else {
                    break
                }
                
                self.elems.swapAt(parent, maxChildIndex)
                parent = maxChildIndex
            }
            
            return result
        }
        
        var isEmpty: Bool {
            self.elems.isEmpty
        }
        
        var count: Int {
            self.elems.count
        }
    }
    
    struct QueueElem: Comparable {
        let x: Int
        let cost: Int
        
        // Reverse order as my heap is a max-heap and we want to "removeMin" here.
        static func <(lhs: QueueElem, rhs: QueueElem) -> Bool {
            lhs.cost > rhs.cost
        }
    }
}
