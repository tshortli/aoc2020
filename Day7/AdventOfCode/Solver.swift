//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    var containersByBagColor: [String: Set<String>]
    
    public init(input: String) {
        self.containersByBagColor = [:]
        for line in input.components(separatedBy: .newlines) {
            let components = line.components(separatedBy: " bags contain")
            let containerBag = components[0]
            let clauses = components[1].components(separatedBy: ", ")
            for clause in clauses {
                let scanner = Scanner(string: clause)
                if let _ = scanner.scanInt() {
                    if let color = scanner.scanUpToString(" bag") {
                        var containers = self.containersByBagColor[color] ?? Set()
                        containers.insert(containerBag)
                        self.containersByBagColor[color] = containers
                    } else {
                        fatalError("Invalid format: \(line)")
                    }
                } else {
                    continue
                }
            }
        }

    }
    
    public func containers(for color: String) -> Set<String> {
        if let containerColors = containersByBagColor[color] {
            return containerColors.reduce(containerColors) { $0.union(containers(for: $1)) }
        } else {
            return Set()
        }
    }
        
}
