//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let joltages: [Int]
    
    public init(input: String) {
        self.joltages = input.components(separatedBy: .newlines).map { Int($0)! }
    }
    
    public func differencesDistribution() -> [Int: Int] {
        var sortedJoltages = joltages.sorted()
        sortedJoltages.append(sortedJoltages.last! + 3)
        
        var differences: [Int: Int] = [:]
        for (i, joltage) in sortedJoltages.enumerated() {
            if i < 1 {
                differences[joltage, default: 0] += 1
            } else {
                let difference = joltage - sortedJoltages[i - 1]
                differences[difference, default: 0] += 1
            }
        }
        
        return differences
    }
    
}
