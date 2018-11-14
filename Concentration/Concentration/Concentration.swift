//
//  Concentration.swift
//  Concentration
//
//  Created by Rodolfo Rodriguez on 11/4/18.
//  Copyright © 2018 Rodolfo Rodriguez. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private var facedUpCards = [Int]()
    private(set) var score = 0

    
    private var indexOfFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = cardIndex == newValue
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched {
            return
        }
        
        if let matchIndex = indexOfFaceUpCard {
            if cards[index].identifier == cards[matchIndex].identifier {
                cards[index].isMatched = true
                cards[matchIndex].isMatched = true
                score += 1
            } else if facedUpCards.contains(index) || facedUpCards.contains(matchIndex) {
                score -= 3
            } else {
                facedUpCards += [index, matchIndex]
            }
            cards[index].isFaceUp = true
        } else {
            indexOfFaceUpCard = index
        }
    }
    
    init(numberOfCardPairs: Int) {
        for _ in 1...numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        
        for i in cards.indices {
            let rand = Int.random(in: 0..<cards.count)
            let randCard = cards[rand]
            cards[rand] = cards[i]
            cards[i] = randCard
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
