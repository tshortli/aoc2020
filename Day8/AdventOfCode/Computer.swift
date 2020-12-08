//
//  Computer.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Computer {
    
    public enum Result {
        case success
        case infiniteLoop
    }
    
    public let program: Program
    public private(set) var accumulator = 0

    var programCounter = 0
    var executedProgramCounters = IndexSet()
    
    public init(program: Program) {
        self.program = program
    }
    
    public mutating func run() -> Result {
        while programCounter < program.instructionCount {
            if executedProgramCounters.contains(programCounter) {
                return .infiniteLoop
            }
            
            executedProgramCounters.insert(programCounter)
            execute(program[programCounter])
        }
        
        return .success
    }
    
    mutating func execute(_ instruction: Instruction) {
        switch instruction.opcode {
        case .nop:  nop()
        case .acc:  acc(instruction.value)
        case .jmp:  jmp(instruction.value)
        }
    }
    
    mutating func nop() {
        programCounter += 1
    }
    
    mutating func acc(_ value: Int) {
        accumulator += value
        programCounter += 1
    }
    
    mutating func jmp(_ value: Int) {
        programCounter += value
    }
    
}
