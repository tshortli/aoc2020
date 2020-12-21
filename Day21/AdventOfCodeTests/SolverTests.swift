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
        mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
        trh fvjkl sbzzf mxmxvkd (contains dairy)
        sqjhc fvjkl (contains soy)
        sqjhc mxmxvkd sbzzf (contains fish)
        """
        
        let solver = Solver(input: input)
        XCTAssertEqual(solver.ingredientByAllergen, ["dairy": "mxmxvkd", "fish": "sqjhc", "soy": "fvjkl"])
        XCTAssertEqual(solver.answerPart1(), 5)
        XCTAssertEqual(solver.answerPart2(), "mxmxvkd,sqjhc,fvjkl")
    }

}
