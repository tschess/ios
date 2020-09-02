//
//  EntityGame.swift
//  ios
//
//  Created by Matthew on 2/4/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EntityGame: Equatable, Hashable {
    
    var prompt: Bool         //  A
    
    var id: String           //  0
    var state: [[String]]    //  1
    var moves: Int           //  2
    var status: String       //  3
    var condition: String    //  4
    var white: EntityPlayer  //  5
    var black: EntityPlayer  //  6
    var challenger: String   //  7
    var winner: String?      //  8
    var turn: String         //  9
    var on_check: Bool       // 10
    var highlight: String    // 11
    var updated: String      // 12
    
    init(
        id: String,
        state: [[String]],
        moves: Int,
        status: String,
        condition: String,
        white: EntityPlayer,
        black: EntityPlayer,
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
        self.black = black
        self.challenger = challenger
        self.winner = winner
        self.turn = turn
        self.on_check = on_check
        self.highlight = highlight
        self.updated = updated
        
        self.prompt = false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: EntityGame, rhs: EntityGame) -> Bool {
        return lhs.id == rhs.id
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
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        let date: Date = self.getDateUpdated()
        return formatter.string(from: date)
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
    
    func getAffiliationOther(username: String) -> String {
        if(self.white.username == username){
            return "BLACK"
        }
        return "WHITE"
    }
    
    func getWinner(username: String) -> Bool {
        if(self.winner == nil){
            return false
        }
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
    
    func isDraw() -> Bool {
        if(self.condition == "DRAW"){
            return true
        }
        return false
    }
    
    func getTurnFlag(username: String) -> Bool {
        if(self.white.username == username){
            return self.turn == "WHITE"
        }
        return self.turn == "BLACK"
    }
    
    func getTurnUser() -> String {
        if(self.turn == "WHITE"){
            return self.white.username
        }
        return self.black.username
    }
    
    func getTurnPlayer() -> EntityPlayer {
        if(self.turn == "WHITE"){
            return self.white
        }
        return self.black
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
    
    func isResolved() -> Bool {
        return self.status.contains("RESOLVED")
    }
    
    func getPrompt(username: String) -> Bool {
        let resolved: Bool = self.status == "RESOLVED"
        if(resolved){
            return false
        }
        let ongoing: Bool = self.status == "ONGOING"
        let pending: Bool = self.status == "PENDING"
        if(ongoing || pending) {
            return false
        }
        let white: Bool = self.white.username == username
        if(white){
            return self.status.contains("WHITE")
        }
        return self.status.contains("BLACK")
    }
}
