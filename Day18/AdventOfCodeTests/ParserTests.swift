//
//  ParserTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class ParserTests: XCTestCase {

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
        let parser = Parser.part1PrecedenceSolver()
        XCTAssertEqual(parser.evaluate("42 + 2"), 44)
        XCTAssertEqual(parser.evaluate("42 + 2 * 3"), 132)
        XCTAssertEqual(parser.evaluate("42 + (2 * 3)"), 48)
        XCTAssertEqual(parser.evaluate("42 + ((2 * 3) * 5)"), 72)
        XCTAssertEqual(parser.evaluate("2 * 3 + (4 * 5)"), 26)
        XCTAssertEqual(parser.evaluate("5 + (8 * 3 + 9 + 3 * 4 * 3)"), 437)
        XCTAssertEqual(parser.evaluate("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"), 12_240)
        XCTAssertEqual(parser.evaluate("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"), 13_632)
    }
    
    func testParserPart2() throws {
        let parser = Parser.part2PrecedenceSolver()
        XCTAssertEqual(parser.evaluate("42 + 2"), 44)
        XCTAssertEqual(parser.evaluate("42 + 2 * 3"), 132)
        XCTAssertEqual(parser.evaluate("42 + (2 * 3)"), 48)
        XCTAssertEqual(parser.evaluate("42 + ((2 * 3) * 5)"), 72)
        XCTAssertEqual(parser.evaluate("2 * 3 + (4 * 5)"), 46)
        XCTAssertEqual(parser.evaluate("5 + (8 * 3 + 9 + 3 * 4 * 3)"), 1445)
        XCTAssertEqual(parser.evaluate("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"), 669_060)
        XCTAssertEqual(parser.evaluate("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"), 23_340)
    }

}
