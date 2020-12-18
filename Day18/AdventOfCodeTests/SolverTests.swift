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

        let addition = Expression(left: fortyTwo, right: two, operation: .addition)
        XCTAssertEqual(addition.evaluate(), 44)

        let multiplication = Expression(left: fortyTwo, right: two, operation: .multiplication)
        XCTAssertEqual(multiplication.evaluate(), 84)
    }
    
    func testParserPart1() throws {
        let solver = Solver.part1PrecedenceSolver()
        XCTAssertEqual(solver.parse("42 + 2").evaluate(), 44)
        XCTAssertEqual(solver.parse("42 + 2 * 3").evaluate(), 132)
        XCTAssertEqual(solver.parse("42 + (2 * 3)").evaluate(), 48)
        XCTAssertEqual(solver.parse("42 + ((2 * 3) * 5)").evaluate(), 72)
        XCTAssertEqual(solver.parse("2 * 3 + (4 * 5)").evaluate(), 26)
        XCTAssertEqual(solver.parse("5 + (8 * 3 + 9 + 3 * 4 * 3)").evaluate(), 437)
        XCTAssertEqual(solver.parse("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))").evaluate(), 12_240)
        XCTAssertEqual(solver.parse("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2").evaluate(), 13_632)
    }
    
    func testParserPart2() throws {
        let solver = Solver.part2PrecedenceSolver()
        XCTAssertEqual(solver.parse("42 + 2").evaluate(), 44)
        XCTAssertEqual(solver.parse("42 + 2 * 3").evaluate(), 132)
        XCTAssertEqual(solver.parse("42 + (2 * 3)").evaluate(), 48)
        XCTAssertEqual(solver.parse("42 + ((2 * 3) * 5)").evaluate(), 72)
        XCTAssertEqual(solver.parse("2 * 3 + (4 * 5)").evaluate(), 46)
        XCTAssertEqual(solver.parse("5 + (8 * 3 + 9 + 3 * 4 * 3)").evaluate(), 1445)
        XCTAssertEqual(solver.parse("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))").evaluate(), 669_060)
        XCTAssertEqual(solver.parse("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2").evaluate(), 23_340)
    }

}
