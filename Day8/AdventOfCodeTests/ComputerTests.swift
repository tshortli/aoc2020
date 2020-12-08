//
//  ComputerTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class ComputerTests: XCTestCase {

    func testPart1() throws {
        let program = Program(input: day8Input())
        var computer = Computer(program: program)
        computer.run()
        
        XCTAssert(computer.infiniteLoopDetected)
        XCTAssertEqual(computer.accumulator, 5)
    }
    
    func testPart2() throws {
        var program = Program(input: day8Input())
        program.swapInstructionOpcode(at: 7)
        
        var computer = Computer(program: program)
        computer.run()
        
        XCTAssertFalse(computer.infiniteLoopDetected)
        XCTAssertEqual(computer.accumulator, 8)
    }
    
    func day8Input() -> String {
        return
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
    }
}
