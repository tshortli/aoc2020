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
        let w: Int

        init(_ x: Int, _ y: Int, _ z: Int, _ w: Int) {
            self.x = x
            self.y = y
            self.z = z
            self.w = w
        }
        
        /// Returns all neighboring cubes including self
        func getNeighbors() -> [Cube] {
            return
                Cube(x, y, z, w - 1).getNeighborsFixedW() +
                getNeighborsFixedW() +
                Cube(x, y, z, w + 1).getNeighborsFixedW()
        }
        
        /// Returns all neighboring cubes on the same W plane, including self
        func getNeighborsFixedW() -> [Cube] {
            return
                Cube(x, y, z - 1, w).getNeighborsFixedZW() +
                getNeighborsFixedZW() +
                Cube(x, y, z + 1, w).getNeighborsFixedZW()
        }
        
        /// Returns all neighboring on the same ZW plane, including self
        func getNeighborsFixedZW() -> [Cube] {
            return
                Cube(x, y - 1, z, w).getNeighborsFixedYZW() +
                getNeighborsFixedYZW() +
                Cube(x, y + 1, z, w).getNeighborsFixedYZW()
        }
        
        /// Returns all neighboring on the same ZW plane, including self
        func getNeighborsFixedYZW() -> [Cube] {
            return [Cube(x - 1, y, z, w), Cube(x, y, z, w), Cube(x + 1, y, z, w)]
        }
    }
    
    let initialActiveCubes: Set<Cube>
    
    public init(input: String) {
        var activeCubes: Set<Cube> = []
        var y = 0
        input.components(separatedBy: .newlines).forEach { line in
            var x = 0
            line.forEach { char in
                if char == "#" { activeCubes.insert(Cube(x, y, 0, 0)) }
                x += 1
            }
            y += 1
        }
        
        self.initialActiveCubes = activeCubes
    }
    
    func simulate(count: Int, neighborGenerator: (Cube) -> [Cube]) -> Set<Cube> {
        var activeCubes = initialActiveCubes
        
        for _ in 1...count {
            var nextActiveCubes = Set<Cube>()
            let allCubes = activeCubes.reduce(into: Set<Cube>()) { set, cube in
                for neighbor in neighborGenerator(cube) {
                    set.insert(neighbor)
                }
            }
            
            for cube in allCubes {
                let activeNeighborCount = neighborGenerator(cube).filter { $0 != cube && activeCubes.contains($0) }.count
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
    
    public func activeCubesAfterSimulationFixedW() -> Int {
        return simulate(count: 6, neighborGenerator: { $0.getNeighborsFixedW() }).count
    }
    
    public func activeCubesAfterSimulation() -> Int {
        return simulate(count: 6, neighborGenerator: { $0.getNeighbors() }).count
    }
}
