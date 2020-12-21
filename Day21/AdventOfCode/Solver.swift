//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    public let allIngredientCounts: [String: Int]
    public let possibleIngredientsByAllergen: [String: Set<String>]
    public let ingredientByAllergen: [String: String]
    
    public init(input: String) {
        var allIngredientCounts = [String: Int]()
        var possibleIngredientsByAllergen: [String: Set<String>] = [:]
        
        for line in input.components(separatedBy: .newlines) {
            let components = line.components(separatedBy: " (contains ")
            let ingredients = components[0].components(separatedBy: .whitespaces)
            let allergens = components[1].dropLast().components(separatedBy: ", ")
            
            for allergen in allergens {
                if let possibleIngredients = possibleIngredientsByAllergen[allergen] {
                    possibleIngredientsByAllergen[allergen] = possibleIngredients.intersection(ingredients)
                } else {
                    possibleIngredientsByAllergen[allergen] = Set(ingredients)
                }
            }
            
            ingredients.forEach { allIngredientCounts[$0, default: 0] += 1 }
        }
        
        var ingredientByAllergen = [String: String]()
        while ingredientByAllergen.count != possibleIngredientsByAllergen.count {
            for (allergen, possibleIngredients) in possibleIngredientsByAllergen {
                // Skip allergens with ingredients already identified
                guard ingredientByAllergen[allergen] == nil else { continue }
                
                // Remove ingredients that have already been identified
                let reducedIngredients = possibleIngredients.subtracting(ingredientByAllergen.values)
                if reducedIngredients.count == 1 {
                    ingredientByAllergen[allergen] = reducedIngredients.first
                }
            }
        }

        self.allIngredientCounts = allIngredientCounts
        self.possibleIngredientsByAllergen = possibleIngredientsByAllergen
        self.ingredientByAllergen = ingredientByAllergen
    }
    
    public func answerPart1() -> Int {
        let allergenicIngredients = Set(ingredientByAllergen.values)
        
        var total = 0
        for (ingredient, count) in allIngredientCounts where !allergenicIngredients.contains(ingredient) {
            total += count
        }
        return total
    }
    
}
