//
//  EntityPlayer.swift
//  ios
//
//  Created by Matthew on 2/4/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EntityPlayer: Equatable, Hashable {
    
    var id_player: String
    var username: String
    var password: String
    var elo: Int
    var rank: Int
    var disp: Int
    var date: String
    var avatar: String
    var config0: [[String?]]
    var config1: [[String?]]
    var config2: [[String?]]
    
    var notify: Bool
    var device: String
    var updated: String
    var created: String
    
    init(
        id_player: String,
        username: String,
        password: String,
        elo: Int,
        rank: Int,
        disp: Int,
        date: String,
        avatar: String,
        config0: [[String?]],
        config1: [[String?]],
        config2: [[String?]],
        notify: Bool,
        device: String,
        updated: String,
        created: String
    ) {
        self.id_player = id_player
        self.username = username
        self.password = password
        self.elo = elo
        self.rank = rank
        self.date = date
        self.disp = disp
        self.avatar = avatar
        self.config0 = config0
        self.config1 = config1
        self.config2 = config2
        self.notify = notify
        self.device = device
        self.updated = updated
        self.created = created
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id_player)
    }
    
    static func == (lhs: EntityPlayer, rhs: EntityPlayer) -> Bool {
        return lhs.id_player == rhs.id_player
    }
    
}

