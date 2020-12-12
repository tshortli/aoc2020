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
        
//        var solver1 = Solver(input: input, waypoint: (0, 1))
//        XCTAssertEqual(solver1.answer(), 25)
//        XCTAssertEqual(solver1.position.0, -8)
//        XCTAssertEqual(solver1.position.1, 17)
        
        var solver2 = Solver(input: input, waypoint: (1, 10))
        XCTAssertEqual(solver2.answer(), 286)
        XCTAssertEqual(solver2.position.0, -72)
        XCTAssertEqual(solver2.position.1, 214)
    }

}
