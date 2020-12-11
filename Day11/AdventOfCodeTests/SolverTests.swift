//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func testMainExample() throws {
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
        
        // Part 1
        var solver1 = Solver(input: input, style: .adjacent)
        XCTAssertEqual(solver1.countOccupiedSeats(), 0)
        solver1.simulate()
        XCTAssertEqual(solver1.countOccupiedSeats(), 71)
        XCTAssertEqual(solver1.countOccupiedSeats(for: 9), 3)
        solver1.simulate()
        XCTAssertEqual(solver1.countOccupiedSeats(), 20)

        solver1.simulateUntilStable()
        XCTAssertEqual(solver1.countOccupiedSeats(), 37)
        
        // Part 2
        var solver2 = Solver(input: input, style: .visible)
        XCTAssertEqual(solver2.countOccupiedSeats(), 0)
        solver2.simulate()
        XCTAssertEqual(solver2.countOccupiedSeats(), 71)
        solver2.simulate()
        XCTAssertEqual(solver2.countOccupiedSeats(), 7)
        solver2.simulate()
        XCTAssertEqual(solver2.countOccupiedSeats(), 53)

        solver2.simulateUntilStable()
        XCTAssertEqual(solver2.countOccupiedSeats(), 26)
    }

    func testCountVisibleOccupiedSeats() throws {
        let input =
        """
        .......#.
        ...#.....
        .#.......
        .........
        ..#L....#
        ....#....
        .........
        #........
        ...#.....
        """
        
        let solver = Solver(input: input, style: .visible)
        XCTAssertEqual(solver.countOccupiedSeats(for: 9 * 4 + 3), 8)

    }
}
