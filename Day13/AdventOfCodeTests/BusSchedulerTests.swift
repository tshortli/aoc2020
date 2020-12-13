//
//  BusSchedulerTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class BusSchedulerTests: XCTestCase {

    func testPart1() throws {
        XCTAssertEqual(BusScheduler(input: "939\n7,13,x,x,59,x,31,19").earliestBusIDTimesDelay(), 295)
    }

    func testPart2() throws {
        XCTAssertEqual(BusScheduler(input: "939\n7,13,x,x,59,x,31,19").earliestSynchronizedDeparture(), 1_068_781)
        XCTAssertEqual(BusScheduler(input: "0\n17,x,13,19").earliestSynchronizedDeparture(), 3417)
        XCTAssertEqual(BusScheduler(input: "0\n67,7,59,61").earliestSynchronizedDeparture(), 754_018)
        XCTAssertEqual(BusScheduler(input: "0\n67,x,7,59,61").earliestSynchronizedDeparture(), 779_210)
        XCTAssertEqual(BusScheduler(input: "0\n67,7,x,59,61").earliestSynchronizedDeparture(), 1_261_476)
        XCTAssertEqual(BusScheduler(input: "0\n1789,37,47,1889").earliestSynchronizedDeparture(), 1_202_161_486)
    }
    
}
