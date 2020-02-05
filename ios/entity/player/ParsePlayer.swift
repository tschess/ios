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
        
        //let id_player = json["id_player"]! as! String
        //print("id_player: \(id_player)")
        let id_player = json["id"]! as! String
        print("id_player: \(id_player)")
        
        //var username: String
        let username = json["username"]! as! String
        print("username: \(username)")
        
        //var password: String
        let password = json["password"]! as! String
        print("password: \(password)")
        
        //var elo: Int
        let elo = json["elo"]! as! Int
        print("elo: \(elo)")
        
        //var rank: Int
        let rank = json["rank"]! as! Int
        print("rank: \(rank)")
        
        //var disp: Int
        let disp = json["disp"]! as! Int
        print("disp: \(disp)")
        
        //var date: String
        let date = json["date"]! as! String
        print("date: \(date)")
        
        //var avatar: String
        let avatar = json["avatar"]! as! String
        print("avatar: \(avatar)")
        
        //var config0: [[String]]
        let config0 = json["config0"]! as! [[String]]
        print("config0: \(config0)")
        
        //var config1: [[String]]
        let config1 = json["config1"]! as! [[String]]
        print("config1: \(config1)")
        
        //var config2: [[String]]
        let config2 = json["config2"]! as! [[String]]
        print("config2: \(config2)")
        
        
        //var notify: Bool
        let notify = json["notify"]! as! Bool
        print("notify: \(notify)")
        
        //var device: String
        let device = json["device"]! as! String
        print("device: \(device)")
        
        //var updated: String
        let updated = json["updated"]! as! String
        print("updated: \(updated)")
        
        //var created: String
        let created = json["created"]! as! String
        print("created: \(created)")
        
        let player: EntityPlayer = EntityPlayer(
            id_player: id_player,
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
