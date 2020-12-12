//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
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
    public private(set) var waypoint: (Int, Int)

    public init(input: String, waypoint: (Int, Int)) {
        let lines = input.components(separatedBy: .newlines)
        var route: [(Instruction, Int)] = []
        lines.forEach {
            let scanner = Scanner(string: $0)
            let instruction = Instruction(rawValue: scanner.scanCharacter()!)!
            let number = scanner.scanInt()!
            route.append((instruction, number))
        }
        self.route = route
        self.waypoint = waypoint
    }
    
    mutating public func answer() -> Int {
        route.forEach { (instruction, value) in
            var waypointVector: (Int, Int) = (0, 0)
            var positionVector: (Int, Int) = (0, 0)
            var multiplier: Int = 1
            switch instruction {
            case .north:
                waypointVector = (1, 0)
                multiplier = value
            case .east:
                waypointVector = (0, 1)
                multiplier = value
            case .south:
                waypointVector = (-1, 0)
                multiplier = value
            case .west:
                waypointVector = (0, -1)
                multiplier = value
            case .forward:
                positionVector = waypoint
                multiplier = value
            case .left:
                waypoint = rotated(vector: waypoint, angle: -value)
            case .right:
                waypoint = rotated(vector: waypoint, angle: value)
            }
            
            waypoint.0 += waypointVector.0 * multiplier
            waypoint.1 += waypointVector.1 * multiplier
            
            position.0 += positionVector.0 * multiplier
            position.1 += positionVector.1 * multiplier
                        
            print("Position (\(position.0), \(position.1)), waypoint (\(waypoint.0), \(waypoint.1))")
        }
        
        return abs(position.0) + abs(position.1)
    }
    
    func rotated(vector: (Int, Int), angle: Int) -> (Int, Int) {
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
    
}
