//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    struct Tile {
        let number: Int
        let edges: Set<String>
        
        init(string: String) {
            let lines = string.components(separatedBy: .newlines)
            let tileNumberString = String(lines[0].replacingOccurrences(of: "Tile ", with: "").dropLast())
            
            let imageLines = lines.dropFirst()
            let leftEdge: String = imageLines.reduce(into: "") { $0.append($1.first!) }
            let rightEdge: String = imageLines.reduce(into: "") { $0.append($1.last!) }
            self.edges = Set([imageLines.first!, rightEdge, imageLines.last!, leftEdge])
            self.number = Int(tileNumberString)!
        }
    }
    
    let tiles: [Tile]
    
    public init(input: String) {
        self.tiles = input.components(separatedBy: "\n\n").map { Tile(string: $0) }
    }
    
    public func neighborCountByTileNumber() -> [Int: Int] {
        return tiles.reduce(into: [:]) { result, image in
            let matchCount = image.edges.reduce(0) { count, edge in
                let reversedEdge = String(edge.reversed())
                let matchingImage = tiles.first(where: { otherImage in
                    otherImage.number != image.number &&
                        (otherImage.edges.contains(edge) || otherImage.edges.contains(reversedEdge))
                })
                return count + (matchingImage != nil ? 1 : 0)
            }
            
            result[image.number] = matchCount
        }
    }
    
    public func answerPart1() -> Int {
        var product = 1
        for (tileNumber, count) in neighborCountByTileNumber() where count == 2 {
            product *= tileNumber
        }
        return product
    }
    
}
