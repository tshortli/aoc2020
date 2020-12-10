//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let processor = BoardingPassProcessor(input: input)
if let answer = processor.highestSeat() {
    print("\(answer)")
}

if let missingSeat = processor.missingSeat() {
    print("\(missingSeat)")
}
