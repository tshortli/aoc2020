//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func testTicketScanningErrorRate() throws {
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

    func testDepartureProduct() throws {
        let input =
        """
        departure location: 1-2 or 3-5
        departure station: 5-6 or 7-9
        departure platform: 9-10 or 11-13
        departure track: 13-14 or 15-17
        departure date: 17-18 or 19-21
        departure time: 21-22 or 23-25
        arrival location: 25-26 or 27-29
        class: 29-30 or 31-33

        your ticket:
        29,1,5,9,25,13,17,21

        nearby tickets:
        30,2,6,10,26,14,18,22
        100,2,6,10,26,14,18,22
        """

        let solver = Solver(input: input)
        
        XCTAssertEqual(solver.validNearbyTickets(), [
            [30, 2, 6, 10, 26, 14, 18, 22]
        ])
        
        XCTAssertEqual(solver.orderedRuleLabels(), [
            "class",
            "departure location",
            "departure station",
            "departure platform",
            "arrival location",
            "departure track",
            "departure date",
            "departure time"
        ])

        XCTAssertEqual(solver.departureProduct(), 1 * 5 * 9 * 13 * 17 * 21)
    }
}
