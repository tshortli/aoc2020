//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    public enum Style {
        case adjacent
        case visible
    }
    
    enum Space {
        case floor
        case empty
        case occupied
    }
    
    var spaces: [Space]
    let style: Style
    let width: Int
    let height: Int
    
    public init(input: String, style: Style) {
        let lines = input.components(separatedBy: .newlines)
        self.width = lines.first?.count ?? 0
        self.height = lines.count
        var spaces: [Space] = []
        lines.forEach { line in
            spaces.append(contentsOf: line.map {
                switch $0 {
                case ".": return .floor
                case "L": return .empty
                case "#": return .occupied
                default: fatalError()
                }
            })
        }
        self.spaces = spaces
        self.style = style
    }
    
    mutating public func simulate() {
        let occupiedThreshold = (style == .adjacent) ? 4 : 5
        
        spaces = spaces.enumerated().map { (i, space) in
            let occupiedCount = countOccupiedSeats(for: i)
            if space == .empty && occupiedCount == 0 {
                return .occupied
            } else if space == .occupied && occupiedCount >= occupiedThreshold {
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
    
    public func countOccupiedSeats(for index: Int) -> Int {
        switch style {
        case .adjacent: return countAdjacentOccupiedSeats(for: index)
        case .visible: return countVisibleOccupiedSeats(for: index)
        }
    }
    
    func countAdjacentOccupiedSeats(for index: Int) -> Int {
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
    
    func countVisibleOccupiedSeats(for index: Int) -> Int {
        let vectors = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1), (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]
        
        return vectors.filter { (vr, vc) in
            var r = index / width + vr
            var c = index % width + vc

            while r >= 0 && r < height && c >= 0 && c < width {
                switch spaces[r * width + c] {
                case .floor: break
                case .empty: return false
                case .occupied: return true
                }
                r += vr
                c += vc
            }
            return false
        }.count
    }
    
    public func countOccupiedSeats() -> Int {
        return spaces.filter { $0 == .occupied }.count
    }
}

