//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let lines: [String]
    
    public init(input: String) {
        self.lines = input.components(separatedBy: .newlines)
    }
    
    public func answer() -> Int {
        return lines.count
    }
    
}
