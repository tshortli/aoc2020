//
//  main.swift
//  aoc
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import Foundation

let program = Program(input: input)
var computer = Computer(program: program)
_ = computer.run()
print("\(computer.accumulator)")

// Find the corrupt instruction
for i in 0..<program.instructionCount {
    var programCopy = program
    programCopy.swapInstructionOpcode(at: i)
    
    var computer = Computer(program: programCopy)
    if computer.run() == .success {
        print("\(computer.accumulator)")
        break
    }
}
