//
//  AdapterOrganizerTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class AdapterOrganizerTests: XCTestCase {

    func testExample1() throws {
        let input =
        """
        16
        10
        15
        5
        1
        11
        7
        19
        6
        12
        4
        """
        
        let organizer = AdapterOrganizer(input: input)
        XCTAssertEqual(organizer.differencesDistribution(), [1: 7, 3: 5])
        XCTAssertEqual(organizer.possibleArrangements(), 8)
    }
    
    func testExample2() throws {
        let input =
        """
        28
        33
        18
        42
        31
        14
        46
        20
        48
        47
        24
        23
        49
        45
        19
        38
        39
        11
        1
        32
        25
        35
        8
        17
        7
        9
        4
        2
        34
        10
        3
        """
        
        let organizer = AdapterOrganizer(input: input)
        XCTAssertEqual(organizer.differencesDistribution(), [1: 22, 3: 10])
        XCTAssertEqual(organizer.possibleArrangements(), 19_208)
    }

}
