//
//  BoardingPassProcessorTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/4/20.
//

@testable import AdventOfCode
import XCTest

class BoardingPassProcessorTests: XCTestCase {

    func testExamples() {
        let input =
        """
        FBFBBFFRLR
        BFFFBBFRRR
        FFFBBBFRRR
        BBFFBBFRLL
        """
        let processor = BoardingPassProcessor(input: input)
        
        XCTAssertEqual(processor.seat(for: processor.lines[0]), 357)
        XCTAssertEqual(processor.seat(for: processor.lines[1]), 567)
        XCTAssertEqual(processor.seat(for: processor.lines[2]), 119)
        XCTAssertEqual(processor.seat(for: processor.lines[3]), 820)
        
        XCTAssertEqual(processor.highestSeat(), 820)
    }

}
