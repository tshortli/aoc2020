//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let startDate = Date()
print("\(Parser.part1PrecedenceSolver().sumEvaluations(input: input))")
print("\(Parser.part2PrecedenceSolver().sumEvaluations(input: input))")

print("Finished in \(Int(Date().timeIntervalSince(startDate) * 1000)) ms")
