//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func testExpressionEvaluate() throws {
        let fortyTwo = Expression(constant: 42)
        XCTAssertEqual(fortyTwo.evaluate(), 42)
        
        let two = Expression(constant: 2)
        XCTAssertEqual(two.evaluate(), 2)

        let addition = Expression(left: fortyTwo, right: two, operation: +)
        XCTAssertEqual(addition.evaluate(), 44)

        let multiplication = Expression(left: fortyTwo, right: two, operation: *)
        XCTAssertEqual(multiplication.evaluate(), 84)
    }
    
    func testExpressionParse() throws {
        XCTAssertEqual(Expression.parse("42 + 2").evaluate(), 44)
        XCTAssertEqual(Expression.parse("42 + 2 * 3").evaluate(), 132)
        XCTAssertEqual(Expression.parse("42 + (2 * 3)").evaluate(), 48)
        XCTAssertEqual(Expression.parse("42 + ((2 * 3) * 5)").evaluate(), 72)
        XCTAssertEqual(Expression.parse("2 * 3 + (4 * 5)").evaluate(), 26)
        XCTAssertEqual(Expression.parse("5 + (8 * 3 + 9 + 3 * 4 * 3)").evaluate(), 437)
        XCTAssertEqual(Expression.parse("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))").evaluate(), 12_240)
        XCTAssertEqual(Expression.parse("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2").evaluate(), 13_632)
    }

}
