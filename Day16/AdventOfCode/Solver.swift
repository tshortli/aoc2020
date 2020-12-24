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
    
    struct Rule {
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
        
        func validFields(for ticket: [Int]) -> [Int] {
            return ticket.filter { contains($0) }
        }
        
        func contains(_ value: Int) -> Bool {
            return ranges.first(where: { $0.contains(value) }) != nil
        }
    }
    
    let rules: [Rule]
    let myTicket: [Int]
    let nearbyTickets: [[Int]]
    
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
    
    func validNearbyTickets() -> [[Int]] {
        return nearbyTickets.filter { ticket in
            return ticket.allSatisfy { value in
                rules.first(where: { $0.contains(value) }) != nil
            }
        }
    }
    
    func orderedRuleLabels() -> [String] {
        let allPossibleRuleLabels = Set(rules.map { $0.label })
        var possibleRuleLabelsByIndex: [Set<String>] = []
        let tickets = validNearbyTickets()
        
        for i in 0..<myTicket.count {
            var possibleRuleLabels = allPossibleRuleLabels
            
            for ticket in tickets {
                let possibleRules = rules.filter { $0.contains(ticket[i]) }
                possibleRuleLabels = possibleRuleLabels.intersection(possibleRules.map { $0.label })
            }
            
            possibleRuleLabelsByIndex.append(possibleRuleLabels)
        }
        
        var verifiedRuleLabels = Set<String>()
        for possibleRuleLabels in possibleRuleLabelsByIndex where possibleRuleLabels.count == 1 {
            verifiedRuleLabels.insert(possibleRuleLabels.first!)
        }
        
        while verifiedRuleLabels != allPossibleRuleLabels {
            for i in 0..<possibleRuleLabelsByIndex.count {
                var possibleRuleLabels = possibleRuleLabelsByIndex[i]
                guard possibleRuleLabels.count > 1, !verifiedRuleLabels.isEmpty else {
                    continue
                }
                
                verifiedRuleLabels.forEach { possibleRuleLabels.remove($0) }
                assert(!possibleRuleLabels.isEmpty)

                if possibleRuleLabels.count == 1 {
                    verifiedRuleLabels.insert(possibleRuleLabels.first!)
                }
                
                possibleRuleLabelsByIndex[i] = possibleRuleLabels
            }
        }

        return possibleRuleLabelsByIndex.map { $0.first! }
    }
    
    public func departureProduct() -> Int {
        var product = 1
        for (i, label) in orderedRuleLabels().enumerated() where label.starts(with: "departure") {
            product *= myTicket[i]
        }
        return product
    }
    
}
