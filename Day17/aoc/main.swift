//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let startDate = Date()
let game = GameOfLife(input: input)

print("\(game.activeCubesAfterSimulationFixedW())")
print("\(game.activeCubesAfterSimulation())")

print("Finished in \(Int(Date().timeIntervalSince(startDate) * 1000)) ms")
