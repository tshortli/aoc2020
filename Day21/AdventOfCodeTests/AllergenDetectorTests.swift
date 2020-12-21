//
//  AllergenDetectorTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

import AdventOfCode
import XCTest

class AllergenDetectorTests: XCTestCase {

    func testExample() throws {
        let input =
        """
        mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
        trh fvjkl sbzzf mxmxvkd (contains dairy)
        sqjhc fvjkl (contains soy)
        sqjhc mxmxvkd sbzzf (contains fish)
        """
        
        let detector = AllergenDetector(input: input)
        XCTAssertEqual(detector.ingredientByAllergen, ["dairy": "mxmxvkd", "fish": "sqjhc", "soy": "fvjkl"])
        XCTAssertEqual(detector.countSafeIngredients(), 5)
        XCTAssertEqual(detector.canonicalDangerousIngredients(), "mxmxvkd,sqjhc,fvjkl")
    }

}
