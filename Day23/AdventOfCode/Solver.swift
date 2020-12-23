//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct CircularList<T: Equatable> {
    private(set) var elements: [T]
    
    public init(_ elements: [T]) {
        self.elements = elements
    }
    
    var count: Int { elements.count }
    
    subscript(index: Int) -> T {
        get {
            elements[normalizedIndex(index)]
        }
        set(newValue) {
            elements[normalizedIndex(index)] = newValue
        }
    }
    
    func normalizedIndex(_ index: Int) -> Int {
        let count = elements.count
        return (index >= 0) ? index % count : (count + index) % count
    }
    
    mutating public func insert(items: [T], at index: Int) {
        elements.insert(contentsOf: items, at: normalizedIndex(index))
    }
    
    mutating public func removeItems(at index: Int, count: Int) -> [T] {
        assert(count <= elements.count)
        let normalizedIndices = (0..<count).map { normalizedIndex(index + $0) }
        let result = normalizedIndices.map { elements[$0] }
        normalizedIndices.sorted().reversed().forEach { elements.remove(at: $0) }
        return result
    }
    
    func index(of element: T) -> Int {
        return elements.firstIndex { $0 == element }!
    }
}

public struct Solver {
    let startingCups: [Int]
    
    public init(input: String) {
        self.startingCups = input.compactMap { Int(String($0)) }
    }
    
    public func move(_ moves: Int) -> String {
        var cupList = CircularList(startingCups)
        var currentCup = startingCups[0]
        
        for _ in 1...moves {
            let currentCupIndex = cupList.index(of: currentCup)
            
            // Remove three cups clockwise of the current cup.
            let removedCups = cupList.removeItems(at: currentCupIndex + 1, count: 3)
            
            // Select a destination cup.
            let destinationCup = cupList.elements.sorted().reversed().first { $0 < currentCup } ?? cupList.elements.max()!
            let destinationCupIndex = cupList.index(of: destinationCup)

            // Reinsert the cups clockwise of the destination cup.
            cupList.insert(items: removedCups, at: destinationCupIndex + 1)
            
            // Select the cup clockwise of the current cup as the new current cup.
            currentCup = cupList[cupList.index(of: currentCup) + 1]
        }
        
        // List the cups in their current order starting at cup 1.
        let cupOneIndex = cupList.index(of: 1)
        return (1...(cupList.count - 1)).reduce(into: "") { $0 += String(cupList[cupOneIndex + $1]) }
    }
    
}
