//
//  User.swift
//  ios
//
//  Created by Matthew on 7/28/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Player: PlayerCore {
    
    //MARK: Properties
    var password: String
    
    var api: String
    var device: String
    
    var config0: [[TschessElement?]]
    var config1: [[TschessElement?]]
    var config2: [[TschessElement?]]
    
    var skin: String
    var tschx: String
    var address: String
    var fairyElementList: [FairyElement]
    
    init(
        id: String,
        name: String,
        avatar: String,
        rank: String,
        elo: String,
        password: String,
        api: String,
        device: String,
        config0: [[TschessElement?]],
        config1: [[TschessElement?]],
        config2: [[TschessElement?]],
        skin: String,
        tschx: String,
        address: String,
        fairyElementList: [FairyElement]) {
        
        self.password = password
        self.api = api
        self.device = device
        self.config0 = config0
        self.config1 = config1
        self.config2 = config2
        self.skin = skin
        self.tschx = tschx
        self.address = address
        self.fairyElementList = fairyElementList
        
        super.init(id: id, name: name, avatar: avatar, rank: rank, elo: elo)
    }
    
    func getSkin() -> String {
        return self.skin
    }
    
    func getAddress() -> String {
        return self.address
    }

    func setAddress(address: String) {
        self.address = address
    }
    
    func appendToFairyElementList(fairyElement: FairyElement) {
        self.fairyElementList.append(fairyElement)
    }
    
    func setFairyElementList(fairyElementList: [FairyElement]) {
        self.fairyElementList = fairyElementList
    }
    
    func getFairyElementList() -> [FairyElement] {
        return fairyElementList
    }
    
    func setConfig0(config0: [[TschessElement?]]) {
        self.config0 = config0
    }
    
    func getConfig0() -> [[TschessElement?]] {
        return config0
    }
    
    func setConfig1(config1: [[TschessElement?]]) {
        self.config1 = config1
    }
    
    func getConfig1() -> [[TschessElement?]] {
        return config1
    }
    
    func setConfig2(config2: [[TschessElement?]]) {
        self.config2 = config2
    }
    
    func getConfig2() -> [[TschessElement?]] {
        return config2
    }
    
    func setTschx(tschx: String) {
        self.tschx = tschx
    }
    
    func getTschx() -> String {
        return tschx
    }
    
}
