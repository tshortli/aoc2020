//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let router = TobogganRouter(input: input)
let treeCount = router.countTrees(vector: (3, 1))
print("\(input)")
print("\(treeCount)")
