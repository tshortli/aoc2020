//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let program: [String]
    public var accumulator = 0
    var programCounter = 0
    var executedProgramCounters: Set<Int> = Set()
    
    enum Instruction: String {
        case nop
        case acc
        case jmp
    }
    
    public init(input: String) {
        self.program = input.components(separatedBy: .newlines)
    }
    
    public mutating func run() {
        while programCounter < program.count {
            executedProgramCounters.insert(programCounter)
            execute(program[programCounter])
            
            // Halt if infinite loop detected
            if executedProgramCounters.contains(programCounter) {
                break
            }
        }
    }
    
    mutating func execute(_ string: String) {
        let scanner = Scanner(string: string)
        guard let op = scanner.scanUpToCharacters(from: .whitespacesAndNewlines) else {
            return
        }
        
        guard let instruction = Instruction(rawValue: op) else { fatalError("Invalid op \(op)") }
        guard let sign = scanner.scanCharacters(from: .init(charactersIn: "+-"))  else { fatalError("Invalid op \(op)") }
        guard var value = scanner.scanInt() else { fatalError("Invalid op \(op)") }

        if sign == "-" {
            value = -value
        }
        
        switch instruction {
        case .nop:
            nop()
        case .acc:
            acc(value)
        case .jmp:
            jmp(value)
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
