//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func testExample() throws {
        let solver = Solver(input: "389125467")
        XCTAssertEqual(solver.move(10), "92658374")
        XCTAssertEqual(solver.move(100), "67384529")
    }

}
