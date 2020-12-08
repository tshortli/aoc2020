//
//  Instruction.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/7/20.
//

import Foundation

public struct Instruction {
    
    public enum Opcode: String {
        case nop
        case acc
        case jmp
    }
    
    var opcode: Opcode
    let value: Int
    
    public init(string: String) {
        let scanner = Scanner(string: string)
        guard let op = scanner.scanUpToCharacters(from: .whitespacesAndNewlines),
              let opcode = Instruction.Opcode(rawValue: op),
              let value = scanner.scanInt() else {
            fatalError("Invalid instruction \(string)")
        }
        
        self.opcode = opcode
        self.value = value
    }

    public init(opcode: Opcode, value: Int) {
        self.opcode = opcode
        self.value = value
    }
}
