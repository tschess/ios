//
//  UserDeserializer.swift
//  ios
//
//  Created by Matthew on 11/8/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class PlayerDeserializer {
    
    public func execute(dictionary: [String: Any]) -> Player {
        
        let id = dictionary["id"]! as! String
        let username = dictionary["username"]! as! String
        let password = dictionary["password"]! as! String
        let avatar = dictionary["avatar"]! as! String
        let elo = String(dictionary["elo"]! as! Int)
        let rank = String(dictionary["rank"]! as! Int)
        let date = dictionary["date"]! as! String
        let disp = String(dictionary["disp"]! as! Int)
      
        //let address = dictionary["address"]! as! String
        //let name = dictionary["name"]! as! String
        //let surname = dictionary["surname"]! as! String
        //let email = dictionary["email"]! as! String
        let address = "TBD"
        let name = "TBD"
        let surname = "TBD"
        let email = "TBD"
        
        let matrix0 = dictionary["config0"]! as! [[String]]
        let matrix1 = dictionary["config1"]! as! [[String]]
        let matrix2 = dictionary["config2"]! as! [[String]]
        let config0 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix0)
        let config1 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix1)
        let config2 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix2)
        //let skins = dictionary["skins"]! as! [String]
        //let skinsList = LoginResponseParser().generateFairyElementList(fairyElementStringArray: skins)
        //skins
        //let device = dictionary["device"]! as! String
        //let updated = dictionary["updated"]! as! String
        //let created = dictionary["created"]! as! String
        
        let player: Player =
            Player(
                id: id,
                username: username,
                avatar: avatar,
                elo: elo,
                rank: rank,
                date: date,
                disp: disp,
                password: password,
                address: address,
                name: name,
                surname: surname,
                email: email,
                skinsList: ["lalala"],
                config0: config0,
                config1: config1,
                config2: config2)
        
        return player
    }
}
