//
//  CheckPasswordsTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import XCTest

class CheckPasswordsTests: XCTestCase {

    func testParsedPassword_Case1() throws {
        let password = try XCTUnwrap(ParsedPassword(string: "1-4 n: nnnnn"))
        XCTAssertEqual(password.numbers.0, 1)
        XCTAssertEqual(password.numbers.1, 4)
        XCTAssertEqual(password.character, "n")
        XCTAssertEqual(password.password, "nnnnn")
        
        XCTAssertFalse(password.validate(policy: .count))
        XCTAssertFalse(password.validate(policy: .indexed))

    }
    
    func testParsedPassword_Case2() throws {
        let password = try XCTUnwrap(ParsedPassword(string: "7-11 m: mmmmmmsmmmmm"))
        XCTAssertEqual(password.numbers.0, 7)
        XCTAssertEqual(password.numbers.1, 11)
        XCTAssertEqual(password.character, "m")
        XCTAssertEqual(password.password, "mmmmmmsmmmmm")
        
        XCTAssert(password.validate(policy: .count))
        XCTAssert(password.validate(policy: .indexed))
    }
    
    func testParsedPassword_Case3() throws {
        let password = try XCTUnwrap(ParsedPassword(string: "5-8 d: ldddtdgnzddddwl"))
        XCTAssertEqual(password.numbers.0, 5)
        XCTAssertEqual(password.numbers.1, 8)
        XCTAssertEqual(password.character, "d")
        XCTAssertEqual(password.password, "ldddtdgnzddddwl")
        
        XCTAssert(password.validate(policy: .count))
        XCTAssertFalse(password.validate(policy: .indexed))
    }
    
    func testParsedPassword_Case4() throws {
        let password = try XCTUnwrap(ParsedPassword(string: "7-19 f: cmshsffhcvdvzlgfbhnf"))
        XCTAssertEqual(password.numbers.0, 7)
        XCTAssertEqual(password.numbers.1, 19)
        XCTAssertEqual(password.character, "f")
        XCTAssertEqual(password.password, "cmshsffhcvdvzlgfbhnf")
        
        XCTAssertFalse(password.validate(policy: .count))
        XCTAssert(password.validate(policy: .indexed))
    }

}
