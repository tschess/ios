//
//  TschessCore.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class TschessCore {
    
    var idGame: String
    var white: Bool
   
    var playerSelf: Player
    var playerOppo: PlayerCore
    
    var state: [[TschessElement?]]
    var onCheck: Bool
    var highlight: [[Int]]
    
    var turn: CONTESTANT
    var status: STATUS
    var skin: SKIN
    
    init(
        idGame: String,
        white: Bool,
        
        playerSelf: Player,
        playerOppo: PlayerCore,
        
        state: [[TschessElement?]],
        onCheck: Bool,
        highlight: [[Int]],
        
        turn: CONTESTANT,
        status: STATUS,
        skin: SKIN
    ) {
        self.idGame = idGame
        self.white = white
        
        self.playerSelf = playerSelf
        self.playerOppo = playerOppo
        
        self.state = state
        self.onCheck = onCheck
        self.highlight = highlight
        
        self.turn = turn
        self.status = status
        self.skin = skin
    }
    
    enum STATUS {
        case ONGOING
        case PENDING
        case RESOLVED
    }
    
    enum SKIN {
        case DEFAULT
        case IAPETUS
        case CALYPSO
        case HYPERION
        case NEPTUNE
    }
    
    enum CONTESTANT {
        case WHITE
        case BLACK
    }
    
}
