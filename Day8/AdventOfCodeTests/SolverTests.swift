//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func testExample() throws {
        let input =
        """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        
        var solver = Solver(input: input)
        solver.run()
        XCTAssertEqual(solver.accumulator, 5)
        
        var mutatedSolver = Solver(input: input)
        mutatedSolver.programCounterToMutate = 7
        
        mutatedSolver.run()
        XCTAssertFalse(mutatedSolver.infiniteLoopDetected)
        XCTAssertEqual(mutatedSolver.accumulator, 8)
    }
}
