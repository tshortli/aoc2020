//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let game = CardGame(input: input)
print("\(game.playCombat())")
print("\(game.playRecursiveCombat())")
