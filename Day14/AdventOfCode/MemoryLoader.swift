//
//  MemoryLoader.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct MemoryLoader {
    
    struct Mask {
        let ones: Int64
        let zeros: Int64
        let floating: [Int]
        
        init(string: String) {
            var ones: Int64 = 0, zeros: Int64 = 0
            var floating: [Int] = []
            for (i, char) in string.reversed().enumerated() {
                switch char {
                case "1": ones |= 1 << i
                case "0": zeros |= 1 << i
                case "X": floating.append(i)
                default:
                    fatalError()
                }
            }
            self.ones = ones
            self.zeros = zeros
            self.floating = floating
        }
        
        func apply(to value: Int64) -> Int64 {
            return (value | ones) & ~zeros
        }
        
        func enumerateAddresses(for address: Int64, handler: (Int64) -> Void) {
            Self.enumerateMasks(with: floating, ones: ones, zeros: 0) { ones, zeros in
                handler((address | ones) & ~zeros)
            }
        }
        
        static func enumerateMasks(
            with floatingBits: [Int],
            ones: Int64,
            zeros: Int64,
            handler: (Int64, Int64) -> Void
        ) {
            guard let bit = floatingBits.first else {
                handler(ones, zeros) // Base case
                return
            }
            
            let remainingBits = Array(floatingBits.dropFirst())
            enumerateMasks(with: remainingBits, ones: ones, zeros: (zeros | 1 << bit), handler: handler)
            enumerateMasks(with: remainingBits, ones: (ones | 1 << bit), zeros: zeros, handler: handler)
        }
    }
    
    enum Instruction {
        case mask(_: Mask)
        case mem(addr: Int64, value: Int64)
    }
    
    let instructions: [Instruction]

    public init(input: String) {
        self.instructions = input.components(separatedBy: .newlines).map { line in
            let components = line.components(separatedBy: " = ")
            if components[0] == "mask" {
                return .mask(Mask(string: components[1]))
            } else if components[0].prefix(4) == "mem[" {
                let scanner = Scanner(string: components[0])
                _ = scanner.scanString("mem[")
                return .mem(addr: scanner.scanInt64()!, value: Int64(components[1])!)
            }
            fatalError()
        }
    }
    
    public func memorySumWithValueMasking() -> Int64 {
        var memory: [Int64: Int64] = [:]
        var mask = Mask(string: "")
        
        instructions.forEach { instruction in
            switch instruction {
            case let .mask(instrMask):
                mask = instrMask
            case let .mem(addr, value):
                memory[addr] = mask.apply(to: value)
            }

        }
        
        return memory.values.reduce(0) { $0 + $1 }
    }
    
    public func memorySumWithAddressMasking() -> Int64 {
        var memory: [Int64: Int64] = [:]
        var mask = Mask(string: "")

        instructions.forEach { instruction in
            switch instruction {
            case let .mask(instrMask):
                mask = instrMask
            case let .mem(addr, value):
                mask.enumerateAddresses(for: addr) {
                    memory[$0] = value
                }
            }
        }
        
        return memory.values.reduce(0) { $0 + $1 }
    }
    
}
