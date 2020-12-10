//
//  BagColorRuleEvaluator.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct BagColorRuleEvaluator {
    let possibleContainersByColor: [String: Set<String>]
    let colorsByContainer: [String: [String]]

    public init(input: String) {
        var possibleContainersByColor: [String: Set<String>] = [:]
        var colorsByContainer: [String: [String]] = [:]
        
        for line in input.components(separatedBy: .newlines) {
            let components = line.components(separatedBy: " bags contain")
            let containerColor = components[0]
            let clauses = components[1].components(separatedBy: ", ")
            var containedColors: [String] = []

            for clause in clauses {
                let scanner = Scanner(string: clause)
                guard let count = scanner.scanInt() else { continue }
                guard let color = scanner.scanUpToString(" bag") else { fatalError("Invalid format") }
                
                possibleContainersByColor[color, default: Set()].insert(containerColor)
                containedColors += Array(repeating: color, count: count)
            }
            
            colorsByContainer[containerColor] = containedColors
        }
        
        self.possibleContainersByColor = possibleContainersByColor
        self.colorsByContainer = colorsByContainer
    }
    
    public func possibleContainers(for color: String) -> Set<String> {
        let containers = possibleContainersByColor[color] ?? Set()
        return containers.reduce(containers) { $0.union(possibleContainers(for: $1)) }
    }
    
    public func containedCount(for color: String) -> Int {
        let colors = colorsByContainer[color] ?? []
        return colors.reduce(colors.count) { $0 + containedCount(for: $1) }
    }
        
}
