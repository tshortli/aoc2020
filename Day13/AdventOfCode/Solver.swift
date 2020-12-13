//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let earliestTime: Int
    let busIDs: [Int]
    
    public init(input: String) {
        let lines = input.components(separatedBy: .newlines)
        self.earliestTime = Int(lines.first!)!
        self.busIDs = lines.last!.components(separatedBy: ",").filter { $0 != "x" }.map { Int($0)! }
    }
    
    public func answer() -> Int {
        var minDelay = Int.max
        var minBusID = Int.max
        for busID in busIDs {
            let count = earliestTime / busID
            let delay = busID * (count + 1) - earliestTime
            if delay < minDelay {
                minDelay = delay
                minBusID = busID
            }
        }
        
        return minBusID * minDelay
    }
    
}
