//
//  ExpenseReport.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 11/29/20.
//

import Foundation

public struct ExpenseReport {
    public let items: [Int]
    
    public init(items: [Int]) {
        self.items = items
    }
    
    public func solve(sum: Int, itemCount: Int) -> Int? {
        guard itemCount > 0 else {
            return nil
        }
        
        guard let candidates = findCandidates(from: 0, sum: sum, itemCount: itemCount) else {
            return nil
        }
        
        return candidates.reduce(1, *)
    }
    
    internal func findCandidates(from startIndex: Int, sum: Int, itemCount: Int) -> [Int]? {
        // When there are no more items to find and sum is zero, then the caller must have found a valid sequence.
        guard itemCount > 0 else {
            return sum == 0 ? [] : nil
        }
        
        // Iterate over the remaining items and call this method recursively with one fewer items to find and a sum
        // decremented by the iterated value. When findCandidates(), returns non-nil, we have found a sequence that sums
        // to the desired sum.
        for (idx, value) in items[startIndex...].enumerated() {
            if let candidates = findCandidates(from: idx + 1, sum: sum - value, itemCount: itemCount - 1) {
                return candidates + [value]
            }
        }
        
        return nil
    }
}
