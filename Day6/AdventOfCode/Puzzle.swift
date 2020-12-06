//
//  Puzzle.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Puzzle {
    let groups: [String]
    
    public init(input: String) {
        self.groups = input.components(separatedBy: "\n\n")
    }
    
    public func uniqueAnswersSum() -> Int {
        return reduceAnswers(0) { sum, groupAnswers in
            sum + groupAnswers.reduce(Set()) { $0.union($1) }.count
        }
    }
    
    public func intersectingAnswersSum() -> Int {
        return reduceAnswers(0) { sum, groupAnswers in
            sum + groupAnswers.dropFirst().reduce(groupAnswers.first ?? Set()) { $0.intersection($1) }.count
        }
    }

    public func reduceAnswers(_ initial: Int, _ nextPartial: (Int, [Set<Character>]) -> Int) -> Int {
        return groups.lazy.map { group in
            return group.components(separatedBy: .newlines).map { answerLine in
                answerLine.reduce(into: Set()) { $0.insert($1) }
            }
        }.reduce(initial, nextPartial)
    }
}
