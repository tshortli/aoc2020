//
//  Program.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/7/20.
//

import Foundation

public struct Program {
    
    var instructions: [Instruction]
    public var instructionCount: Int { instructions.count }
    
    public init(input: String) {
        self.instructions = input.components(separatedBy: .newlines).map { Instruction(string: $0) }
    }
    
    subscript(index: Int) -> Instruction {
        get {
            instructions[index]
        }
        set(newValue) {
            instructions[index] = newValue
        }
    }
    
    // Day 8 program corruption fix
    mutating public func swapInstructionOpcode(at index: Int) {
        let instruction = self[index]
        var newOpcode = instruction.opcode
        
        switch instruction.opcode {
        case .nop: newOpcode = .jmp
        case .jmp: newOpcode = .nop
        default: break
        }
        
        if newOpcode != instruction.opcode {
            self[index] = Instruction(opcode: newOpcode, value: instruction.value)
        }
    }
    
}
