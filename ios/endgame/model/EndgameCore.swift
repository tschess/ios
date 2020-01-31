//
//  EndgameCore.swift
//  ios
//
//  Created by Matthew on 1/30/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

import UIKit

class EndgameCore {
    
    var id: String
    var date: String
    var avatarWinner: String
    var usernameWinner: String
    
    var canonical: Bool?
    var usernameWhite: String?
    var usernameBlack: String?
    var moves: Int?
    var outcome: OUTCOME?
    var state: [[TschessElement?]]?
    
    init(
        id: String,
        date: String,
        avatarWinner: String,
        usernameWinner: String,
        
        canonical: Bool? = nil,
        usernameWhite: String? = nil,
        usernameBlack: String? = nil,
        moves: Int? = nil,
        outcome: OUTCOME? = nil,
        state: [[TschessElement?]]? = nil
        
    ) {
        self.id = id
        self.date = date
        self.avatarWinner = avatarWinner
        self.usernameWinner = usernameWinner
        //
        self.canonical = canonical
        self.usernameWhite = usernameWhite
        self.usernameBlack = usernameBlack
        self.moves = moves
        self.outcome = outcome
        self.state = state
    }
    
    func getDate() -> String {
        return date
    }
    
    func setDate(date: String) {
        self.date = date
    }
    
    enum OUTCOME {
        case CHECKMATE
        case TIMEOUT
        case RESIGN
        case DRAW
    }
    
}

