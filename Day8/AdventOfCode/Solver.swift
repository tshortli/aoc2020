//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    public let program: [String]
    public var programCounterToMutate: Int? = nil
    public var accumulator = 0
    var programCounter = 0
    var executedProgramCounters: Set<Int> = Set()
    public var infiniteLoopDetected = false
    
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
            executeNextInstruction()
            
            // Halt if infinite loop detected
            if executedProgramCounters.contains(programCounter) {
                infiniteLoopDetected = true
                break
            }
        }
    }
    
    mutating func executeNextInstruction() {
        let rawInstruction = program[programCounter]
        executedProgramCounters.insert(programCounter)

        let scanner = Scanner(string: rawInstruction)
        guard let op = scanner.scanUpToCharacters(from: .whitespacesAndNewlines) else {
            return
        }
        
        guard var instruction = Instruction(rawValue: op) else { fatalError("Invalid op \(op)") }
        guard let sign = scanner.scanCharacters(from: .init(charactersIn: "+-"))  else { fatalError("Invalid op \(op)") }
        let multiplier = (sign == "-") ? -1 : 1
        guard var value = scanner.scanInt() else { fatalError("Invalid op \(op)") }

        value = multiplier * value
        
        if programCounter == programCounterToMutate {
            switch instruction {
            case .nop: instruction = .jmp
            case .acc: break
            case .jmp: instruction = .nop
            }
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
