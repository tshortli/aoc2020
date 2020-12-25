//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let publicKeys: [Int]
    
    public init(input: String) {
        self.publicKeys = input.components(separatedBy: .newlines).map { Int($0)! }
    }
    
    public func deriveEncryptionKey() -> Int {
        // Determine the loop size for the first public key.
        let loopSize = Self.loopSize(subjectNumber: 7, publicKey: publicKeys[0])
        
        // Dreive the encryption key by transforming the other public key as the subject number by the loop size.
        return Self.transform(subjectNumber: publicKeys[1], loopSize: loopSize)
    }
    
    /// Returns the loop size necessary to derive the given public key.
    static func loopSize(subjectNumber: Int, publicKey: Int) -> Int {
        var value = 1
        var loopSize = 0
        while value != publicKey {
            value = transformOnce(value, subjectNumber: subjectNumber)
            loopSize += 1
        }
        
        return loopSize
    }
    
    /// Returns the result of transforming an initial value using the given subject number the number of times specified
    /// by loop size.
    static func transform(subjectNumber: Int, initialValue: Int = 1, loopSize: Int = 1) -> Int {
        var value = initialValue
        
        for _ in 1...loopSize {
            value = transformOnce(value, subjectNumber: subjectNumber)
        }
        
        return value
    }
    
    /// Returns the result of transforming an initial value using the given subject number once.
    static func transformOnce(_ value: Int, subjectNumber: Int) -> Int {
        (value * subjectNumber) % 20_201_227
    }
}
