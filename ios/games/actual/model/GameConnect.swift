//
//  GameConnect.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class GameConnect {
    
    var gameAck: GameAck
    
    var turn: String?
    var status: String?
    var highlight: String?
    var onCheck: Bool?
    
    init(
        gameAck: GameAck,
        turn: String? = nil,
        status: String? = nil,
        highlight: String? = nil,
        onCheck: Bool? = nil
    ) {
        self.gameAck = gameAck
        self.turn = turn
        self.status = status
        self.highlight = highlight
        self.onCheck = onCheck
    }
}
