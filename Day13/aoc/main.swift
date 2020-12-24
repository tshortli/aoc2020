//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let startDate = Date()
let scheduler = BusScheduler(input: input)

print("\(scheduler.earliestBusIDTimesDelay())")
print("\(scheduler.earliestSynchronizedDeparture())")

print("Finished in \(Int(Date().timeIntervalSince(startDate) * 1000)) ms")
