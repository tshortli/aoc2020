//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let startDate = Date()
let speaker = NumberSpeaker(input: input)

print("\(speaker.numberSpoken(on: 2020))")
print("\(speaker.numberSpoken(on: 30_000_000))")

print("Finished in \(Int(Date().timeIntervalSince(startDate) * 1000)) ms")
