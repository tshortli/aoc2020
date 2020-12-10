//
//  AdapterOrganizer.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct AdapterOrganizer {
    let sortedAdapters: [Int]
    let builtInAdapter: Int
    
    public init(input: String) {
        let adapters = input.components(separatedBy: .newlines).compactMap { Int($0) }
        self.sortedAdapters = adapters.sorted()
        self.builtInAdapter = (sortedAdapters.last ?? 0) + 3
    }
    
    public func differencesDistribution() -> [Int: Int] {
        var differences: [Int: Int] = [:]
        var previous = 0
        for adapter in (sortedAdapters + [builtInAdapter]) {
            differences[(adapter - previous), default: 0] += 1
            previous = adapter
        }
        
        return differences
    }
    
    public func possibleArrangements() -> Int {
        let allAdapters = [0] + sortedAdapters + [builtInAdapter]
        var arrangementCounts: [Int: Int] = [builtInAdapter: 1]
        
        for adapter in allAdapters.reversed() {
            let possibleAdapters = allAdapters.filter { (adapter - 3..<adapter).contains($0) }
            possibleAdapters.forEach {
                arrangementCounts[$0, default: 0] += arrangementCounts[adapter] ?? 0
            }
        }
        
        return arrangementCounts[0]!
    }
    
}
