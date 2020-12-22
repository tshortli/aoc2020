//
//  Solver.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct Solver {
    struct Deck {
        var cards: [Int]
        
        var isEmpty: Bool { cards.isEmpty }
        var score: Int {
            var score = 0
            for (i, card) in cards.reversed().enumerated() {
                score += (i + 1) * card
            }
            return score
        }
    }
    
    let deck1: Deck
    let deck2: Deck
    
    public init(input: String) {
        let cards = input.components(separatedBy: "\n\n").map { lines in
            lines.components(separatedBy: .newlines).dropFirst().compactMap { Int($0) }
        }
            
        self.deck1 = Deck(cards: cards[0])
        self.deck2 = Deck(cards: cards[1])
    }
    
    public func playCombat() -> Int {
        var deck1 = self.deck1
        var deck2 = self.deck2
        
        while !deck1.isEmpty, !deck2.isEmpty {
            let card1 = deck1.cards.removeFirst()
            let card2 = deck2.cards.removeFirst()
            
            if card1 > card2 {
                deck1.cards += [card1, card2]
            } else if card1 < card2 {
                deck2.cards += [card2, card1]
            } else {
                fatalError("Cards shouldn't be able to match")
            }
        }
        
        return (deck1.isEmpty ? deck2 : deck1).score
    }
    
}
