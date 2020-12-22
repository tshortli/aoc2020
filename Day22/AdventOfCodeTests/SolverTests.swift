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
        Player 1:
        9
        2
        6
        3
        1

        Player 2:
        5
        8
        4
        7
        10
        """
        
        let solver = Solver(input: input)
        XCTAssertEqual(solver.playCombat(), 306)
        XCTAssertEqual(solver.playRecursiveCombat(), 291)
    }
    
    func testRecursiveLoopPrevention() throws {
        let input =
        """
        Player 1:
        43
        19

        Player 2:
        2
        29
        14
        """
        
        let solver = Solver(input: input)
        XCTAssertEqual(solver.playRecursiveCombat(), 105)
    }

}
