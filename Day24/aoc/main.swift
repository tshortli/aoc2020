//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let floor = TileFloor(input: input)
print("\(floor.countStartingBlackTiles())")
print("\(floor.simulateArtExhibit(days: 100))")
