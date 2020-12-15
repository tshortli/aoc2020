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
        let solver = Solver(input: "0,3,6")
        XCTAssertEqual(solver.answer(index: 2020), 436)
    }

}
