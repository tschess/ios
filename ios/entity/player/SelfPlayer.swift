//
//  SelfPlayer.swift
//  ios
//
//  Created by S. Matthew English on 4/3/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

import UIKit

class SelfPlayer: EntityPlayer {
    
    var homeList: [EntityPlayer]?
    var menuList: [EntityGame]?
    var back: String?
    
    init(
        id: String,
        username: String,
        password: String,
        elo: Int,
        rank: Int,
        disp: Int,
        date: String,
        avatar: String,
        config0: [[String]],
        config1: [[String]],
        config2: [[String]],
        notify: Bool,
        device: String?,
        updated: String,
        created: String,
        
        homeList: [EntityPlayer]?,
        menuList: [EntityGame]?,
        back: String?
    ) {
        self.homeList = homeList
        self.menuList = menuList
        self.back = back
        super.init(
            id: id,
            username: username,
            password: password,
            elo: elo,
            rank: rank,
            disp: disp,
            date: date,
            avatar: avatar,
            config0: config0,
            config1: config1,
            config2: config2,
            notify: notify,
            device: device,
            updated: updated,
            created: created)
    }
    
}
