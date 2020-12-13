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
        
        let navigator1 = Navigator(input: input, waypoint: Point(0, 1))
        let answer1 = navigator1.navigate(style: .part1)
        XCTAssertEqual(answer1.manhattanDistance, 25)
        XCTAssertEqual(answer1.north, -8)
        XCTAssertEqual(answer1.east, 17)
        
        let answer2 = navigator1.navigate(style: .part2)
        XCTAssertEqual(answer2.manhattanDistance, 286)
        XCTAssertEqual(answer2.north, -72)
        XCTAssertEqual(answer2.east, 214)
    }

}
