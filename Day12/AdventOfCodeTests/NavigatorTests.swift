//
//  NavigatorTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class NavigatorTests: XCTestCase {

    func testExample() throws {
        let input =
        """
        F10
        N3
        F7
        R90
        F11
        """
        
        var navigator1 = Navigator(input: input, style: .part1, waypoint: (0, 1))
        XCTAssertEqual(navigator1.answer(), 25)
//        XCTAssertEqual(navigator1.position.0, -8)
//        XCTAssertEqual(navigator1.position.1, 17)
        
        var navigator2 = Navigator(input: input, style: .part2, waypoint: (1, 10))
        XCTAssertEqual(navigator2.answer(), 286)
//        XCTAssertEqual(navigator2.position.0, -72)
//        XCTAssertEqual(navigator2.position.1, 214)
    }

}
