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
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
        """
        
        var solver = Solver(input: input)
        XCTAssertEqual(solver.countOccupiedSeats(), 0)
        solver.simulate()
        XCTAssertEqual(solver.countOccupiedSeats(), 71)
        XCTAssertEqual(solver.countAdjacentOccupiedSeats(at: 9), 3)
        
        solver.simulateUntilStable()
        XCTAssertEqual(solver.countOccupiedSeats(), 37)
    }

}
