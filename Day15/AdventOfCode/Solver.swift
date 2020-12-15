//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let startingNumbers: [Int]
    
    public init(input: String) {
        self.startingNumbers = input.components(separatedBy: ",").map { Int($0)! }
    }
    
    public func answer(index: Int) -> Int {
        var numbers = startingNumbers
        var turnsByNumber: [Int: [Int]] = [:]
        
        for (i, number) in numbers.enumerated() {
            turnsByNumber[number] = [i + 1]
        }
        
        for turn in (numbers.count + 1)...index {
            let lastNumber = numbers.last!
            let lastNumberTurns = turnsByNumber[lastNumber, default: []]
            var nextNumber = 0
            if lastNumberTurns.count > 1 {
                nextNumber = lastNumberTurns[0] - lastNumberTurns[1]
            }
            
//            print("\(nextNumber)")
            turnsByNumber[nextNumber] = [turn] + turnsByNumber[nextNumber, default: []]
            numbers.append(nextNumber)
        }
        
        return numbers[index - 1]
    }
    
}
