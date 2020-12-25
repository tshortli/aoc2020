//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let input =
"""
1614360
7734663
"""

let startDate = Date()
let solver = Solver(input: input)
print("\(solver.deriveEncryptionKey())")

print("Finished in \(Int(Date().timeIntervalSince(startDate) * 1000)) ms")
