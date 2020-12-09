//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let numbers: [Int]
    let preamble: Int
    
    public init(input: String, preamble: Int) {
        self.numbers = input.components(separatedBy: .newlines).map { Int($0)! }
        self.preamble = preamble
    }
    
    public func answer() -> Int {
        outerloop: for i in preamble..<numbers.count {
            let current = numbers[i]
            for j in (i - preamble)..<i {
                for k in (j + 1)..<i {
                    if current == numbers[j] + numbers[k] {
                        continue outerloop
                    }
                }
            }
            
            // If we haven't continued, we've found the first number that isn't a sum
            return current
        }
        
        fatalError()
    }
    
}
