//
//  BoardingPassProcessor.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/4/20.
//

import Foundation

public struct BoardingPassProcessor {
    let lines: [String]
    let maxIncrement: Int
    
    public init(input: String) {
        self.lines = input.components(separatedBy: .newlines)
        
        // Make sure the lines have homogeneous length.
        let lengths = self.lines.reduce(into: Set<Int>()) { $0.insert($1.count) }
        guard let length = lengths.first, lengths.count == 1 else {
            fatalError("Invalid input")
        }
        self.maxIncrement = Int(pow(2.0, Double(length - 1)))
    }
    
    public func seat(for string: String) -> Int {
        // The strings form numbers in binary, so we can build the seat ID by adding decreasing powers of 2.
        var increment = maxIncrement
        func multiplier(_ character: Character) -> Int {
            switch character {
            case "F", "L":   return 0
            case "B", "R":   return 1
            default:    fatalError("Unexpected char \(character)")
            }
        }
        
        return string.reduce(0) { seat, char in
            let prevIncrement = increment
            increment /= 2
            return seat + multiplier(char) * prevIncrement
        }
    }
    
    func seats() -> [Int] {
        return lines.map { seat(for: $0) }
    }
    
    public func highestSeat() -> Int? {
        return seats().sorted().last
    }
    
    public func missingSeat() -> Int? {
        return seats().sorted().reduce(nil) { result, next in
            if let result = result {
                return (next == result + 1) ? next : result
            }
            return next
        }
    }
    
}
