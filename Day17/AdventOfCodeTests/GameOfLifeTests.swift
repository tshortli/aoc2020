//
//  GameOfLifeTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

@testable import AdventOfCode
import XCTest

class GameOfLifeTests: XCTestCase {

    func testExample() throws {
        let input =
        """
        .#.
        ..#
        ###
        """
        
        let game = GameOfLife(input: input)
        XCTAssertEqual(game.activeCubesAfterSimulationFixedW(), 112)
        XCTAssertEqual(game.activeCubesAfterSimulation(), 848)
    }

}
