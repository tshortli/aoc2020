//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let possibleContainersByColor: [String: Set<String>]
    let containedColorsByColor: [String: [String]]

    public init(input: String) {
        var possibleContainersByColor: [String: Set<String>] = [:]
        var containedColorsByColor: [String: [String]] = [:]
        
        for line in input.components(separatedBy: .newlines) {
            let components = line.components(separatedBy: " bags contain")
            let containerColor = components[0]
            let clauses = components[1].components(separatedBy: ", ")
            var contained: [String] = []

            for clause in clauses {
                let scanner = Scanner(string: clause)
                if let count = scanner.scanInt() {
                    if let color = scanner.scanUpToString(" bag") {
                        var containers = possibleContainersByColor[color] ?? Set()
                        containers.insert(containerColor)
                        possibleContainersByColor[color] = containers
                        
                        for _ in 1...count {
                            contained.append(color)
                        }
                    } else {
                        fatalError("Invalid format: \(line)")
                    }
                } else {
                    continue
                }
                
            }
            
            containedColorsByColor[containerColor] = contained
        }
        
        self.possibleContainersByColor = possibleContainersByColor
        self.containedColorsByColor = containedColorsByColor
    }
    
    public func possibleContainers(for color: String) -> Set<String> {
        if let containerColors = possibleContainersByColor[color] {
            return containerColors.reduce(containerColors) { $0.union(possibleContainers(for: $1)) }
        } else {
            return Set()
        }
    }
    
    public func contained(by color: String) -> [String] {
        if let containedColors = containedColorsByColor[color] {
            let result: [String] = containedColors.reduce(into: []) { result, value in
                result.append(contentsOf: contained(by: value))
            }
            return result + containedColors
        } else {
            return []
        }
    }
        
}
