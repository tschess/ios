//
//  UserDeserializer.swift
//  ios
//
//  Created by Matthew on 11/8/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class PlayerCoreDeserializer {
    
    public func execute(dictionary: [String: Any]) -> PlayerCore {
        
        let id = dictionary["id"]! as! String
        let username = dictionary["username"]! as! String
        let avatar = dictionary["avatar"]! as! String
        let elo = String(dictionary["elo"]! as! Int)
        let rank = String(dictionary["rank"]! as! Int)
        let date = dictionary["date"]! as! String
        let disp = String(dictionary["disp"]! as! Int)
        
        return PlayerCore(
            id: id,
            username: username,
            avatar: avatar,
            elo: elo,
            rank: rank,
            date: date,
            disp:disp)
    }
}

