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
    var playerSelf: Player
    var playerOppo: PlayerCore
    
    var white: Bool?
    var onCheck: Bool?
    var highlight: [[Int]]?
    var state: [[TschessElement?]]?
    
    var skin: SKIN?
    var status: STATUS?
    var turn: CONTESTANT?
    
    init(
        idGame: String,
        playerSelf: Player,
        playerOppo: PlayerCore,
        
        white: Bool? = nil,
        onCheck: Bool? = nil,
        highlight: [[Int]]? = nil,
        state: [[TschessElement?]]? = nil,
        
        skin: SKIN? = nil,
        status: STATUS? = nil,
        turn: CONTESTANT? = nil
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
