//
//  PlayerCore.swift
//  ios
//
//  Created by Matthew on 2/3/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PlayerCore: Equatable, Hashable {
    
    var id: String
    var username: String
    var avatar: String
    var elo: String
    var rank: String
    var date: String
    var disp: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: PlayerCore, rhs: PlayerCore) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(
        id: String = "TBD",
        username: String,
        avatar: String,
        elo: String = "TBD",
        rank: String = "TBD",
        date: String = "TBD",
        disp: String = "TBD"
    ) {
        self.id = id
        self.username = username
        self.avatar = avatar
        self.elo = elo
        self.rank = rank
        self.date = date
        self.disp = disp
    }
    
    func getId() -> String {
        return id
    }
    func setId(id: String) {
        self.id = id
    }
    
    func getUsername() -> String {
        return username
    }
    func setUsername(username: String) {
        self.username = username
    }
    
    func getAvatar() -> String {
        return avatar
    }
    func setAvatar(avatar: String) {
        self.avatar = avatar
    }
    
    func getElo() -> String {
        return elo
    }
    func setElo(elo: String) {
        self.elo = elo
    }
    
    public func getRank() -> String {
        return rank
    }
    public func setRank(rank: String) {
        self.rank = rank
    }
    
    public func getDate() -> String {
        return date
    }
    public func setDate(date: String) {
        self.date = date
    }
    
    public func getDisp() -> String {
        return disp
    }
    public func setDisp(disp: String) {
        self.disp = disp
    }
    
}

