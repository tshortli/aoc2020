//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    enum Space {
        case floor
        case empty
        case occupied
    }
    
    var spaces: [Space]
    let width: Int
    let height: Int
    
    public init(input: String) {
        let lines = input.components(separatedBy: .newlines)
        self.width = lines.first?.count ?? 0
        self.height = lines.count
        var spaces: [Space] = []
        lines.forEach { line in
            spaces.append(contentsOf: line.map {
                switch $0 {
                case ".": return .floor
                case "L": return .empty
                default: fatalError()
                }
            })
        }
        self.spaces = spaces
    }
    
    mutating public func simulate() {
        spaces = spaces.enumerated().map { (i, space) in
            let adjacentOccupied = countAdjacentOccupiedSeats(at: i)
            if space == .empty && adjacentOccupied == 0 {
                return .occupied
            } else if space == .occupied && adjacentOccupied >= 4 {
                return .empty
            }
            return space
        }
    }
    
    mutating public func simulateUntilStable() {
        while true {
            let prev = spaces
            simulate()
            if prev == spaces {
                return
            }
        }
    }
    
    public func countAdjacentOccupiedSeats(at index: Int) -> Int {
        let row = index / width
        let col = index % width
        return [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1), (0, 1),
            (1, -1), (1, 0), (1, 1)
        ].map {
            return ($0.0 + row, $0.1 + col)
        }.filter { (r, c) in
            r >= 0 && r < height && c >= 0 && c < width && spaces[r * width + c] == .occupied
        }.count
    }
    
    public func countOccupiedSeats() -> Int {
        return spaces.filter { $0 == .occupied }.count
    }
    
//    public func render() -> String {
//        return spaces.enumerated().reduce(into: String()) { string, (index, space) in
//            string += character(for: space)
//            return char + (space % width == 1) ? "\n" : ""
//        }
//    }
//
//    func character(for space: Space) -> Character {
//        switch space {
//        case .floor: return "."
//        case .empty: return "L"
//        case .occupied: return "#"
//        }
//    }
}

