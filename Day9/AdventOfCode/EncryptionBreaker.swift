//
//  EncryptionBreaker.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct EncryptionBreaker {
    let numbers: [Int]
    let preamble: Int
    
    public init(input: String, preamble: Int) {
        self.numbers = input.components(separatedBy: .newlines).map { Int($0)! }
        self.preamble = preamble
    }
    
    public func findFirstNonSum() -> Int {
        outerloop: for i in preamble..<numbers.count {
            for v1 in numbers[(i - preamble)..<i] {
                for v2 in numbers[(i + 1 - preamble)..<i] where numbers[i] == v1 + v2 && v1 != v2 {
                    continue outerloop
                }
            }
            
            return numbers[i] // Not a sum
        }
        
        fatalError("No solution")
    }
    
    public func findEncryptionWeakness() -> Int {
        let target = findFirstNonSum()
        for (i, v1) in numbers.enumerated() {
            var smallest = v1, largest = v1, sum = v1
            for v2 in numbers[(i + 1)...] {
                smallest = min(smallest, v2)
                largest = max(largest, v2)
                sum += v2
                if sum == target {
                    return smallest + largest
                }
            }
        }
        
        fatalError("No solution")
    }
    
}
