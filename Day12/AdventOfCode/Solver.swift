//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    public enum Direction: Int {
        case north = 0
        case east = 90
        case south = 180
        case west = 270
        
        var vector: (Int, Int) {
            switch self {
            case .north:
                return (1, 0)
            case .east:
                return (0, 1)
            case .south:
                return (-1, 0)
            case .west:
                return (0, -1)
            }
        }
        
        func direction(with angle: Int) -> Self {
            let rawAngle = (rawValue + angle) % 360
            if rawAngle < 0 {
                return Direction(rawValue: 360 + rawAngle)!
            } else {
                return Direction(rawValue: rawAngle)!
            }
        }
    }
    
    enum Instruction: Character {
        case north = "N"
        case east = "E"
        case south = "S"
        case west = "W"
        case forward = "F"
        case left = "L"
        case right = "R"
    }
    
    let route: [(Instruction, Int)]
    public private(set) var position: (Int, Int) = (0, 0)
    public private(set) var direction: Direction = .east
    
    public init(input: String) {
        let lines = input.components(separatedBy: .newlines)
        var route: [(Instruction, Int)] = []
        lines.forEach {
            let scanner = Scanner(string: $0)
            let instruction = Instruction(rawValue: scanner.scanCharacter()!)!
            let number = scanner.scanInt()!
            route.append((instruction, number))
        }
        self.route = route
    }
    
    mutating public func answer() -> Int {
        route.forEach { (instruction, value) in
            var vector: (Int, Int) = (0, 0)
            var multiplier: Int = 1
            var newDirection: Direction?
            switch instruction {
            case .north:
                vector = Direction.north.vector
                multiplier = value
            case .east:
                vector = Direction.east.vector
                multiplier = value
            case .south:
                vector = Direction.south.vector
                multiplier = value
            case .west:
                vector = Direction.west.vector
                multiplier = value
            case .forward:
                vector = direction.vector
                multiplier = value
            case .left:
                newDirection = direction.direction(with: -value)
            case .right:
                newDirection = direction.direction(with: value)
            }
            
            position.0 += vector.0 * multiplier
            position.1 += vector.1 * multiplier
            
            if let newDirection = newDirection {
                direction = newDirection
            }
            
            print("\(direction) (\(position.0), \(position.1))")
        }
        
        return abs(position.0) + abs(position.1)
    }
    
}
