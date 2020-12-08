//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

var solver = Solver(input: input)
solver.run()
print("\(solver.accumulator)")

for i in 0..<solver.program.count {
    var mutatedSolver = Solver(input: input)
    mutatedSolver.programCounterToMutate = i
    
    mutatedSolver.run()
    if !mutatedSolver.infiniteLoopDetected {
        print("\(mutatedSolver.accumulator)")
        break
    }
}
