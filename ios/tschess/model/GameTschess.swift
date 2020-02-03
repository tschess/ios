//
//  GameTschess.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class GameTschess {
    
    var gameAck: GameAck?
    
    init(gameAck: GameAck) {
        self.gameAck = gameAck
    }
    
    var gameConnect: GameConnect?
    
    init(gameConnect: GameConnect) {
        self.gameConnect = gameConnect
        self.gameAck = gameConnect.gameAck
    }
}
