//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    struct Cube: Equatable, Hashable {
        let x: Int
        let y: Int
        let z: Int
        
        init(_ x: Int, _ y: Int, _ z: Int) {
            self.x = x
            self.y = y
            self.z = z
        }
        
        /// Returns all neighboring cubes including self.
        func getNeighbors() -> [Cube] {
            return
                Cube(x, y, z - 1).getNeighborsFixedZ() +
                getNeighborsFixedZ() +
                Cube(x, y, z + 1).getNeighborsFixedZ()
        }
        
        /// Returns all neighboring on the same Z plane, including self
        func getNeighborsFixedZ() -> [Cube] {
            return [
                Cube(x - 1, y - 1, z), Cube(x - 1, y, z), Cube(x - 1, y + 1, z),
                Cube(x, y - 1, z), Cube(x, y, z), Cube(x, y + 1, z),
                Cube(x + 1, y - 1, z), Cube(x + 1, y, z), Cube(x + 1, y + 1, z)
            ]
        }
    }
    
    let initialActiveCubes: Set<Cube>
    
    public init(input: String) {
        var activeCubes: Set<Cube> = []
        var y = 0
        input.components(separatedBy: .newlines).forEach { line in
            var x = 0
            line.forEach { char in
                if char == "#" { activeCubes.insert(Cube(x, y, 0)) }
                x += 1
            }
            y += 1
        }
        
        self.initialActiveCubes = activeCubes
    }
    
    func simulate(count: Int) -> Set<Cube> {
        var activeCubes = initialActiveCubes
        
        for _ in 1...count {
            var nextActiveCubes = Set<Cube>()
            let allCubes = activeCubes.reduce(into: Set<Cube>()) { set, cube in
                for neighbor in cube.getNeighbors() {
                    set.insert(neighbor)
                }
            }
            
            for cube in allCubes {
                let activeNeighborCount = cube.getNeighbors().filter { $0 != cube && activeCubes.contains($0) }.count
                if activeCubes.contains(cube) {
                    if activeNeighborCount == 2 || activeNeighborCount == 3 {
                        nextActiveCubes.insert(cube)
                    }
                } else if activeNeighborCount == 3 {
                    nextActiveCubes.insert(cube)
                }
            }
            
            activeCubes = nextActiveCubes
        }
        
        return activeCubes
    }
    
    public func activeCubesAfterSimulation() -> Int {
        return simulate(count: 6).count
    }
}
