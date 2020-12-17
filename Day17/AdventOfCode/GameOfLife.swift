//
//  GameOfLife.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct GameOfLife {
    struct Cube: Equatable, Hashable {
        let x: Int
        let y: Int
        let z: Int
        let w: Int
    }
    
    let initialActiveCubes: Set<Cube>
    
    public init(input: String) {
        var activeCubes: Set<Cube> = []

        for (y, line) in input.components(separatedBy: .newlines).enumerated() {
            for (x, char) in line.enumerated() where char == "#" {
                activeCubes.insert(Cube(x, y, 0, 0))
            }
        }
        
        self.initialActiveCubes = activeCubes
    }
    
    func simulate(count: Int, neighborGenerator: (Cube) -> [Cube]) -> Set<Cube> {
        var activeCubes = initialActiveCubes
        
        for _ in 1...count {
            activeCubes = simulate(activeCubes: activeCubes, neighborGenerator: neighborGenerator)
        }
        
        return activeCubes
    }
    
    func simulate(activeCubes: Set<Cube>, neighborGenerator: (Cube) -> [Cube]) -> Set<Cube> {
        let allCubes = activeCubes.reduce(into: Set<Cube>()) { set, cube in
            neighborGenerator(cube).forEach { set.insert($0) }
        }
        
        return allCubes.reduce(into: Set<Cube>()) { nextActiveCubes, cube in
            let activeCount = neighborGenerator(cube).filter { $0 != cube && activeCubes.contains($0) }.count
            if activeCubes.contains(cube) {
                if activeCount == 2 || activeCount == 3 {
                    nextActiveCubes.insert(cube)
                }
            } else if activeCount == 3 {
                nextActiveCubes.insert(cube)
            }
        }
    }
    
    public func activeCubesAfterSimulationFixedW() -> Int {
        return simulate(count: 6, neighborGenerator: { $0.neighborsFixedW() }).count
    }
    
    public func activeCubesAfterSimulation() -> Int {
        return simulate(count: 6, neighborGenerator: { $0.neighbors() }).count
    }
    
}

extension GameOfLife.Cube {
    init(_ x: Int, _ y: Int, _ z: Int, _ w: Int) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    func neighbors() -> [Self] {
        Self(x, y, z, w - 1).neighborsFixedW() + neighborsFixedW() + Self(x, y, z, w + 1).neighborsFixedW()
    }
    
    func neighborsFixedW() -> [Self] {
        Self(x, y, z - 1, w).neighborsFixedZW() + neighborsFixedZW() + Self(x, y, z + 1, w).neighborsFixedZW()
    }
    
    func neighborsFixedZW() -> [Self] {
        Self(x, y - 1, z, w).neighborsFixedYZW() + neighborsFixedYZW() + Self(x, y + 1, z, w).neighborsFixedYZW()
    }
    
    func neighborsFixedYZW() -> [Self] {
        [Self(x - 1, y, z, w), self, Self(x + 1, y, z, w)]
    }
}
