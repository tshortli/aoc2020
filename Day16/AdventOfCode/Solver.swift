//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

func makeClosedRange(from scanner: Scanner) -> ClosedRange<Int> {
    let a = scanner.scanInt()!
    _ = scanner.scanString("-")
    let b = scanner.scanInt()!
    return a...b
}

public struct Solver {
    public struct Rule {
        let label: String
        let ranges: [ClosedRange<Int>]
        
        public init(from string: String) {
            let scanner = Scanner(string: string)
            self.label = scanner.scanUpToString(":")!
            _ = scanner.scanCharacter()
            var ranges: [ClosedRange<Int>] = []
            ranges.append(makeClosedRange(from: scanner))
            _ = scanner.scanString("or")
            ranges.append(makeClosedRange(from: scanner))
            self.ranges = ranges
        }
        
        public func validFields(for ticket: [Int]) -> [Int] {
            return ticket.filter { field in
                !ranges.filter { $0.contains(field) }.isEmpty
            }
        }
    }
    
    public let rules: [Rule]
    public let myTicket: [Int]
    public let nearbyTickets: [[Int]]
    
    public init(input: String) {
        var rules: [Rule] = []
        var myTicket: [Int] = []
        var nearbyTickets: [[Int]] = [[]]
        
        input.components(separatedBy: "\n\n").forEach { group in
            let lines = group.components(separatedBy: .newlines)
            
            switch lines.first {
            case "your ticket:":
                myTicket = lines.dropFirst().first?.components(separatedBy: ",").compactMap { Int($0) } ?? []
            case "nearby tickets:":
                nearbyTickets = lines.dropFirst().map { line in
                    return line.components(separatedBy: ",").compactMap { Int($0) }
                }
            default:
                rules = lines.map { Rule(from: $0) }
            }
        }
        
        self.myTicket = myTicket
        self.nearbyTickets = nearbyTickets
        self.rules = rules
    }
    
    public func ticketScanningErrorRate() -> Int {
        return nearbyTickets.reduce(0) { sum, ticket in
            // Remove ticket fields that have
            var invalidFields = Set<Int>(ticket)
            rules.forEach { rule in
                rule.validFields(for: ticket).forEach { invalidFields.remove($0) }
            }
            return sum + invalidFields.reduce(0, +)
        }
    }
    
}
