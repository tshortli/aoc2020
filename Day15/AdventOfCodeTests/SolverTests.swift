//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

@testable import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func test036() throws {
        XCTAssertEqual(NumberSpeaker(input: "0,3,6").numberSpoken(on: 2020), 436)
        XCTAssertEqual(NumberSpeaker(input: "0,3,6").numberSpoken(on: 30_000_000), 175_594)
    }
    
    func test132() throws {
        XCTAssertEqual(NumberSpeaker(input: "1,3,2").numberSpoken(on: 2020), 1)
        XCTAssertEqual(NumberSpeaker(input: "1,3,2").numberSpoken(on: 30_000_000), 2578)
    }
    
    func test213() throws {
        XCTAssertEqual(NumberSpeaker(input: "2,1,3").numberSpoken(on: 2020), 10)
        XCTAssertEqual(NumberSpeaker(input: "2,1,3").numberSpoken(on: 30_000_000), 3_544_142)
    }
    
    func test123() throws {
        XCTAssertEqual(NumberSpeaker(input: "1,2,3").numberSpoken(on: 2020), 27)
        XCTAssertEqual(NumberSpeaker(input: "1,2,3").numberSpoken(on: 30_000_000), 261_214)
    }

}
