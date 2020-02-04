//
//  GameConnect.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class GameConnect: GameAck {
    
    var turn: String?
    var status: String?
    var highlight: String?
    var onCheck: Bool?
    
    init(gameAck: GameAck){
        super.init(
            idGame: gameAck.idGame,
            playerSelf: gameAck.playerSelf,
            playerOppo: gameAck.playerOppo,
            skin: gameAck.skin,
            white: gameAck.white,
            state: gameAck.state,
            date: gameAck.date)
    }
    
    init(
               idGame: String,
               playerSelf: Player,
               playerOppo: PlayerCore,
        
               skin: String? = nil,
               white: Bool? = nil,
               state: [[TschessElement?]]? = nil,
               date: String? = nil,
        
        turn: String? = nil,
        status: String? = nil,
        highlight: String? = nil,
        onCheck: Bool? = nil
    ) {
        super.init(idGame: idGame, playerSelf: playerSelf, playerOppo: playerOppo)
        
        
        super.skin = skin
        super.white = white
        super.state = state
        super.date = date
        
        
        self.turn = turn
        self.status = status
        self.highlight = highlight
        self.onCheck = onCheck
    }
}
