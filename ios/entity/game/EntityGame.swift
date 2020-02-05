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
    var state: [[String?]]
    var moves: Int
    var status: String
    var outcome: String
    var white: EntityPlayer
    var white_elo: Int
    var white_disp: Int
    var white_skin: String
    var black: EntityPlayer
    var black_elo: Int
    var black_disp: Int
    var black_skin: String
    var challenger: String
    var winner: String
    var turn: String
    var on_check: Bool
    var highlight: String
    var updated: String
    var created: String
    
    init(
        id: String,
        state: [[String?]],
        moves: Int,
        status: String,
        outcome: String,
        white: EntityPlayer,
        white_elo: Int,
        white_disp: Int,
        white_skin: String,
        black: EntityPlayer,
        black_elo: Int,
        black_disp: Int,
        black_skin: String,
        challenger: String,
        winner: String,
        turn: String,
        on_check: Bool,
        highlight: String,
        updated: String,
        created: String
    ) {
        self.id = id
        self.state = state
        self.moves = moves
        self.status = status
        self.outcome = outcome
        self.white = white
        self.white_elo = white_elo
        self.white_disp = white_disp
        self.white_skin = white_skin
        self.black = black
        self.black_elo = black_elo
        self.black_disp = black_disp
        self.black_skin = black_skin
        self.challenger = challenger
        self.winner = winner
        self.turn = turn
        self.on_check = on_check
        self.highlight = highlight
        self.updated = updated
        self.created = created
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: EntityGame, rhs: EntityGame) -> Bool {
        return lhs.id == rhs.id
    }
    
    func getImageDisp(username: String) -> UIImage? {
        if(self.white.username == username){
            if(self.white_disp >= 0){
                if #available(iOS 13.0, *) {
                    return UIImage(systemName: "arrow.up")!.withTintColor(.green)
                }
            }
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "arrow.down")!.withTintColor(.red)
            }
        }
        if(self.black_disp >= 0){
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "arrow.up")!.withTintColor(.green)
            }
        }
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "arrow.down")!.withTintColor(.red)
        }
        return nil
    }
    
    func getLabelTextDisp(username: String) -> String {
        if(self.white.username == username){
            return String(abs(self.white_disp))
        }
        return String(abs(self.black_disp))
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
    
    func getDate() -> Date {
        return DateTime().toFormatDate(string: self.updated)
    }
    
    func getLabelTextDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        var date = formatter.string(from: self.getDate())
        date.insert("'", at: date.index(date.endIndex, offsetBy: -2))
        return date
    }
    
    
    
}
