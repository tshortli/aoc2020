//
//  CardGame.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct CardGame {
    struct Deck: Equatable, Hashable {
        var cards: [Int]
        
        mutating func playCard() -> Int { cards.removeFirst() }
        
        func makeCopy(count: Int) -> Deck {
            return Deck(cards: Array(cards.prefix(count)))
        }
        
        var count: Int { cards.count }
        var isEmpty: Bool { cards.isEmpty }
        var score: Int {
            cards.reversed().enumerated().reduce(0) { $0 + ($1.offset + 1) * $1.element }
        }
    }
    
    struct RoundSnapshot: Equatable, Hashable {
        let deck1: Deck
        let deck2: Deck
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
        var deck1 = self.deck1, deck2 = self.deck2
        
        while !deck1.isEmpty, !deck2.isEmpty {
            let card1 = deck1.playCard(), card2 = deck2.playCard()
            
            if card1 > card2 {
                deck1.cards += [card1, card2]
            } else {
                deck2.cards += [card2, card1]
            }
        }
        
        return (deck1.isEmpty ? deck2 : deck1).score
    }
    
    public func playRecursiveCombat() -> Int {
        let (score1, score2) = playRecursiveCombat(deck1: deck1, deck2: deck2)
        return max(score1, score2)
    }
    
    func playRecursiveCombat(deck1: Deck, deck2: Deck) -> (Int, Int) {
        var previousRounds = Set<RoundSnapshot>()
        var deck1 = deck1, deck2 = deck2

        while !deck1.isEmpty, !deck2.isEmpty {
            let roundSnapshot = RoundSnapshot(deck1: deck1, deck2: deck2)
            if !previousRounds.insert(roundSnapshot).inserted {
                // Loop prevention, player 1 wins.
                return (deck1.score, 0)
            }
            
            let card1 = deck1.playCard(), card2 = deck2.playCard()
            var player1Wins: Bool
            
            if deck1.count >= card1, deck2.count >= card2 {
                let (score1, score2) = playRecursiveCombat(deck1: deck1.makeCopy(count: card1),
                                                           deck2: deck2.makeCopy(count: card2))
                player1Wins = (score1 > score2)
            } else {
                player1Wins = (card1 > card2)
            }

            if player1Wins {
                deck1.cards += [card1, card2]
            } else {
                deck2.cards += [card2, card1]
            }
        }
        
        return (deck1.score, deck2.score)
    }
    
}
