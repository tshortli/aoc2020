//
//  Navigator.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Point: Equatable {
    public var north: Int
    public var east: Int
    
    public init(_ north: Int, _ east: Int) {
        self.north = north
        self.east = east
    }
    
    mutating func rotate(by angle: Int) {
        let prev = self
        let normalizedAngle = (angle > 0) ? angle : (360 + angle)
        switch normalizedAngle {
        case 90:
            north = -prev.east
            east = prev.north
        case 180:
            north = -prev.north
            east = -prev.east
        case 270:
            north = prev.east
            east = -prev.north
        default:
            fatalError()
        }
    }
    
    public var manhattanDistance: Int {
        return abs(north) + abs(east)
    }
}

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

    public init(input: String, waypoint: Point) {
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
    
    public func navigate(style: Style, waypoint initialWaypoint: Point) -> Point {
        var position = Point(0, 0)
        var waypoint = initialWaypoint
        
        func handleDirection(with vector: Point) {
            switch style {
            case .part1: position += vector
            case .part2: waypoint += vector
            }
        }

        route.forEach { (instruction, value) in
            switch instruction {
            case .north:
                handleDirection(with: Point(value, 0))
            case .east:
                handleDirection(with: Point(0, value))
            case .south:
                handleDirection(with: Point(-value, 0))
            case .west:
                handleDirection(with: Point(0, -value))
            case .forward:
                position += (waypoint * value)
            case .left:
                waypoint.rotate(by: -value)
            case .right:
                waypoint.rotate(by: value)
            }
            print("\(instruction) \(position)")
        }
        
        return position
    }
    
}

private func +=(lhs: inout Point, rhs: Point) {
    lhs.north += rhs.north
    lhs.east += rhs.east
}

private func *(lhs: Point, rhs: Int) -> Point {
    return Point(lhs.north * rhs, lhs.east * rhs)
}
