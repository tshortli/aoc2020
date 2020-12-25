//
//  RFIDCrackerTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

@testable import AdventOfCode
import XCTest

class RFIDCrackerTests: XCTestCase {
    
    func testTransformSubjectNumber() throws {
        XCTAssertEqual(RFIDCracker.transform(subjectNumber: 7, loopSize: 8), 5_764_801)
        XCTAssertEqual(RFIDCracker.transform(subjectNumber: 7, loopSize: 11), 17_807_724)
    }

    func testExample() throws {
        let input =
        """
        5764801
        17807724
        """
        
        let cracker = RFIDCracker(input: input)
        XCTAssertEqual(cracker.deriveEncryptionKey(), 14_897_079)
    }

}
