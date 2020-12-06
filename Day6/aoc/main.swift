//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let solver = Solver(input: input)

let uniqueAnswersSum = solver.uniqueAnswersSum()
print("\(uniqueAnswersSum)")

let intersectingAnswersSum = solver.intersectingAnswersSum()
print("\(intersectingAnswersSum)")
