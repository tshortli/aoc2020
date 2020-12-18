//
//  Solver.swift
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

public struct Solver {
    let precedence: [Operation: Int]

    init(precedence: [Operation: Int]) {
        self.precedence = precedence
    }
    
    public static func part1PrecedenceSolver() -> Solver {
        return Solver(precedence: [.addition: 1, .multiplication: 1])
    }
    
    public static func part2PrecedenceSolver() -> Solver {
        return Solver(precedence: [.addition: 2, .multiplication: 1])
    }
    
    public func answer(input: String) -> Int {
        input.components(separatedBy: .newlines).reduce(0) {
            $0 + parse($1).evaluate()
        }
    }
    
    public func parse(_ string: String) -> Expression {
        var scanner = Scanner(string: string)
        return _parse(&scanner)
    }
    
    func _parse(_ scanner: inout Scanner) -> Expression {
        var expressions: [Expression] = []
        var operations: [Operation] = []
        
        func reduce() {
            guard operations.count > 1 else { return }
            guard expressions.count > 2 else { return }

            let leftPrecedence = precedence[operations[0], default: 0]
            let rightPrecedence = precedence[operations[1], default: 0]
            
            if rightPrecedence > leftPrecedence {
                let right = expressions.remove(at: 2)
                let left = expressions.remove(at: 1)
                expressions.insert(Expression(left: left, right: right, operation: operations.remove(at: 1)), at: 1)
            } else {
                let right = expressions.remove(at: 1)
                let left = expressions.remove(at: 0)
                expressions.insert(Expression(left: left, right: right, operation: operations.remove(at: 0)), at: 0)
            }
        }
                
        while !scanner.isAtEnd {
            if scanner.scanString("+") != nil {
                operations.append(.addition)
            } else if scanner.scanString("*") != nil {
                operations.append(.multiplication)
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
        
        assert(operations.count == 1)
        assert(expressions.count == 2)
        
        return Expression(left: expressions[0], right: expressions[1], operation: operations[0])
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
