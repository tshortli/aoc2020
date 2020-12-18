//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    let lines: [String]
    
    public init(input: String) {
        self.lines = input.components(separatedBy: .newlines)
    }
    
    public func answer() -> Int {
        lines.reduce(0) {
            $0 + Expression.parse($1).evaluate()
        }
    }
    
}

public class Expression {
    
    enum Kind {
        case constant(value: Int)
        case binary(left: Expression, right: Expression, operation: (Int, Int) -> Int)
    }
    
    let kind: Kind
    
    public init(constant: Int) {
        self.kind = .constant(value: constant)
    }
    
    public init(left: Expression, right: Expression, operation: @escaping (Int, Int) -> Int) {
        self.kind = .binary(left: left, right: right, operation: operation)
    }
    
    public func evaluate() -> Int {
        switch kind {
        case let .constant(value):
            return value
        case let .binary(left, right, operation):
            return operation(left.evaluate(), right.evaluate())
        }
    }
    
    public static func parse(_ string: String) -> Expression {
        var scanner = Scanner(string: string)
        return _parse(&scanner)
    }
    
    static func _parse(_ scanner: inout Scanner) -> Expression {
        var expressions: [Expression] = []
        var operation: ((Int, Int) -> Int)? = nil
        
        func reduce() {
            guard expressions.count > 1 else { return }
            guard let operation = operation else { fatalError("Missing operator") }
            
            let left = expressions.removeFirst()
            let right = expressions.removeFirst()
            expressions.insert(Expression(left: left, right: right, operation: operation), at: 0)
        }
                
        while !scanner.isAtEnd {
            if scanner.scanString("+") != nil {
                operation = (+)
            } else if scanner.scanString("*") != nil {
                operation = (*)
            } else if scanner.scanString("(") != nil {
                expressions.append(_parse(&scanner))
            } else if scanner.scanString(")") != nil {
                break // End of expression
            } else if let integer = scanner.scanInt() {
                expressions.append(Expression(constant: integer))
            } else {
                fatalError()
            }
            
            reduce()
        }
        
        reduce()
        
        guard let result = expressions.first, expressions.count == 1 else {
            fatalError("Invalid expression")
        }
        
        return result
    }
    
}
