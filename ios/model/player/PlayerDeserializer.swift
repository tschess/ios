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
        let name = dictionary["name"]! as! String
        let avatar = dictionary["avatar"]! as! String
        let rank = String(dictionary["rank"]! as! Int)
        let elo = String(dictionary["elo"]! as! Int)
        
        let password = dictionary["password"]! as! String
        let api = dictionary["api"]! as! String
        let device = dictionary["device"]! as! String
        
        let tschx = String(dictionary["tschx"]! as! Int)
        let address = dictionary["address"]! as! String
        let skin = dictionary["skin"]! as! String
        
        let matrix0 = dictionary["config0"]! as! [[String]]
        let matrix1 = dictionary["config1"]! as! [[String]]
        let matrix2 = dictionary["config2"]! as! [[String]]
        let config0 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix0)
        let config1 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix1)
        let config2 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix2)
        //print("     - savedConfigurationElementMatrix: \(savedConfigurationElementMatrix)")
        let squad = dictionary["squad"]! as! [String]
        let fairyElementList = LoginResponseParser().generateFairyElementList(fairyElementStringArray: squad)
        //print("     - fairyElementList: \(fairyElementList)")
        
        let player: Player =
            Player(
                    id: id,
                    name: name,
                    avatar: avatar,
                    rank: rank,
                    elo: elo,
                    password: password,
                    api: api,
                    device: device,
                    config0: config0,
                    config1: config1,
                    config2: config2,
                    skin: skin,
                    tschx: tschx,
                    address: address,
                    fairyElementList: fairyElementList)
        
        return player
    }
}
