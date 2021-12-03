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
