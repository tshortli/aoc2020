//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let processor = CustomsFormsProcessor(input: input)

let uniqueAnswersSum = processor.uniqueAnswersSum()
print("\(uniqueAnswersSum)")

let intersectingAnswersSum = processor.intersectingAnswersSum()
print("\(intersectingAnswersSum)")
