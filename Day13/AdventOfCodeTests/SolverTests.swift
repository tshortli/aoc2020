//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func testPart1() throws {
        let solver = Solver(input: "939\n7,13,x,x,59,x,31,19")
        XCTAssertEqual(solver.answerPart1(), 295)
    }

    func testPart2() throws {
        XCTAssertEqual(Solver(input: "939\n7,13,x,x,59,x,31,19").answerPart2(), 1_068_781)
        XCTAssertEqual(Solver(input: "0\n17,x,13,19").answerPart2(), 3417)
        XCTAssertEqual(Solver(input: "0\n67,7,59,61").answerPart2(), 754_018)
        XCTAssertEqual(Solver(input: "0\n67,x,7,59,61").answerPart2(), 779_210)
        XCTAssertEqual(Solver(input: "0\n67,7,x,59,61").answerPart2(), 1_261_476)
        XCTAssertEqual(Solver(input: "0\n1789,37,47,1889").answerPart2(), 1_202_161_486)
    }
    
}
