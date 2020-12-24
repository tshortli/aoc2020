//
//  Parser.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

enum Operation: Character {
    case addition = "+"
    case multiplication = "*"
    
    var function: (Int, Int) -> Int {
        switch self {
        case .addition: return (+)
        case .multiplication: return (*)
        }
    }
}

public struct Parser {
    let precedence: (Operation) -> Int

    init(precedence: @escaping (Operation) -> Int) {
        self.precedence = precedence
    }
    
    public static func part1PrecedenceSolver() -> Parser {
        // Equal precedence for all operators.
        Parser(precedence: { _ in 1 })
    }
    
    public static func part2PrecedenceSolver() -> Parser {
        // Addition has a higher precedence than multiplication.
        Parser(precedence: {
            switch $0 {
            case .addition: return 2
            case .multiplication: return 1
            }
        })
    }
    
    /// Evaluates each expression (separated by newlines) and sums the results of evaluation.
    public func sumEvaluations(input: String) -> Int {
        input.components(separatedBy: .newlines).reduce(0) {
            $0 + parse($1).evaluate()
        }
    }
    
    public func evaluate(_ string: String) -> Int {
        parse(string).evaluate()
    }
    
    func parse(_ string: String) -> Expression {
        var scanner = Scanner(string: string)
        return parse(&scanner)
    }
    
    func parse(_ scanner: inout Scanner) -> Expression {
        var state = State(precedence: precedence)
        
        while !scanner.isAtEnd {
            if scanner.scanString("+") != nil {
                state.append(.addition)
            } else if scanner.scanString("*") != nil {
                state.append(.multiplication)
            } else if scanner.scanString("(") != nil {
                state.append(parse(&scanner))
            } else if scanner.scanString(")") != nil {
                break // End of expression
            } else if let integer = scanner.scanInt() {
                state.append(Expression(constant: integer))
            } else {
                fatalError()
            }
            
            state.reduceEither()
        }
        
        // Reduce the last expression
        state.reduce(at: 0)
        return state.expressions[0]
    }
    
    struct State {
        var expressions: [Expression] = []
        var operations: [Operation] = []
        let precedence: (Operation) -> Int
        
        mutating func append(_ operation: Operation) { operations.append(operation) }
        mutating func append(_ expression: Expression) { expressions.append(expression) }
        
        mutating func reduce(at index: Int) {
            guard operations.count > index else { return }
            guard expressions.count > index + 1 else { return }

            let right = expressions.remove(at: index + 1)
            let left = expressions.remove(at: index)
            let operation = operations.remove(at: index)
            expressions.insert(Expression(left: left, right: right, operation: operation), at: index)
        }
        
        mutating func reduceEither() {
            guard operations.count > 1 else { return }
            guard expressions.count > 2 else { return }
            
            if precedence(operations[0]) < precedence(operations[1]) {
                reduce(at: 1)
            } else {
                reduce(at: 0)
            }
        }
    }

}

class Expression {

    enum Kind {
        case constant(value: Int)
        case binary(left: Expression, right: Expression, operation: Operation)
    }
    
    let kind: Kind
    
    public init(constant: Int) {
        self.kind = .constant(value: constant)
    }
    
    public init(left: Expression, right: Expression, operation: Operation) {
        self.kind = .binary(left: left, right: right, operation: operation)
    }
    
    public func evaluate() -> Int {
        switch kind {
        case let .constant(value):
            return value
        case let .binary(left, right, operation):
            return operation.function(left.evaluate(), right.evaluate())
        }
    }
    
}
