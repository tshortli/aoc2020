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
        F10
        N3
        F7
        R90
        F11
        """
        
        var solver = Solver(input: input)
        XCTAssertEqual(solver.answer(), 25)
        XCTAssertEqual(solver.position.0, -8)
        XCTAssertEqual(solver.position.1, 17)
    }

}
