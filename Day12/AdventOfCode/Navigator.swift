//
//  Navigator.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Navigator {
    public enum Style {
        case part1
        case part2
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
    let style: Style
    public let waypoint: (Int, Int)

    public init(input: String, style: Style, waypoint: (Int, Int)) {
        let lines = input.components(separatedBy: .newlines)
        var route: [(Instruction, Int)] = []
        lines.forEach {
            let scanner = Scanner(string: $0)
            let instruction = Instruction(rawValue: scanner.scanCharacter()!)!
            let number = scanner.scanInt()!
            route.append((instruction, number))
        }
        self.route = route
        self.style = style
        self.waypoint = waypoint
    }
    
    mutating public func answer() -> Int {
        var position = (0, 0)
        var waypoint = self.waypoint
        
        func handleDirection(with vector: (Int, Int)) {
            switch self.style {
            case .part1: position += vector
            case .part2: waypoint += vector
            }
        }

        route.forEach { (instruction, value) in
            switch instruction {
            case .north:
                handleDirection(with: (value, 0))
            case .east:
                handleDirection(with: (0, value))
            case .south:
                handleDirection(with: (-value, 0))
            case .west:
                handleDirection(with: (0, -value))
            case .forward:
                position += (waypoint * value)
            case .left:
                waypoint = rotate(vector: waypoint, by: -value)
            case .right:
                waypoint = rotate(vector: waypoint, by: value)
            }
        }
        
        return abs(position.0) + abs(position.1)
    }
    
}

private func +=(lhs: inout (Int, Int), rhs: (Int, Int)) {
    lhs.0 += rhs.0
    lhs.1 += rhs.1
}

private func *(lhs: (Int, Int), rhs: Int) -> (Int, Int) {
    return (lhs.0 * rhs, lhs.1 * rhs)
}

func rotate(vector: (Int, Int), by angle: Int) -> (Int, Int) {
    let normalizedAngle = (angle > 0) ? angle : (360 + angle)
    switch normalizedAngle {
    case 90:
        return (-vector.1, vector.0)
    case 180:
        return (-vector.0, -vector.1)
    case 270:
        return (vector.1, -vector.0)
    default:
        fatalError()
    }
}
