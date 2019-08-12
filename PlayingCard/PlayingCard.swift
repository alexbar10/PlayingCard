//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Alejandro Barranco on 12/08/19.
//  Copyright © 2019 Alejandro Barranco. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    
    var suit: Suit
    var rank: Rank

    var description: String {
        return "\(rank)\(suit)"
    }
    
    enum Suit: String, CustomStringConvertible {

        var description: String {
            return self.rawValue
        }
        
        case spades = "♠︎"
        case hearts = "♥︎"
        case clubs = "♣︎"
        case diamonds = "♦︎"
        
        static var all = [Suit.spades, .hearts, .clubs, diamonds]
    }
    
    enum Rank: CustomStringConvertible {
        
        var description: String {
            return "\(order)"
        }
        
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace:
                return 1
            case .numeric(let pips):
                return pips
            case .face(let kind) where kind == "J":
                return 11
            case .face(let kind) where kind == "Q":
                return 12
            case .face(let kind) where kind == "K":
                return 13
            default:
                return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
    }
}
