//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let detector = AllergenDetector(input: input)
print("\(detector.countSafeIngredients())")
print("\(detector.canonicalDangerousIngredients())")
