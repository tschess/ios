//
//  GameConnect.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class GameConnect {
    
    var idGame: String
    var playerSelf: Player
    var playerOppo: PlayerCore
    
    var skin: String?
    var white: Bool?
    var state: [[TschessElement?]]?
    var date: String?
    
    init(
        idGame: String,
        playerSelf: Player,
        playerOppo: PlayerCore,
        
        skin: String? = nil,
        white: Bool? = nil,
        state: [[TschessElement?]]? = nil,
        date: String? = nil
    ) {
        self.idGame = idGame
        
        self.playerSelf = playerSelf
        self.playerOppo = playerOppo
        
        self.skin = skin
        self.white = white
        self.state = state
        self.date = date
    }
}
