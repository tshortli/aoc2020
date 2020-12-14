//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    
    enum Instruction {
        case mask(ones: Int64, zeros: Int64)
        case mem(addr: Int64, value: Int64)
    }
    
    let instructions: [Instruction]
    var memory: [Int64: Int64]

    public init(input: String) {
        self.instructions = input.components(separatedBy: .newlines).map { line in
            let components = line.components(separatedBy: " = ")
            if components[0] == "mask" {
                var ones: Int64 = 0, zeros: Int64 = 0
                for (i, char) in components[1].reversed().enumerated() {
                    if char == "1" {
                        ones |= 1 << i
                    } else if char == "0" {
                        zeros |= 1 << i
                    }
                }
                return .mask(ones: ones, zeros: zeros)
            } else if components[0].prefix(4) == "mem[" {
                let scanner = Scanner(string: components[0])
                _ = scanner.scanString("mem[")
                return .mem(addr: scanner.scanInt64()!, value: Int64(components[1])!)
            }
            fatalError()
        }
        
        self.memory = [:]
    }
    
    mutating public func answer() -> Int64 {
        var ones: Int64 = 0
        var zeros: Int64 = 0
        instructions.forEach { instruction in
            switch instruction {
            case let .mask(maskOnes, maskZeros):
                ones = maskOnes
                zeros = maskZeros
            case let .mem(addr, value):
                memory[addr] = (value | ones) & ~zeros
            }

        }
        
        return memory.values.reduce(0) {
            return $0 + $1
        }
    }
    
}
