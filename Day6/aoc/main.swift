//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let puzzle = Puzzle(input: input)

let uniqueAnswersSum = puzzle.uniqueAnswersSum()
print("\(uniqueAnswersSum)")

let intersectingAnswersSum = puzzle.intersectingAnswersSum()
print("\(intersectingAnswersSum)")
