//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let validator = PassportValidator(input: input)
let count = validator.countValidPassports()
print("\(count)")
