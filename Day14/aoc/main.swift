//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let loader = MemoryLoader(input: input)
print("\(loader.memorySumWithValueMasking())")
print("\(loader.memorySumWithAddressMasking())")