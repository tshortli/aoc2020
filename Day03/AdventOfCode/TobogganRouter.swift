//
//  TobogganRouter.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/2/20.
//

import Foundation

public struct TobogganRouter {
    public struct Vector: Equatable {
        let x: Int, y: Int
        
        public init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
        
        static func +(lhs: Self, rhs: Self) -> Self {
            return Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
        }
    }
    
    public let input: [String]

    public init(input: String) {
        self.input = input.components(separatedBy: .newlines)
    }
    
    public func countTrees(vector: Vector) -> Int {
        var treeCount = 0
        var position = Vector(x: 0, y: 0)
        while position.y < input.count {
            treeCount += hasTree(at: position) ? 1 : 0
            position = position + vector
        }
        return treeCount
    }
    
    func hasTree(at point: Vector) -> Bool {
        return char(at: point) == "#"
    }

    func char(at point: Vector) -> Character? {
        let line = input[point.y]
        let length = line.count
        guard length > 0 else {
            return nil
        }

        let offset = point.x % length
        return line[line.index(line.startIndex, offsetBy: offset)]
    }
}
