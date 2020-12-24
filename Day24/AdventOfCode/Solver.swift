//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

enum Direction: String, CaseIterable {
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
        // To preserve unique representations of each possible location, x increments by 2 when traveling east or west,
        // or by 1 when traveling east/west and north/south.
        precondition(abs(x) % 2 == abs(y) % 2)
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
    
    func neighbors() -> [Point] {
        Direction.allCases.map { translated(by: $0) }
    }
}

public struct Solver {
    let directions: [[Direction]]
    
    public init(input: String) {
        self.directions = input.components(separatedBy: .newlines).map { Direction.directions(from: $0) }
    }
    
    func startingBlackTiles() -> Set<Point> {
        var blackTiles = Set<Point>()
        let origin = Point(0, 0)
        directions.forEach { directions in
            let point = origin.translated(by: directions)
            if blackTiles.remove(point) == nil {
                blackTiles.insert(point)
            }
        }
        
        return blackTiles
    }
    
    public func countBlackTiles() -> Int {
        return startingBlackTiles().count
    }
    
    public func simulateArtExhibit(days: Int) -> Int {
        var blackTiles = startingBlackTiles()

        for _ in 1...days {
            // Build a set of all black tiles and their neighbors.
            let tiles = blackTiles.reduce(into: Set<Point>()) { result, tile in
                result.insert(tile)
                tile.neighbors().forEach { result.insert($0) }
            }
            
            // Any black tile with zero or more than 2 black tiles immediately adjacent to it is flipped to white.
            // Any white tile with exactly 2 black tiles immediately adjacent to it is flipped to black.
            blackTiles = tiles.reduce(into: Set<Point>()) { result, tile in
                let blackNeighborCount = tile.neighbors().filter { blackTiles.contains($0) }.count
                if blackTiles.contains(tile) {
                    if blackNeighborCount > 0, blackNeighborCount < 3 {
                        result.insert(tile)
                    }
                } else if blackNeighborCount == 2 {
                    result.insert(tile)
                }
            }
        }
        
        return blackTiles.count
    }
    
}
