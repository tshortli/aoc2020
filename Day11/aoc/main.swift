//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

var solver = Solver(input: input)

solver.simulateUntilStable()
let answer = solver.countOccupiedSeats()
print("\(answer)")
