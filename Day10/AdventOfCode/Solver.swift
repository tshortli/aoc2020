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
    
    public func possibleArrangements() -> Int {
        var sortedJoltages = joltages.sorted()
        sortedJoltages.insert(0, at: 0)
        let lastJoltage = sortedJoltages.last! + 3
        sortedJoltages.append(lastJoltage)
        
        var map: [Int: Int] = [lastJoltage: 1]
        for joltage in sortedJoltages.reversed() {
            if let count = map[joltage] {
                for possibleJoltage in sortedJoltages.filter({ (joltage - 3..<joltage).contains($0) }) {
                    map[possibleJoltage, default: 0] += count
                }
            }
        }
        
        return map[0]!
    }
    
}
