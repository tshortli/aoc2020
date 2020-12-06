//
//  Puzzle.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Puzzle {
    let answers: [String]
    
    public init(input: String) {
        self.answers = input.components(separatedBy: "\n\n")
    }
    
    public func countYesAnswers() -> Int {
        return answers.reduce(0) { count, answer in
            return count + answer.components(separatedBy: .newlines).reduce(into: Set<Character>()) { questions, line in
                line.forEach { questions.insert($0) }
            }.count
        }
    }
    
    public func countOverlappingAnswers() -> Int {
        return answers.reduce(0) { count, answer in
            let questionSets = answer.components(separatedBy: .newlines).map {
                $0.reduce(into: Set<Character>()) { questions, char in
                    questions.insert(char)
                }
            }
            
            let first = questionSets.first!
            let intersection = questionSets.reduce(first) { results, questions in
                return results.intersection(questions)
            }
            return count + intersection.count
        }
    }
}
