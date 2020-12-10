//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let organizer = AdapterOrganizer(input: input)

let answer = organizer.differencesDistribution()
print("\(answer)")
print("\(answer[1]! * answer[3]!)")

let possibleArrangements = organizer.possibleArrangements()
print("\(possibleArrangements)")
