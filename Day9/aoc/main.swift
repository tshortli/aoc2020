//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let solver = EncryptionBreaker(input: input, preamble: 25)

let answer = solver.findFirstNonSum()
print("\(answer)")

let part2 = solver.findEncryptionWeakness()
print("\(part2)")
