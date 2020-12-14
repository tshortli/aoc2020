//
//  MemoryLoaderTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class MemoryLoaderTests: XCTestCase {

    func testMemorySumWithValueMasking() throws {
        let input =
        """
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[8] = 0
        """
        
        let loader = MemoryLoader(input: input)
        XCTAssertEqual(loader.memorySumWithValueMasking(), 165)
    }

    func testMemorySumWithAddressMasking() throws {
        let input =
        """
        mask = 000000000000000000000000000000X1001X
        mem[42] = 100
        mask = 00000000000000000000000000000000X0XX
        mem[26] = 1
        """
        
        let loader = MemoryLoader(input: input)
        XCTAssertEqual(loader.memorySumWithAddressMasking(), 208)
    }
    
    func testMaskEnumerateAddresses() throws {
        let mask = MemoryLoader.Mask(string: "000000000000000000000000000000X1001X")
        XCTAssertEqual(Set(addresses(from: mask, for: 42)), Set([26, 27, 58, 59]))
    }
    
    func addresses(from mask: MemoryLoader.Mask, for address: Int64) -> [Int64] {
        var addresses: [Int64] = []
        mask.enumerateAddresses(for: address) {
            addresses.append($0)
        }
        return addresses
    }
}
