//
//  Computer.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Computer {
    
    public let program: Program
    public private(set) var accumulator = 0
    public private(set) var infiniteLoopDetected = false

    var programCounter = 0
    var executedProgramCounters: Set<Int> = Set()
    
    public init(program: Program) {
        self.program = program
    }
    
    public mutating func run() {
        while programCounter < program.instructionCount && !infiniteLoopDetected {
            let instruction = program[programCounter]
            executedProgramCounters.insert(programCounter)

            execute(instruction)
            
            if executedProgramCounters.contains(programCounter) {
                infiniteLoopDetected = true
            }
        }
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
