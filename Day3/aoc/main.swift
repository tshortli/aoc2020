//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let router = TobogganRouter(input: input)

let vectors = [
    (1, 1),
    (3, 1),
    (5, 1),
    (7, 1),
    (1, 2)
]

let treeCounts = vectors.map { router.countTrees(vector: .init(x: $0.0, y: $0.1)) }
let product = treeCounts.reduce(1, *)
print("\(product)")
