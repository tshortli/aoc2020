//
//  EncryptionBreakerTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class EncryptionBreakerTests: XCTestCase {

    func testExample() throws {
        let input =
        """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """
        
        let solver = EncryptionBreaker(input: input, preamble: 5)
        XCTAssertEqual(solver.findFirstNonSum(), 127)
        
        XCTAssertEqual(solver.findEncryptionWeakness(), 62)
    }

}
