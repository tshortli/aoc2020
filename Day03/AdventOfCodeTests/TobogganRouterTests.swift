//
//  TobogganRouterTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/2/20.
//

import AdventOfCode
import XCTest

class TobogganRouterTests: XCTestCase {

    func testTobogganRouter_EmptyInput() {
        let router = TobogganRouter(input: "")
        XCTAssertEqual(router.countTrees(vector: .init(x: 1, y: 1)), 0)
        XCTAssertEqual(router.countTrees(vector: .init(x: 0, y: 1)), 0)
    }
    
    func testTobogganRouter_Example() {
        let input =
        """
        ..##.......
        #...#...#..
        .#....#..#.
        ..#.#...#.#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
        """
        
        let router = TobogganRouter(input: input)
        XCTAssertEqual(router.countTrees(vector: .init(x: 1, y: 1)), 2)
        XCTAssertEqual(router.countTrees(vector: .init(x: 3, y: 1)), 7)
        XCTAssertEqual(router.countTrees(vector: .init(x: 5, y: 1)), 3)
        XCTAssertEqual(router.countTrees(vector: .init(x: 1, y: 2)), 2)
    }

}
