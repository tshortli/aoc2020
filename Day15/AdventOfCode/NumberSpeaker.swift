//
//  NumberSpeaker.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct NumberSpeaker {
    let startingNumbers: [Int]
    
    public init(input: String) {
        self.startingNumbers = input.components(separatedBy: ",").map { Int($0)! }
    }
    
    public func numberSpoken(on turn: Int) -> Int {
        var turnsByNumber: [Int: (last: Int, secondToLast: Int?)] = [:]
        
        for (i, number) in startingNumbers.enumerated() {
            turnsByNumber[number] = (last: i + 1, nil)
        }
        
        var lastNumberSpoken = startingNumbers.last!
        for t in (startingNumbers.count + 1)...turn {
            var numberToSpeak = 0
            if let lastNumberTurns = turnsByNumber[lastNumberSpoken],
               let secondToLastTurn = lastNumberTurns.secondToLast {
                numberToSpeak = lastNumberTurns.last - secondToLastTurn
            }
            
            let nextNumberTurns = turnsByNumber[numberToSpeak]
            turnsByNumber[numberToSpeak] = (last: t, secondToLast: nextNumberTurns?.last)
            lastNumberSpoken = numberToSpeak
        }
        
        return lastNumberSpoken
    }
    
}
