//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let startDate = Date()
let loader = MemoryLoader(input: input)
print("\(loader.memorySumWithValueMasking())")
print("\(loader.memorySumWithAddressMasking())")

print("Finished in \(Int(Date().timeIntervalSince(startDate) * 1000)) ms")
