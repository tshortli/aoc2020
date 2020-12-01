//
//  SolveExpenseReportTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import XCTest

class SolveExpenseReportTests: XCTestCase {

    func testSolve() throws {
        XCTAssertEqual(solveExpenseReport([2, 5, 7, 8], target: 17), 112)
    }

}
