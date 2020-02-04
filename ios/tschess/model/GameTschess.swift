//
//  GameTschess.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class GameTschess: GameConnect {
    
    init(gameConnect: GameConnect){
        super.init(
            idGame: gameConnect.idGame,
            playerSelf: gameConnect.playerSelf,
            playerOppo: gameConnect.playerOppo,
            
            skin: gameConnect.skin,
            white: gameConnect.white,
            state: gameConnect.state,
            date: gameConnect.date,
            
            turn: gameConnect.turn,
            status: gameConnect.status,
            highlight: gameConnect.highlight,
            onCheck: gameConnect.onCheck)
    }
    
    override init(gameAck: GameAck){
        super.init(
            idGame: gameAck.idGame,
            playerSelf: gameAck.playerSelf,
            playerOppo: gameAck.playerOppo,
            skin: gameAck.skin,
            white: gameAck.white,
            state: gameAck.state,
            date: gameAck.date)
    }
}
