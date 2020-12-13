//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

var navigator1 = Navigator(input: input, style: .part1, waypoint: (0, 1))
print("\(navigator1.answer())")

var navigator2 = Navigator(input: input, style: .part2, waypoint: (1, 10))
print("\(navigator2.answer())")
