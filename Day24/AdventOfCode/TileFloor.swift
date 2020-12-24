//
//  TileFloor.swift
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
    
    /// Parses a string like "esenee" into an array of directions. Crashes on invalid input.
    static func directions(from string: String) -> [Direction] {
        var directions: [Direction] = []
        let scanner = Scanner(string: string)
        while let char = scanner.scanCharacter() {
            var string = String(char)
            if char == "s" || char == "n" {
                string.append(scanner.scanCharacter()!)
            }
            
            directions.append(Direction(rawValue: string)!)
        }
        
        return directions
    }
}

/// Represents a point on a hexagonal tile grid.
struct HexagonalTile: Equatable, Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        // To preserve unique representations of each possible location, x increments by 2 when traveling east or west,
        // or by 1 when traveling east/west and north/south.
        precondition(abs(x) % 2 == abs(y) % 2)
        self.x = x
        self.y = y
    }
    
    static var origin: Self { HexagonalTile(0, 0) }
    
    /// Returns the tile that would be reached by following a series of directions, starting at this tile.
    func translated(by directions: [Direction]) -> Self {
        directions.reduce(into: HexagonalTile(x, y)) { result, direction in
            result = result.translated(by: direction)
        }
    }
    
    /// Returns the tile that would be reached by following the given direction, starting at this tile.
    func translated(by direction: Direction) -> HexagonalTile {
        switch direction {
        case .east: return HexagonalTile(x + 2, y)
        case .southEast: return HexagonalTile(x + 1, y - 1)
        case .southWest: return HexagonalTile(x - 1, y - 1)
        case .west: return HexagonalTile(x - 2, y)
        case .northWest: return HexagonalTile(x - 1, y + 1)
        case .northEast: return HexagonalTile(x + 1, y + 1)
        }
    }
    
    /// Returns the six neighboring tiles.
    func adjacentTiles() -> [HexagonalTile] {
        Direction.allCases.map { translated(by: $0) }
    }
}

public struct TileFloor {
    let directionsList: [[Direction]]
    
    public init(input: String) {
        self.directionsList = input.components(separatedBy: .newlines).map { Direction.directions(from: $0) }
    }
    
    func startingBlackTiles() -> Set<HexagonalTile> {
        let origin = HexagonalTile.origin
        return directionsList.reduce(into: Set<HexagonalTile>()) { result, directions in
            let tile = origin.translated(by: directions)
            if result.remove(tile) == nil {
                result.insert(tile)
            }
        }
    }
    
    public func countStartingBlackTiles() -> Int {
        return startingBlackTiles().count
    }
    
    public func simulateArtExhibit(days: Int) -> Int {
        var blackTiles = startingBlackTiles()

        for _ in 1...days {
            // Build a set of all black tiles and their neighbors.
            let tiles = blackTiles.reduce(into: Set<HexagonalTile>()) { result, tile in
                result.insert(tile)
                tile.adjacentTiles().forEach { result.insert($0) }
            }
            
            // Any black tile with zero or more than 2 black tiles immediately adjacent to it is flipped to white.
            // Any white tile with exactly 2 black tiles immediately adjacent to it is flipped to black.
            blackTiles = tiles.reduce(into: Set<HexagonalTile>()) { result, tile in
                let adjacentBlackCount = tile.adjacentTiles().filter { blackTiles.contains($0) }.count
                if blackTiles.contains(tile) {
                    if adjacentBlackCount > 0, adjacentBlackCount < 3 {
                        result.insert(tile)
                    }
                } else if adjacentBlackCount == 2 {
                    result.insert(tile)
                }
            }
        }
        
        return blackTiles.count
    }
    
}
