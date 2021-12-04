//
//  puzzleInputs.swift
//  aoc2021
//
//  Created by Ben Liset on 12/1/21.
//

import Foundation

enum Input {
    struct day1 {
        static let sample = """
            199
            200
            208
            210
            200
            207
            240
            269
            260
            263
            """.splitLines()
            .compactMap { Int($0) }
        
        static let actual = Input.readFile("day1")
            .splitLines()
            .compactMap { Int($0) }
        
        static func format(_ string: String) -> [Int] {
            return string.splitLines()
                .compactMap { Int($0) }
        }
    }
    
    struct day2 {
        static let sample = """
            forward 5
            down 5
            forward 8
            up 3
            down 8
            forward 2
            """.splitLines()
        
        static let actual = Input.readFile("day2").splitLines()
    }
    
    struct day3 {
        static let sample = """
            00100
            11110
            10110
            10111
            10101
            01111
            00111
            11100
            10000
            11001
            00010
            01010
            """.splitLines()
        
        static let actual = Input.readFile("day3").splitLines()
    }
    
    struct day4 {
        static let sample = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
""".splitLines()
        
        static let actual = Input.readFile("day4").splitLines()
        
    }
    
    static func readFile(_ name: String) -> String {
        let bundle = Bundle(for: InputMarker.self)
        let path = bundle.path(forResource: name, ofType: "txt") // file path for file "data.txt"
        let string = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return string
    }
    
}

class InputMarker { }

fileprivate extension String {
    func splitLines() -> [String] {
        return self.split(whereSeparator: \.isNewline)
            .compactMap{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}