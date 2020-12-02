//
//  CheckPasswords.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 11/29/20.
//

import Foundation

public func checkPasswords(_ passwords: [String]) -> Int {
    var validCount = 0
    
    for line in passwords {
        let lineScanner = Scanner(string: line)
        guard let minCount = lineScanner.scanInt(representation: .decimal) else {
            continue // Invalid format
        }
        
        guard lineScanner.scanString("-") != nil else {
            continue // Invalid format
        }
        
        guard let maxCount = lineScanner.scanInt(representation: .decimal) else {
            continue // Invalid format
        }
        
        guard let letter = lineScanner.scanCharacter() else {
            continue // Invalid format
        }
        
        guard lineScanner.scanString(":") != nil else {
            continue // Invalid format
        }

        guard let password = lineScanner.scanCharacters(from: .alphanumerics) else {
            continue // Invalid format
        }
        
        let letterCount = password.reduce(0) { $0 + (($1 == letter) ? 1 : 0) }
        if letterCount >= minCount && letterCount <= maxCount {
            validCount += 1
        }
    }
    
    return validCount
}
