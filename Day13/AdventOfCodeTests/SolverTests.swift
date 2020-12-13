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
        let input =
        """
        939
        7,13,x,x,59,x,31,19
        """
        
        let solver = Solver(input: input)
        XCTAssertEqual(solver.answer(), 295)
    }

}
