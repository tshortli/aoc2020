//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

enum Direction: String {
    case east = "e"
    case southEast = "se"
    case southWest = "sw"
    case west = "w"
    case northWest = "nw"
    case northEast = "ne"
    
    static func directions(from string: String) -> [Direction] {
        var directions: [Direction] = []
        let scanner = Scanner(string: string)
        while let char = scanner.scanCharacter() {
            if char == "s" || char == "n" {
                directions.append(Direction(rawValue: String([char, scanner.scanCharacter()!]))!)
            } else {
                directions.append(Direction(rawValue: String(char))!)
            }
        }
        
        return directions
    }
}

struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    func translated(by directions: [Direction]) -> Self {
        directions.reduce(into: Point(x, y)) { result, direction in
            result = result.translated(by: direction)
        }
    }
    
    func translated(by direction: Direction) -> Point {
        switch direction {
        case .east: return Point(x + 2, y)
        case .southEast: return Point(x + 1, y - 1)
        case .southWest: return Point(x - 1, y - 1)
        case .west: return Point(x - 2, y)
        case .northWest: return Point(x - 1, y + 1)
        case .northEast: return Point(x + 1, y + 1)
        }
    }
}

public struct Solver {
    let directions: [[Direction]]
    
    public init(input: String) {
        self.directions = input.components(separatedBy: .newlines).map { Direction.directions(from: $0) }
    }
    
    public func countBlackTiles() -> Int {
        var blackTiles = Set<Point>()
        directions.forEach { directions in
            let point = Point(0, 0).translated(by: directions)
            if blackTiles.remove(point) == nil {
                blackTiles.insert(point)
            }
        }
        
        return blackTiles.count
    }
    
}
