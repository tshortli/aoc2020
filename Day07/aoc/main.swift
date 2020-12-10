//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let evaluator = BagColorRuleEvaluator(input: input)

let possibleContainers = evaluator.possibleContainers(for: "shiny gold").count
print("\(possibleContainers)")

let contained = evaluator.containedCount(for: "shiny gold")
print("\(contained)")
