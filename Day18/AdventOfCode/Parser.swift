//
//  Parser.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public enum Operation: Character {
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
        Parser(precedence: { _ in 1 })
    }
    
    public static func part2PrecedenceSolver() -> Parser {
        Parser(precedence: {
            switch $0 {
            case .addition: return 2
            case .multiplication: return 1
            }
        })
    }
    
    public func sumEvaluations(input: String) -> Int {
        input.components(separatedBy: .newlines).reduce(0) {
            $0 + parse($1).evaluate()
        }
    }
    
    public func evaluate(_ string: String) -> Int {
        parse(string).evaluate()
    }
    
    public func parse(_ string: String) -> Expression {
        var scanner = Scanner(string: string)
        return parse(&scanner)
    }
    
    func parse(_ scanner: inout Scanner) -> Expression {
        var expressions: [Expression] = []
        var operations: [Operation] = []
        
        func reduce(at index: Int) {
            let right = expressions.remove(at: index + 1)
            let left = expressions.remove(at: index)
            let operation = operations.remove(at: index)
            expressions.insert(Expression(left: left, right: right, operation: operation), at: index)
        }
        
        func reduceEither() {
            guard operations.count > 1 else { return }
            guard expressions.count > 2 else { return }
            
            if precedence(operations[0]) < precedence(operations[1]) {
                reduce(at: 1)
            } else {
                reduce(at: 0)
            }
        }
                
        while !scanner.isAtEnd {
            if scanner.scanString("+") != nil {
                operations.append(.addition)
            } else if scanner.scanString("*") != nil {
                operations.append(.multiplication)
            } else if scanner.scanString("(") != nil {
                expressions.append(parse(&scanner))
            } else if scanner.scanString(")") != nil {
                break // End of expression
            } else if let integer = scanner.scanInt() {
                expressions.append(Expression(constant: integer))
            } else {
                fatalError()
            }
            
            reduceEither()
        }
        
        reduce(at: 0)
        
        assert(operations.isEmpty && expressions.count == 1)
        return expressions[0]
    }

}

public class Expression {

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
