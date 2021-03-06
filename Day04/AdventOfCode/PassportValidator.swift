//
//  PassportValidator.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/3/20.
//

import Foundation

public struct PassportValidator {
    public enum Mode {
        case weak
        case strict
    }
    
    let passports: [String]
    let mode: Mode
    let requiredKeysByValidator: [String: ((String) -> Bool)] = [
        "byr": validBirthYear,
        "iyr": validIssueYear,
        "eyr": validExpirationYear,
        "hgt": validHeight,
        "hcl": validHairColor,
        "ecl": validEyeColor,
        "pid": validPassportID
    ]
        
    public init(input: String, mode: Mode) {
        self.passports = input.components(separatedBy: "\n\n")
        self.mode = mode
    }
    
    public func countValidPassports() -> Int {
        return passports.filter { isValid(passport: $0) }.count
    }
    
    func isValid(passport: String) -> Bool {
        let scanner = Scanner(string: passport)
        var keysAndValues: [String: String] = [:]
        while true {
            guard let key = scanner.scanUpToString(":") else {
                break
            }
            guard scanner.scanString(":") != nil else {
                break
            }
            guard let value = scanner.scanUpToCharacters(from: .whitespacesAndNewlines) else {
                break
            }
            
            keysAndValues[key] = value
        }
        
        let invalidKeys = requiredKeysByValidator.filter { key, validator in
            guard let value = keysAndValues[key] else {
                return true // Missing
            }
            
            switch mode {
            case .weak:
                return false
            case .strict:
                return !validator(value)
            }
        }
        return invalidKeys.isEmpty
    }
}

func validInt(_ string: String, in range: ClosedRange<Int>) -> Bool {
    guard let year = Int(string) else {
        return false
    }
    return range.contains(year)
}

func validBirthYear(_ string: String) -> Bool {
    return validInt(string, in: (1920...2002))
}

func validIssueYear(_ string: String) -> Bool {
    return validInt(string, in: (2010...2020))
}

func validExpirationYear(_ string: String) -> Bool {
    return validInt(string, in: (2020...2030))
}

func validHeight(_ string: String) -> Bool {
    let scanner = Scanner(string: string)
    guard let number = scanner.scanInt() else {
        return false
    }
    guard let unit = scanner.scanCharacters(from: .letters) else {
        return false
    }
    
    if unit == "cm" {
        return (150...193).contains(number)
    } else if unit == "in" {
        return (59...76).contains(number)
    } else {
        return false
    }
}

func validHairColor(_ string: String) -> Bool {
    let scanner = Scanner(string: string)
    guard scanner.scanCharacter() == "#" else {
        return false
    }
    guard let hex = scanner.scanCharacters(from: .alphanumerics) else {
        return false
    }
    return hex.count == 6
}

let eyeColors: Set = [
    "amb", "blu", "brn", "gry", "grn", "hzl", "oth"
]

func validEyeColor(_ string: String) -> Bool {
    return eyeColors.contains(string)
}

func validPassportID(_ string: String) -> Bool {
    let scanner = Scanner(string: string)
    guard let identifier = scanner.scanCharacters(from: .decimalDigits) else {
        return false
    }
    return identifier.count == 9
}
