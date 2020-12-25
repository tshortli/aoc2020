//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let input =
"""
1614360
7734663
"""

let startDate = Date()
let cracker = RFIDCracker(input: input)
print("\(cracker.deriveEncryptionKey())")

print("Finished in \(Int(Date().timeIntervalSince(startDate) * 1000)) ms")
