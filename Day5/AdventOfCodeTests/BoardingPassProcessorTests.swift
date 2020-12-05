//
//  BoardingPassProcessorTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/4/20.
//

import AdventOfCode
import XCTest

class BoardingPassProcessorTests: XCTestCase {

    func testExamples() {
        let processor = BoardingPassProcessor(input: "")
        XCTAssertEqual(processor.seatID(for: "FBFBBFFRLR"), 357)
        XCTAssertEqual(processor.seatID(for: "BFFFBBFRRR"), 567)
        XCTAssertEqual(processor.seatID(for: "FFFBBBFRRR"), 119)
        XCTAssertEqual(processor.seatID(for: "BBFFBBFRLL"), 820)
    }

}
