//
//  AllergenDetector.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Allergen: Comparable, Equatable, Hashable, ExpressibleByStringLiteral {
    public let name: String
    
    public static func < (lhs: Allergen, rhs: Allergen) -> Bool { lhs.name < rhs.name }
    
    public init(stringLiteral: String) {
        self.name = stringLiteral
    }
}

public struct Ingredient: Equatable, Hashable, ExpressibleByStringLiteral {
    public let name: String
    
    public init(stringLiteral: String) {
        self.name = stringLiteral
    }
}

public struct AllergenDetector {

    public let ingredientCounts: [Ingredient: Int]
    public let ingredientByAllergen: [Allergen: Ingredient]
    
    public init(input: String) {
        var ingredientCounts = [Ingredient: Int]()
        var possibleIngredientsByAllergen: [Allergen: Set<Ingredient>] = [:]
        
        for line in input.components(separatedBy: .newlines) {
            let components = line.components(separatedBy: " (contains ")
            let ingredients = components[0].components(separatedBy: .whitespaces).map { Ingredient(stringLiteral: $0) }
            let allergens = components[1].dropLast().components(separatedBy: ", ").map { Allergen(stringLiteral: $0) }
            
            for allergen in allergens {
                if let possibleIngredients = possibleIngredientsByAllergen[allergen] {
                    possibleIngredientsByAllergen[allergen] = possibleIngredients.intersection(ingredients)
                } else {
                    possibleIngredientsByAllergen[allergen] = Set(ingredients)
                }
            }
            
            ingredients.forEach { ingredientCounts[$0, default: 0] += 1 }
        }
        
        var ingredientByAllergen = [Allergen: Ingredient]()
        while ingredientByAllergen.count != possibleIngredientsByAllergen.count {
            for (allergen, ingredients) in possibleIngredientsByAllergen where ingredientByAllergen[allergen] == nil {
                // Remove ingredients that have already been identified
                let reducedIngredients = ingredients.subtracting(ingredientByAllergen.values)
                if reducedIngredients.count == 1 {
                    ingredientByAllergen[allergen] = reducedIngredients.first
                    possibleIngredientsByAllergen[allergen] = reducedIngredients
                }
            }
        }

        self.ingredientCounts = ingredientCounts
        self.ingredientByAllergen = ingredientByAllergen
    }
    
    public func countSafeIngredients() -> Int {
        let allergenicIngredients = Set(ingredientByAllergen.values)
        return ingredientCounts.filter { !allergenicIngredients.contains($0.0) }.reduce(0) { sum, ingredientCount in
            sum + ingredientCount.1
        }
    }
    
    public func canonicalDangerousIngredients() -> String {
        ingredientByAllergen.keys.sorted().compactMap { ingredientByAllergen[$0]?.name }.joined(separator: ",")
    }
    
}
