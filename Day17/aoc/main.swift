//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let game = GameOfLife(input: input)

print("\(game.activeCubesAfterSimulationFixedW())")
print("\(game.activeCubesAfterSimulation())")
