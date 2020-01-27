//
//  User.swift
//  ios
//
//  Created by Matthew on 7/28/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Player: PlayerCore {
    
    var password: String
    var address: String
    var name: String
    var surname: String
    var email: String
    var skinsList: [String]
    var config0: [[TschessElement?]]
    var config1: [[TschessElement?]]
    var config2: [[TschessElement?]]
    
    init(
        id: String,
        username: String,
        avatar: String,
        elo: String,
        rank: String,
        date: String,
        disp: String,
    
        password: String,
        address: String,
        name: String,
        surname: String,
        email: String,
        skinsList: [String],
        config0: [[TschessElement?]],
        config1: [[TschessElement?]],
        config2: [[TschessElement?]]
    ) {
        self.password = password
        self.address = address
        self.name = name
        self.surname = surname
        self.email = email
        self.skinsList = skinsList
        self.config0 = config0
        self.config1 = config1
        self.config2 = config2
        
        super.init(
            id: id,
            username: username,
            avatar: avatar,
            elo: elo,
            rank: rank,
            date: date,
            disp: disp
        )
    }
    
    func getSkinsList() -> [String] {
        return self.skinsList
    }
    func setSkinsList(skinsList: [String]) {
        self.skinsList = skinsList
    }
    
    func getAddress() -> String {
        return self.address
    }
    func setAddress(address: String) {
        self.address = address
    }
    
    func getConfig0() -> [[TschessElement?]] {
        return config0
    }
    func setConfig0(config0: [[TschessElement?]]) {
        self.config0 = config0
    }
    
    func getConfig1() -> [[TschessElement?]] {
        return config1
    }
    func setConfig1(config1: [[TschessElement?]]) {
        self.config1 = config1
    }
    
    func getConfig2() -> [[TschessElement?]] {
        return config2
    }
    func setConfig2(config2: [[TschessElement?]]) {
        self.config2 = config2
    }
    
}
