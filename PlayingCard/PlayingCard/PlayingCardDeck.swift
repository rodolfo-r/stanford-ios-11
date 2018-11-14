//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Rodolfo Rodriguez on 11/13/18.
//  Copyright © 2018 Rodolfo Rodriguez. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    var cards = [PlayingCard]()
    
    mutating func draw() -> PlayingCard? {
        return cards.count > 0 ? cards.removeFirst() : nil
    }
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
}
