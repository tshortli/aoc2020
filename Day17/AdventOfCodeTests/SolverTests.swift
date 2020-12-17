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
        .#.
        ..#
        ###
        """
        
        let solver = Solver(input: input)
        XCTAssertEqual(solver.activeCubesAfterSimulation(), 112)
    }

}
