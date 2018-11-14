//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Rodolfo Rodriguez on 11/13/18.
//  Copyright © 2018 Rodolfo Rodriguez. All rights reserved.
//

import Foundation

struct PlayingCard {
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CustomStringConvertible {
        case diamonds = "♦️"
        case hearts = "♥️"
        case spades = "♠️"
        case clubs = "♣️"
        
        var description: String {
            return rawValue
        }
        
        static var all: [Suit] {
            return [.diamonds, .hearts, .spades, .clubs]
        }
    }
    
    enum Rank: CustomStringConvertible {
        case ace
        case face(String)
        case numeric(Int)
        
        var description: String {
            switch self {
            case .ace:
                return "A"
            case .numeric(let num): return String(num)
            case .face(let value): return value
            }
        }
        
        static var all: [Rank] {
            var values = [Rank]()
            for n in 2...10 {
                values.append(numeric(n))
            }
            values += [.ace, .face("J"), .face("Q"), .face("K")]
            return values
        }
        
        var order: Int {
            switch self {
            case .ace:
                return 1
            case .numeric(let num): return num
            case .face(let value) where value == "J": return 11
            case .face(let value) where value == "Q": return 12
            case .face(let value) where value == "K": return 13
            default:
                return 0
            }
        }
    }
}
