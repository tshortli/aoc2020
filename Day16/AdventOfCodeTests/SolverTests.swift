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
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
        """
        
        let solver = Solver(input: input)
        XCTAssertEqual(solver.rules.count, 3)
        XCTAssertEqual(solver.myTicket, [7, 1, 14])
        XCTAssertEqual(solver.nearbyTickets.count, 4)

        XCTAssertEqual(solver.ticketScanningErrorRate(), 71)
    }

}
