//
//  TobogganRouter.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/2/20.
//

import Foundation

public struct TobogganRouter {
    public let input: [String]

    public init(input: String) {
        self.input = input.components(separatedBy: .newlines)
    }
    
    public func countTrees(vector: (x: Int, y: Int)) -> Int {
        var treeCount = 0
        var position = (0, 0)
        while position.1 < input.count {
            if hasTree(at: position) {
                treeCount += 1
            }

            position.0 += vector.0
            position.1 += vector.1
        }
        return treeCount
    }
    
    func hasTree(at point: (x: Int, y: Int)) -> Bool {
        return char(at: point) == "#"
    }

    func char(at point: (x: Int, y: Int)) -> Character {
        let line = input[point.y]
        let offset = point.x % line.count
        return line[line.index(line.startIndex, offsetBy: offset)]
    }
}
