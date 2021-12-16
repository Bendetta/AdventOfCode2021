//
//  day16.swift
//  aoc2021
//
//  Created by Ben Liset on 12/16/21.
//

import Foundation

class day16: Puzzle {
    
    func runPart1Sample() -> Int {
        return runPart1(Input.day16.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day16.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day16.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day16.actual)
    }
    
    private func runPart1(_ input: String) -> Int {
        let bits = Bits(decodeToBits(input))
        let packet = Packet.create(from: bits)
        return packet.versionSum()
    }
    
    private func runPart2(_ input: String) -> Int {
        let bits = Bits(decodeToBits(input))
        let packet = Packet.create(from: bits)
        return packet.eval()
    }
    
    private func decodeToBits(_ str: String) -> [UInt8] {
        var bits = [UInt8]()
        for d in str.map({ $0 }) {
            switch d {
            case "0": bits.append(contentsOf: [0,0,0,0])
            case "1": bits.append(contentsOf: [0,0,0,1])
            case "2": bits.append(contentsOf: [0,0,1,0])
            case "3": bits.append(contentsOf: [0,0,1,1])
            case "4": bits.append(contentsOf: [0,1,0,0])
            case "5": bits.append(contentsOf: [0,1,0,1])
            case "6": bits.append(contentsOf: [0,1,1,0])
            case "7": bits.append(contentsOf: [0,1,1,1])
            case "8": bits.append(contentsOf: [1,0,0,0])
            case "9": bits.append(contentsOf: [1,0,0,1])
            case "A": bits.append(contentsOf: [1,0,1,0])
            case "B": bits.append(contentsOf: [1,0,1,1])
            case "C": bits.append(contentsOf: [1,1,0,0])
            case "D": bits.append(contentsOf: [1,1,0,1])
            case "E": bits.append(contentsOf: [1,1,1,0])
            case "F": bits.append(contentsOf: [1,1,1,1])
            default: fatalError()
            }
        }
        return bits
    }
    
    struct Header {
        let version: Int
        let type: Int
    }
    
    enum Content {
        case value(Int)
        case packets([Packet])
    }
    
    struct Packet {
        let header: Header
        let content: Content
        
        static func create(from bits: Bits) -> Packet {
            let packets = getPackets(from: bits)
            assert(packets.count == 1)
            return packets[0]
        }
        
        private static func getPackets(from bits: Bits) -> [Packet] {
            var result = [Packet]()
            while bits.packetAvailable {
                result.append(getPacket(from: bits))
            }
            return result
        }
        
        private static func getPacket(from bits: Bits) -> Packet {
            let header = Header(version: bits.get(3), type: bits.get(3))
            if header.type == 4 {
                let content = Content.value(bits.readValue())
                let p = Packet(header: header, content: content)
                return p
            } else {
                let lengthType = bits.get(1)
                switch lengthType {
                case 0:
                    let bitLength = bits.get(15) // no. of bits for sub-packets
                    let subStream = bits.subStream(length: bitLength)
                    let subPackets = getPackets(from: subStream)
                    let p = Packet(header: header, content: .packets(subPackets))
                    return p
                case 1:
                    let numberOfSubpackets = bits.get(11) // no. of sub-packets
                    var subPackets = [Packet]()
                    for _ in 0 ..< numberOfSubpackets {
                        subPackets.append(getPacket(from: bits))
                    }
                    let p = Packet(header: header, content: .packets(subPackets))
                    return p
                default:
                    fatalError()
                }
            }
        }
        
        func versionSum() -> Int {
            switch self.content {
            case .value:
                return self.header.version
            case .packets(let packets):
                return self.header.version + packets.reduce(0) { sum, packet in
                    sum + packet.versionSum()
                }
            }
        }
        
        func eval() -> Int {
            switch self.content {
            case .value(let value):
                return value
            case .packets(let packets):
                switch self.header.type {
                case 0: // sum
                    return packets.reduce(0) { sum, p in
                        sum + p.eval()
                    }
                case 1: // product
                    return packets.reduce(1) { sum, p in
                        sum * p.eval()
                    }
                case 2: // min
                    var minP = Int.max
                    packets.forEach() {
                        minP = min(minP, $0.eval())
                    }
                    return minP
                case 3: // max
                    var maxP = 0
                    packets.forEach() {
                        maxP = max(maxP, $0.eval())
                    }
                    return maxP
                case 5: // greater
                    return packets[0].eval() > packets[1].eval() ? 1 : 0
                case 6: // less
                    return packets[0].eval() < packets[1].eval() ? 1 : 0
                case 7: // eq
                    return packets[0].eval() == packets[1].eval() ? 1 : 0
                default:
                    fatalError()
                }
            }
        }
    }
    
    class Bits {
        let bits: [UInt8]
        private var index = 0
        
        init(_ bits: [UInt8]) {
            self.bits = bits
        }
        
        func getRaw(_ n: Int) -> [UInt8] {
            let val = bits[index ..< index+n]
            index += n
            return Array(val)
        }
        
        private func intValue(_ bits: [UInt8]) -> Int {
            var value = 0
            bits.forEach {
                value <<= 1
                value |= Int($0)
            }
            return value
        }
        
        func get(_ n: Int) -> Int {
            intValue(getRaw(n))
        }
        
        func readValue() -> Int {
            var value = 0
            var more = true
            while more {
                more = get(1) == 1
                value <<= 4
                value |= intValue(getRaw(4))
            }
            return value
        }
        
        func subStream(length: Int) -> Bits {
            let subBits = bits[index ..< index+length]
            index += length
            return Bits(Array(subBits))
        }
        
        var packetAvailable: Bool {
            let minPacketSize = 3 + 3 + 5
            return index + minPacketSize <= bits.count
        }
    }
}
