//
//  SeatSimulatorTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class SeatSimulatorTests: XCTestCase {

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
        var simulator1 = SeatSimulator(input: input, style: .adjacent)
        XCTAssertEqual(simulator1.countOccupiedSeats(), 0)
        simulator1.step()
        XCTAssertEqual(simulator1.countOccupiedSeats(), 71)
        XCTAssertEqual(simulator1.countOccupiedSeats(for: 9), 3)
        simulator1.step()
        XCTAssertEqual(simulator1.countOccupiedSeats(), 20)

        simulator1.run()
        XCTAssertEqual(simulator1.countOccupiedSeats(), 37)
        
        // Part 2
        var simulator2 = SeatSimulator(input: input, style: .visible)
        XCTAssertEqual(simulator2.countOccupiedSeats(), 0)
        simulator2.step()
        XCTAssertEqual(simulator2.countOccupiedSeats(), 71)
        simulator2.step()
        XCTAssertEqual(simulator2.countOccupiedSeats(), 7)
        simulator2.step()
        XCTAssertEqual(simulator2.countOccupiedSeats(), 53)

        simulator2.run()
        XCTAssertEqual(simulator2.countOccupiedSeats(), 26)
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
        
        let simulator = SeatSimulator(input: input, style: .visible)
        XCTAssertEqual(simulator.countOccupiedSeats(for: 9 * 4 + 3), 8)
    }
    
}
