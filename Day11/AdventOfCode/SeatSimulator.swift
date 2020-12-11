//
//  SeatSimulator.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct SeatSimulator {
    public enum Style {
        case adjacent
        case visible
    }
    
    enum Space: Character {
        case floor = "."
        case empty = "L"
        case occupied = "#"
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
            spaces.append(contentsOf: line.map { Space(rawValue: $0)! })
        }
        self.spaces = spaces
        self.style = style
    }
    
    mutating public func step() {
        let occupiedThreshold = (style == .adjacent) ? 4 : 5
        
        spaces = spaces.enumerated().map { (i, space) in
            guard space != .floor else {
                return .floor
            }
            
            let occupiedCount = countOccupiedSeats(for: i)
            if space == .empty, occupiedCount == 0 {
                return .occupied
            } else if space == .occupied, occupiedCount >= occupiedThreshold {
                return .empty
            }
            return space
        }
    }
    
    mutating public func run() {
        var prev: [Space] = []
        while prev != spaces {
            prev = spaces
            step()
        }
    }
    
    let vectors = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    
    public func countOccupiedSeats(for index: Int) -> Int {
        return vectors.filter { (vectorRow, vectorCol) in
            var r = index / width + vectorRow
            var c = index % width + vectorCol

            while r >= 0 && r < height && c >= 0 && c < width {
                if let occupied = seatIsOccupiedAt(row: r, column: c) {
                    return occupied
                }
                
                guard style == .visible else {
                    break
                }
                r += vectorRow
                c += vectorCol
            }
            return false
        }.count
    }
    
    func seatIsOccupiedAt(row: Int, column: Int) -> Bool? {
        switch spaces[row * width + column] {
        case .floor:
            return nil
        case .empty:
            return false
        case .occupied:
            return true
        }
    }
    
    public func countOccupiedSeats() -> Int {
        return spaces.filter { $0 == .occupied }.count
    }
}

