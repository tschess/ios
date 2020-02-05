//
//  ParsePlayer.swift
//  ios
//
//  Created by Matthew on 2/4/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class ParsePlayer {
    
    func execute(json: [String: Any]) -> EntityPlayer {
        
        let id = json["id"]! as! String
        let username = json["username"]! as! String
        let password = json["password"]! as! String
        let elo = json["elo"]! as! Int
        let rank = json["rank"]! as! Int
        let disp = json["disp"]! as! Int
        let date = json["date"]! as! String
        let avatar = json["avatar"]! as! String
        let config0 = json["config0"]! as! [[String]]
        let config1 = json["config1"]! as! [[String]]
        let config2 = json["config2"]! as! [[String]]
        let notify = json["notify"]! as! Bool
        let device = json["device"]! as! String
        let updated = json["updated"]! as! String
        let created = json["created"]! as! String
        
        let player: EntityPlayer = EntityPlayer(
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
        return player
    }
}
