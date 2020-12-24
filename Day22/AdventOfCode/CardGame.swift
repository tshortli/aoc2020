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
        
        /// Removes and returns the top card from the deck.
        mutating func playCard() -> Int { cards.removeFirst() }
        
        func makeCopy(count: Int) -> Deck {
            return Deck(cards: Array(cards.prefix(count)))
        }
        
        var count: Int { cards.count }
        var isEmpty: Bool { cards.isEmpty }
        
        /// Computes the score of the deck. The bottom card in the deck is worth the value of the card multiplied by
        /// 1, the second-from-the-bottom card is worth the value of the card multiplied by 2, and so on.
        var score: Int {
            cards.reversed().enumerated().reduce(0) { $0 + ($1.offset + 1) * $1.element }
        }
    }
    
    struct RoundSnapshot: Equatable, Hashable {
        let deck1: Deck, deck2: Deck
    }
    
    let deck1: Deck, deck2: Deck
    
    public init(input: String) {
        let cards = input.components(separatedBy: "\n\n").map { lines in
            lines.components(separatedBy: .newlines).dropFirst().compactMap { Int($0) }
        }
            
        self.deck1 = Deck(cards: cards[0])
        self.deck2 = Deck(cards: cards[1])
    }
    
    public func playCombat() -> Int {
        var deck1 = self.deck1, deck2 = self.deck2
        
        //
        // Each round, both players draw their top card, and the player with the higher-valued card wins the round. The
        // winner keeps both cards, placing them on the bottom of their own deck so that the winner's card is above the
        // other card. If this causes a player to have all of the cards, they win, and the game ends.
        //
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

        //
        // - Before either player deals a card, if there was a previous round in this game that had exactly the same
        //   cards in the same order in the same players' decks, the game instantly ends in a win for player 1. Previous
        //   rounds from other games are not considered.
        // - Otherwise, this round's cards must be in a new configuration; the players begin the round by each drawing
        //   the top card of their deck as normal.
        // - If both players have at least as many cards remaining in their deck as the value of the card they just
        //   drew, the winner of the round is determined by playing a new game of Recursive Combat.
        // - Otherwise, at least one player must not have enough cards left in their deck to recurse; the winner of the
        //   round is the player with the higher-value card.
        //
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
