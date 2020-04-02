//
//  EntityGame.swift
//  ios
//
//  Created by Matthew on 2/4/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EntityGame: Equatable, Hashable {
    
    var id: String
    var state: [[String]]
    var moves: Int
    var status: String
    var condition: String
    var white: EntityPlayer
    var white_elo: Int
    var white_disp: Int?
   
    var black: EntityPlayer
    var black_elo: Int
    var black_disp: Int?
    
    var challenger: String
    var winner: String?
    var turn: String
    var on_check: Bool
    var highlight: String
    var updated: String
    
    init(
        id: String,
        state: [[String]],
        moves: Int,
        status: String,
        condition: String,
        white: EntityPlayer,
        white_elo: Int,
        white_disp: Int?,
   
        black: EntityPlayer,
        black_elo: Int,
        black_disp: Int?,
 
        challenger: String,
        winner: String?,
        turn: String,
        on_check: Bool,
        highlight: String,
        updated: String
    ) {
        self.id = id
        self.state = state
        self.moves = moves
        self.status = status
        self.condition = condition
        self.white = white
        self.white_elo = white_elo
        self.white_disp = white_disp
      
        self.black = black
        self.black_elo = black_elo
        self.black_disp = black_disp
      
        self.challenger = challenger
        self.winner = winner
        self.turn = turn
        self.on_check = on_check
        self.highlight = highlight
        self.updated = updated
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: EntityGame, rhs: EntityGame) -> Bool {
        return lhs.id == rhs.id
    }
    
    var tintColorWhite: UIColor = UIColor.blue
    var tintColorBlack: UIColor = UIColor.blue
    
    func getTint(username: String) -> UIColor {
        if(self.white.username == username){
            return tintColorWhite
        }
        return tintColorBlack
    }
    
    func getImageDisp(username: String) -> UIImage? {
        if(self.white_disp == nil || self.black_disp == nil){
                return UIImage(named: "close_b")!
        }
        if(self.white.username == username){
            if(self.white_disp! >= 0){
                return UIImage(named: "upx")!
            }
            return UIImage(named: "dwn")!
        }
        if(self.black_disp! >= 0){
            return UIImage(named: "upx")!
        }
        return UIImage(named: "dwn")!
    }
    
    
    
    func getLabelTextDisp(username: String) -> String? {
        if(self.white_disp == nil || self.black_disp == nil){
            return nil
        }
        if(self.white.username == username){
            return String(abs(self.white_disp!))
        }
        return String(abs(self.black_disp!))
    }
    
    func getOdds(username: String) -> String {
        var odds: Int
        if(self.white.username == username){
            odds = self.white.elo - self.black.elo
        } else {
            odds = self.black.elo - self.white.elo
        }
        if(odds >= 0){
            return "+"
        }
        return "-"
    }
    
    func getImageAvatarOpponent(username: String) -> UIImage {
        if(self.white.username == username){
            return self.black.getImageAvatar()
        }
        return self.white.getImageAvatar()
    }
    
    func getLabelTextUsernameOpponent(username: String) -> String {
        if(self.white.username == username){
            return self.black.username
        }
        return self.white.username
    }
    
    func getDateUpdated() -> Date {
        return DateTime().toFormatDate(string: self.updated)
    }
    
    func getLabelTextDate() -> String {
        let date: Date = self.getDateUpdated()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        var dateFormat = formatter.string(from: date)
        dateFormat.insert("'", at: dateFormat.index(dateFormat.endIndex, offsetBy: -2))
        return dateFormat
    }
    
    func getStateClient(username: String) -> [[Piece?]] {
        if(self.white.username == username){
            return SerializerState(white: true).renderClient(state: self.state)
        }
        return SerializerState(white: false).renderClient(state: self.state)
    }
    
    func getImageAvatarWinner() -> UIImage {
        if(self.winner == "WHITE"){
            return self.white.getImageAvatar()
        }
        return self.black.getImageAvatar()
    }
    
    func getUsernameWinner() -> String {
        if(self.winner == "WHITE"){
            return self.white.username
        }
        return self.black.username
    }
    
    func getInboundInvitation(username: String) -> Bool {
        if(self.white.username == username){
            if(self.challenger == "WHITE"){
                return false
            }
            return true
        }
        if(self.challenger == "BLACK"){
            return false
        }
        return true
    }
    
    func getInboundGame(username: String) -> Bool {
        if(self.white.username == username){
            if(self.turn == "WHITE"){
                return true
            }
            return false
        }
        if(self.turn == "BLACK"){
            return true
        }
        return false
    }
    
    func getPlayerOther(username: String) -> EntityPlayer {
        if(self.white.username == username){
            return self.black
        }
        return self.white
    }
    
    func getWinner(username: String) -> Bool {
        if(self.white.username == username){
            if(self.winner! == "WHITE"){
                return true
            }
            return false
        }
        if(self.winner! == "BLACK"){
            return true
        }
        return false
    }
    
    func getTurn(username: String) -> Bool {
        if(self.white.username == username){
            return self.turn == "WHITE"
        }
        return self.turn == "BLACK"
    }
    
    func getTurn() -> String {
        if(self.turn == "WHITE"){
            return self.white.username
        }
        return self.black.username
    }
    
    func getStateServer(username: String, state: [[Piece?]]) -> [[String]]{
        if(self.white.username == username){
            return SerializerState(white: true).renderServer(state: state)
        }
        return SerializerState(white: false).renderServer(state: state)
    }
    
    func getWhite(username: String) -> Bool {
        return self.white.username == username
    }
}
