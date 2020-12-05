//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let processor = BoardingPassProcessor(input: input)
if let answer = processor.highestSeatID() {
    print("\(answer)")
}

if let missingSeat = processor.missingSeatID() {
    print("\(missingSeat)")
}
