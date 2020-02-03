//
//  GameTschess.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class GameTschess {
    
    var idGame: String
    var playerSelf: Player
    var playerOppo: PlayerCore
    
    var skin: String?
    var white: Bool?
    var state: [[TschessElement?]]?
    
    init(gameAck: GameAck) {
        self.idGame = gameAck.idGame
        self.playerSelf = gameAck.playerSelf
        self.playerOppo = gameAck.playerOppo
        self.skin = gameAck.skin
        self.white = gameAck.white
        self.state = gameAck.state
    }
    
    init(gameConnect: GameConnect) {
        self.idGame = gameConnect.gameAck.idGame
        self.playerSelf = gameConnect.gameAck.playerSelf
        self.playerOppo = gameConnect.gameAck.playerOppo
        self.skin = gameConnect.gameAck.skin
        self.white = gameConnect.gameAck.white
        self.state = gameConnect.gameAck.state
    }
}
