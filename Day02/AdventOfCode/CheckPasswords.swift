//
//  CheckPasswords.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 11/29/20.
//

import Foundation

public func checkPasswords(_ passwords: [String], policy: ParsedPassword.ValidationPolicy) -> Int {
    return passwords.reduce(0) { count, line in
        if ParsedPassword(string: line)?.validate(policy: policy) == true {
            return count + 1
        } else {
            return count
        }
    }
}

public struct ParsedPassword {
    public let numbers: (Int, Int)
    public let character: Character
    public let password: String
    
    public enum ValidationPolicy {
        case count
        case indexed
    }
    
    public init?(string: String) {
        let lineScanner = Scanner(string: string)
        guard let firstNumber = lineScanner.scanInt(representation: .decimal) else {
            return nil
        }
        
        guard lineScanner.scanString("-") != nil else {
            return nil
        }
        
        guard let nextNumber = lineScanner.scanInt(representation: .decimal) else {
            return nil
        }
        
        guard let character = lineScanner.scanCharacter() else {
            return nil
        }
        
        guard lineScanner.scanString(":") != nil else {
            return nil
        }

        guard let password = lineScanner.scanCharacters(from: .alphanumerics) else {
            return nil
        }

        self.numbers = (firstNumber, nextNumber)
        self.character = character
        self.password = password
    }
    
    public func validate(policy: ValidationPolicy) -> Bool {
        switch policy {
        case .count:
            let letterCount = password.reduce(0) { $0 + (($1 == character) ? 1 : 0) }
            return (numbers.0...numbers.1).contains(letterCount)
        case .indexed:
            let char1 = passwordCharacter(at: numbers.0 - 1)
            let char2 = passwordCharacter(at: numbers.1 - 1)
            return (char1 == character) != (char2 == character)
        }
    }
    
    func passwordCharacter(at offset: Int) -> Character {
        return password[password.index(password.startIndex, offsetBy: offset)]
    }
}

