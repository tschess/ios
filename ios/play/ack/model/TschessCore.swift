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
    
    var skin: SKIN?
    var white: Bool?
    var state: [[TschessElement?]]?
    
    init(
        idGame: String,
        playerSelf: Player,
        playerOppo: PlayerCore,
        
        skin: SKIN? = nil,
        white: Bool? = nil,
        state: [[TschessElement?]]? = nil
    ) {
        self.idGame = idGame
        
        self.playerSelf = playerSelf
        self.playerOppo = playerOppo
        
        self.skin = skin
        self.white = white
        self.state = state
    }
    
    enum SKIN {
        case DEFAULT
        case IAPETUS
        case CALYPSO
        case HYPERION
        case NEPTUNE
    }
    
}
