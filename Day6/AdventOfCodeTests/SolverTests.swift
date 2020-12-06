//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func testPart1_Example1() throws {
        let puzzle = Puzzle(input: exampleInput1())
        XCTAssertEqual(puzzle.uniqueAnswersSum(), 6)
    }
    
    func testPart1_Example2() throws {
        let puzzle = Puzzle(input: exampleInput2())
        XCTAssertEqual(puzzle.uniqueAnswersSum(), 11)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: exampleInput2())
        XCTAssertEqual(puzzle.intersectingAnswersSum(), 6)
    }
    
    func exampleInput1() -> String {
        return
            """
            abcx
            abcy
            abcz
            """
    }
    
    func exampleInput2() -> String {
        return
            """
            abc

            a
            b
            c

            ab
            ac

            a
            a
            a
            a

            b
            """
    }
}
