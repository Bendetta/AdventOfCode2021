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
    
    struct day5 {
        static let sample = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
""".splitLines()
        
        static let actual = Input.readFile("day5").splitLines()
    }
    
    struct day6 {
        static let sample = parseInput("3,4,3,1,2")
        
        static let actual = parseInput(Input.readFile("day6"))
        
        private static func parseInput(_ input: String) -> [Int] {
            return input.split(separator: ",").map { Int($0.trimmingCharacters(in: .whitespacesAndNewlines))! }
        }
    }
    
    struct day7 {
        static let sample = parseInput("16,1,2,0,4,2,7,1,2,14")
        
        static let actual = parseInput(Input.readFile("day7"))
        
        private static func parseInput(_ input: String) -> [Int] {
            return input.split(separator: ",").map { Int($0.trimmingCharacters(in: .whitespacesAndNewlines))! }
        }
    }
    
    struct day8 {
        static let sample = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
""".splitLines()
        
        static let actual = Input.readFile("day8").splitLines()
    }
    
    struct day9 {
        static let sample = """
2199943210
3987894921
9856789892
8767896789
9899965678
""".splitLines()
        
        static let actual = Input.readFile("day9").splitLines()
    }
    
    struct day10 {
        static let sample = """
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
""".splitLines()
        
        static let actual = Input.readFile("day10").splitLines()
    }
    
    struct day11 {
        static let sample = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
""".splitLines().map { convertLine($0) }
        
        static let actual = Input.readFile("day11").splitLines()
            .map { convertLine($0) }
        
        private static func convertLine(_ line: String) -> [Int] {
            return line.compactMap { Int(String($0))}
        }
    }
    
    struct day12 {
        static let sample = """
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
""".splitLines()
        
        static let actual = Input.readFile("day12").splitLines()
    }
    
    struct day13 {
        static let sample = """
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
""".splitLines()
        
        static let actual = Input.readFile("day13").splitLines()
    }
    
    struct day14 {
        static let sample = """
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
""".components(separatedBy: "\n\n")
        static let actual = Input.readFile("day14").components(separatedBy: "\n\n")
    }
    
    struct day15 {
        static let sample = """
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
""".splitLines().map{ $0.toIntArray() }
        static let actual = Input.readFile("day15").splitLines().map{ $0.toIntArray() }
    }
    
    struct day16 {
        static let sample = "A0016C880162017C3686B18A3D4780"
        
        static let actual = Input.readFile("day16").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    struct day17 {
        static let sample = "target area: x=20..30, y=-10..-5"
        
        static let actual = Input.readFile("day17").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    struct day21 {
        static let sample = """
Player 1 starting position: 4
Player 2 starting position: 8
""".splitLines()
        
        static let actual = Input.readFile("day21").splitLines()
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
    
    func toIntArray() -> [Int] {
        return self.compactMap { char in Int(String(char)) }
    }
}
