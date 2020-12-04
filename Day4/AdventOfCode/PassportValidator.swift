//
//  PassportValidator.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/3/20.
//

import Foundation

public struct PassportValidator {
    
    let lines: [String]
    let requiredKeys: [String] = [
        "byr",
        "iyr",
        "eyr",
        "hgt",
        "hcl",
        "ecl",
        "pid"
    ]
    
    public init(input: String) {
        self.lines = input.components(separatedBy: "\n\n")
    }
    
    public func countValidPassports() -> Int {
        return lines.filter { isValid(passport: $0) }.count
    }
    
    func isValid(passport: String) -> Bool {
        let scanner = Scanner(string: passport)
        var keys: Set<String> = Set()
        while true {
            guard let key = scanner.scanUpToString(":") else {
                break
            }
            
            guard scanner.scanUpToCharacters(from: .whitespacesAndNewlines) != nil else {
                break
            }
            
            keys.insert(key)
        }
        
        let missingKeys = requiredKeys.filter { !keys.contains($0) }
        return missingKeys.isEmpty
    }
}
