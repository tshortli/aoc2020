//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let solver = Solver(input: input)

let possibleContainers = solver.possibleContainers(for: "shiny gold").count
print("\(possibleContainers)")

let contained = solver.containedCount(by: "shiny gold")
print("\(contained)")
