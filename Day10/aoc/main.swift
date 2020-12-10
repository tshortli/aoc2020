//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let solver = Solver(input: input)

let answer = solver.differencesDistribution()
print("\(answer)")
print("\(answer[1]! * answer[3]!)")

let possibleArrangements = solver.possibleArrangements()
print("\(possibleArrangements)")
