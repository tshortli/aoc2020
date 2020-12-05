//
//  BoardingPassProcessor.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/4/20.
//

import Foundation

public struct BoardingPassProcessor {
    let lines: [String]
    let rows = 128
    let columns = 8
    
    public init(input: String) {
        self.lines = input.components(separatedBy: .newlines)
    }
    
    public func seatPosition(for string: String) -> (Int, Int) {
        var row = (0, rows)
        var col = (0, columns)
        for character in string {
            switch character {
            case "F":
                row.1 -= max((row.1 - row.0) / 2, 1)
            case "B":
                row.0 += max((row.1 - row.0) / 2, 1)
            case "L":
                col.1 -= max((col.1 - col.0) / 2, 1)
            case "R":
                col.0 += max((col.1 - col.0) / 2, 1)
            default:
                fatalError("Unexpected char \(character)")
            }
        }
        
        return (row.0, col.0)
    }
    
    public func seatID(for string: String) -> Int {
        let position = self.seatPosition(for: string)
        return position.0 * columns + position.1
    }
    
    public func seatIDs() -> [Int] {
        return lines.map { seatID(for: $0) }
    }
    
    public func highestSeatID() -> Int? {
        return seatIDs().sorted().last
    }
    
    public func missingSeatID() -> Int? {
        let ids = seatIDs().sorted()
        var lastSeatID = ids.first!
        for seatID in ids[1...] {
            if seatID != lastSeatID + 1 {
                return seatID - 1
            }
            lastSeatID = seatID
        }
        return nil
    }
}
