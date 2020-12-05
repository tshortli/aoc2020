//
//  BoardingPassProcessor.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/4/20.
//

import Foundation

public struct BoardingPassProcessor {
    let lines: [String]
    
    public init(input: String) {
        self.lines = input.components(separatedBy: .newlines)
    }
    
    public func seat(for string: String) -> Int {
        // The strings form numbers in binary, so we can build the seat ID by adding decreasing powers of 2.
        var increment = 1 << string.count
        
        return string.reduce(0) { seat, char in
            increment /= 2
            return seat + (char == "B" || char == "R" ? increment : 0)
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
