//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

@testable import AdventOfCode
import XCTest

class SolverTests: XCTestCase {
    
    func testTransformSubjectNumber() throws {
        XCTAssertEqual(Solver.transform(subjectNumber: 7, loopSize: 8), 5_764_801)
        XCTAssertEqual(Solver.transform(subjectNumber: 7, loopSize: 11), 17_807_724)
    }

    func testExample() throws {
        let input =
        """
        5764801
        17807724
        """
        
        let solver = Solver(input: input)
        XCTAssertEqual(solver.deriveEncryptionKey(), 14_897_079)
    }

}
