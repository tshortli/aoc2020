//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let navigator = Navigator(input: input)

print("\(navigator.navigate(style: .part1, waypoint: Point(0, 1)).manhattanDistance)")
print("\(navigator.navigate(style: .part2, waypoint: Point(1, 10)).manhattanDistance)")
