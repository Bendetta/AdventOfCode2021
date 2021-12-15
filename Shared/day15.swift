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
        let startTime = CFAbsoluteTimeGetCurrent()
        print("start")
        let edges = generateEdges(using: input)
        let edgeTime = CFAbsoluteTimeGetCurrent()
        print("generated \(edges.count): \(edgeTime - startTime)")
        let graph = setupGraphwith(edges: edges)
        let graphTime = CFAbsoluteTimeGetCurrent()
        print("generated graph: \(graphTime - edgeTime)")
        let endIdentifier = generateIdentifier(row: input.count-1, col: input[input.count-1].count-1, in: input)
        let path = shortestPath(source: 0, destination: endIdentifier, graph: graph)
        let pathTime = CFAbsoluteTimeGetCurrent()
        print("found path: \(pathTime - graphTime)")
        print("total: \(pathTime-startTime)")
        printPath(graph: graph, input: input, path: path)
        return path
    }
    
    private func runPart2(_ input: [[Int]]) -> Int {
        return 0
    }
    
    private func printPath(graph: Graph, input: [[Int]], path: Int) {
        var string = ""
        var distance = Array(repeating: Array(repeating: 0, count: input[0].count), count: input.count)
        let possibleNodes = graph.nodes
        for node in possibleNodes {
            let rowIndex = node.identifier/input.count
            let colIndex = node.identifier%input.count
            distance[rowIndex][colIndex] = node.distance
        }
        
        let visitedNodes = findVisitedPaths(distanceArray: distance, visited: Set<String>(), row: input.count-1, col: input[0].count-1)
        for row in 0..<input.count {
            for col in 0..<input[row].count {
                if visitedNodes.contains("\(row),\(col)") {
                    string += "█"
                } else {
                    string += String(input[row][col])
                }
            }
            string += "\n"
        }
        print(string)
    }
    
    func findVisitedPaths(distanceArray: [[Int]], visited:Set<String>, row: Int, col: Int) -> Set<String> {
        var updatedVisited = visited
        updatedVisited.insert("\(row),\(col)")
        if row == 0 && col == 0 {
            return updatedVisited
        }
        var nextValues = [(Int,Int,Int)]()
        if row > 0 {
            nextValues.append((distanceArray[row-1][col], row-1, col))
        }
        if col > 0 {
            nextValues.append((distanceArray[row][col-1], row, col-1))
        }
        if row < distanceArray.count - 1 {
            nextValues.append((distanceArray[row+1][col], row+1, col))
        }
        if col < distanceArray[row].count - 1 {
            nextValues.append((distanceArray[row][col+1], row, col+1))
        }
        if nextValues.count > 0 {
            let smallest = nextValues.sorted(by: { $0.0 < $1.0 }).first!
            return findVisitedPaths(distanceArray: distanceArray, visited: updatedVisited, row: smallest.1, col: smallest.2)
        }
        return updatedVisited
    }
    
    func generateEdges(using input: [[Int]]) -> [[Int]] {
        var edges = [[Int]]()
        for row in 0..<input.count {
            for col in 0..<input[row].count {
                let currentNodeId = generateIdentifier(row: row, col: col, in: input)
                if row > 0 {
                    let nextNodeId = generateIdentifier(row: row-1, col: col, in: input)
                    let nextNodeWeight = input[row-1][col]
                    edges.append([currentNodeId,nextNodeId,nextNodeWeight])
                }
                if row < input.count - 1 {
                    let nextNodeId = generateIdentifier(row: row+1, col: col, in: input)
                    let nextNodeWeight = input[row+1][col]
                    edges.append([currentNodeId,nextNodeId,nextNodeWeight])
                }
                if col > 0 {
                    let nextNodeId = generateIdentifier(row: row, col: col-1, in: input)
                    let nextNodeWeight = input[row][col-1]
                    edges.append([currentNodeId,nextNodeId,nextNodeWeight])
                }
                if col < input[row].count - 1 {
                    let nextNodeId = generateIdentifier(row: row, col: col+1, in: input)
                    let nextNodeWeight = input[row][col+1]
                    edges.append([currentNodeId,nextNodeId,nextNodeWeight])
                }
            }
        }
        return edges
    }
    
    func generateIdentifier(row: Int, col: Int, in graph: [[Int]]) -> Int {
        return graph[row].count * row + col
    }
    
    // MARK: Graph Classes
    
    class Node : CustomStringConvertible {
        // unique identifier required for each node
        var identifier: Int
        var distance: Int = Int.max
        var edges = [Edge]()
        var visited = false
        
        var description: String {
            var edgesString = String()
            edges.forEach{  edgesString.append($0.description)}
            return "{ Node, identifier: \(identifier.description) +  Edges: \(edgesString) + }"
        }
        
        init(visited: Bool, identifier: Int, edges: [Edge]) {
            self.visited = visited
            self.identifier = identifier
            self.edges = edges
        }
        
        static func == (lhs: Node, rhs: Node) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
    
    class Edge {
        var from: Node // does not actually need to be stored!
        var to: Node
        var weight: Int
        var description : String {
            return "{ Edge, from: \(from.identifier), to: \(to.identifier), weight: \(weight) }"
            
        }
        init(to: Node, from: Node, weight: Int) {
            self.to = to
            self.weight = weight
            self.from = from
        }
    }
    
    class Graph {
        var nodes: [Node] = []
        
        func displayPath(colSize: Int) {
            var string = ""
            for (index,node) in nodes.enumerated() {
                if index % colSize == 0 {
                    string += "\n"
                }
                string += "\(node.distance)"
            }
            string += "\n"
            print(string)
        }
        
        func selectedNodes() {
            nodes.filter({ $0.visited }).forEach({
                print($0)
            })
        }
    }
    
    // Complete the quickestWayUp function below.
    func setupGraphwith(edges: [[Int]]) -> Graph {
        let graph = Graph()
        
        // create all the nodes
        // The first and last node need to be included, so need nodes from "to" and "from"
        let nodeNames = Set ( edges.map{ $0[0] } + edges.map{ $0[1]} )
        for node in nodeNames {
            let newNode = Node(visited: false, identifier: node, edges: [])
            graph.nodes.append(newNode)
        }
        
        // create all the edges to link the nodes
        for edge in edges {
            if let fromNode = graph.nodes.first(where: { $0.identifier == edge[0] }) {
                if let toNode = graph.nodes.first(where: { $0.identifier == edge[1] }) {
                    let forwardEdge = Edge(to: toNode, from: fromNode, weight: edge[2])
                    fromNode.edges.append(forwardEdge)
                }
            }
        }
        return graph
    }
    
    func shortestPath (source: Int, destination: Int, graph: Graph) -> Int {
        
        var currentNode = graph.nodes.first{ $0.identifier == source }!
        currentNode.visited = true
        currentNode.distance = 0
        var toVisit = [Node]()
        toVisit.append(currentNode)
        while (!toVisit.isEmpty) {
            toVisit = toVisit.filter{ $0.identifier != currentNode.identifier }
            currentNode.visited = true
            // Go to each adjacent vertex and update the path length
            for connectedEdge in currentNode.edges {
                let dist = currentNode.distance + connectedEdge.weight
                
                if (dist < connectedEdge.to.distance) {
                    connectedEdge.to.distance = dist
                    toVisit.append(connectedEdge.to)
                    if (connectedEdge.to.visited == true) {
                        
                        connectedEdge.to.visited = false
                    }
                }
            }
            
            currentNode.visited = true
            //set current node to the smallest vertex
            if !toVisit.isEmpty {
                currentNode = toVisit.min(by: { (a, b) -> Bool in
                    return a.distance < b.distance
                })!
            }
            
            if (currentNode.identifier == destination) {
                return currentNode.distance
            }
        }
        
        return -1
    }
}
