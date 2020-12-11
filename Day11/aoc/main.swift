//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

var simulator1 = SeatSimulator(input: input, style: .adjacent)
simulator1.run()
print("\(simulator1.countOccupiedSeats())")

var simulator2 = SeatSimulator(input: input, style: .visible)
simulator2.run()
print("\(simulator2.countOccupiedSeats())")
