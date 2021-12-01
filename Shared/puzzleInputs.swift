//
//  puzzleInputs.swift
//  aoc2021
//
//  Created by Ben Liset on 12/1/21.
//

import Foundation

enum Input {
    struct day1 {
        static let part1sample = """
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
            """.split(whereSeparator: \.isNewline)
            .compactMap{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { Int($0) }
        
        static let part1actual = Input.readFile("day1part1").split(whereSeparator: \.isNewline)
            .compactMap{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { Int($0) }
        
        static func format(_ string: String) -> [Int] {
            return string.split(whereSeparator: \.isNewline)
                .compactMap{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .compactMap { Int($0) }
        }
    }
    
    static func readFile(_ name: String) -> String {
        let bundle = Bundle(for: InputMarker.self)
        let path = bundle.path(forResource: name, ofType: "txt") // file path for file "data.txt"
        let string = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return string
    }
}

class InputMarker { }
