//
//  EntityPlayer.swift
//  ios
//
//  Created by Matthew on 2/4/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EntityPlayer: Equatable, Hashable {
    
    var id: String
    var username: String
    var password: String
    var elo: Int
    var rank: Int
    var disp: Int
    var date: String
    var avatar: String
    var config0: [[String]]
    var config1: [[String]]
    var config2: [[String]]
 
    
    var notify: Bool
    var device: String?
    var updated: String
    var created: String
    
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
        created: String
    ) {
        self.id = id
        self.username = username
        self.password = password
        self.elo = elo
        self.rank = rank
        self.date = date
        self.disp = disp
        self.avatar = avatar
        self.config0 = config0
        self.config1 = config1
        self.config2 = config2
        
        self.notify = notify
        self.device = device
        self.updated = updated
        self.created = created
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: EntityPlayer, rhs: EntityPlayer) -> Bool {
        return lhs.id == rhs.id
    }
    
    func getImageAvatar() -> UIImage {
        let data: Data = Data(base64Encoded: self.avatar, options: .ignoreUnknownCharacters)!
        return UIImage(data: data)!
    }
    
    var tintColor: UIColor = UIColor.blue
    
    func getImageDisp() -> UIImage? {
        if(self.disp >= 0){
            //self.tintColor = .green
            //if #available(iOS 13.0, *) {
                //return UIImage(systemName: "arrow.up")!
            //}
            return UIImage(named: "upx")!
        }
        //self.tintColor = .red
        //if #available(iOS 13.0, *) {
            //return UIImage(systemName: "arrow.down")!
        //}
        return UIImage(named: "dwn")!
    }
    
    func getLabelTextDisp() -> String{
        return String(abs(self.disp))
    }
    
    func getLabelTextRank() -> String{
        return String(self.rank)
    }
    
    func getLabelTextElo() -> String{
        return String(self.elo)
    }
    
    func getDate() -> Date {
        return DateTime().toFormatDate(string: self.date)
    }
    
    func getLabelTextDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.YY"
        var date = formatter.string(from: self.getDate())
        date.insert("'", at: date.index(date.endIndex, offsetBy: -2))
        return date
    }
    
    func getConfig(index: Int) -> [[Piece?]] {
        if(index == 2){
            return SerializerConfig().renderClient(config: self.config2)
        }
        if(index == 1){
            return SerializerConfig().renderClient(config: self.config1)
        }
        return SerializerConfig().renderClient(config: self.config0)
    }
    
    func setConfig(index: Int, config: [[Piece?]]) -> [[String]] {
        if(index == 2){
            self.config2 = SerializerConfig().renderServer(config: config)
            return self.config2
        }
        if(index == 1){
            self.config1 = SerializerConfig().renderServer(config: config)
            return self.config1
        }
        self.config0 = SerializerConfig().renderServer(config: config)
        return self.config0
    }
    
}

