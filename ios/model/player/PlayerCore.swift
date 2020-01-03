//
//  Opponent.swift
//  ios
//
//  Created by Matthew on 8/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

import UIKit

class PlayerCore {
    
    var id: String
    var name: String
    var avatar: String
    var rank: String
    var elo: String
    
    init(
        id: String,
        name: String,
        avatar: String,
        rank: String,
        elo: String
        ) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.rank = rank
        self.elo = elo
    }
    
    func getId() -> String {
        return id
    }
    func setId(id: String) {
        self.id = id
    }
    
    func getName() -> String {
        return name
    }
    func setName(name: String) {
        self.name = name
    }
    
    func getAvatar() -> String {
        return avatar
    }
    func setAvatar(avatar: String) {
        self.avatar = avatar
    }
    
    public func getRank() -> String {
        return rank
    }
    public func setRank(rank: String) {
        self.rank = rank
    }
    
    func getElo() -> String {
        return elo
    }
    func setElo(elo: String) {
        self.elo = elo
    }
    
}
