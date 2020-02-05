//
//  ParseGame.swift
//  ios
//
//  Created by Matthew on 2/4/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class ParseGame {
    
    func execute(json: [String: Any]) -> EntityGame {
        
        //        var id_game: String
        let id = json["id"]! as! String
        print("id: \(id)")
        
        //        var state: [[String?]]
        let state = json["state"]! as! [[String?]]
        print("state: \(state)")
        
        //        var moves: Int
        let moves = json["moves"]! as! Int
        print("moves: \(moves)")
        
        //        var status: String
        let status = json["status"]! as! String
        print("status: \(status)")
        
        //        var outcome: String
        let outcome = json["outcome"]! as! String
        print("outcome: \(outcome)")
        
        //        var white: EntityPlayer
        let whiteX = json["white"]! as! [String: Any]
        //print("white: \(white)")
        let white: EntityPlayer = ParsePlayer().execute(json: whiteX)
        
        //        var white_elo: Int
        let white_elo = json["white_elo"]! as! Int
        print("white_elo: \(white_elo)")
        
        //        var white_disp: Int
        let white_disp = json["white_disp"]! as! Int
        print("white_disp: \(white_disp)")
        
        //        var white_skin: String
        let white_skin = json["white_skin"]! as! String
        print("white_skin: \(white_skin)")
        
        //        var black: EntityPlayer
        let blackX = json["black"]! as! [String: Any]
        //print("black: \(black)")
        let black: EntityPlayer = ParsePlayer().execute(json: blackX)
        
        //        var black_elo: Int
        let black_elo = json["black_elo"]! as! Int
        print("black_elo: \(black_elo)")
        
        //        var black_disp: Int
        let black_disp = json["black_disp"]! as! Int
        print("black_disp: \(black_disp)")
        
        //        var black_skin: String
        let black_skin = json["black_skin"]! as! String
        print("black_skin: \(black_skin)")
        
        //        var challenger: String
        let challenger = json["challenger"]! as! String
        print("challenger: \(challenger)")
        
        //        var winner: String
        let winner = json["winner"]! as! String
        print("winner: \(winner)")
        
        //        var turn: String
        let turn = json["turn"]! as! String
        print("turn: \(turn)")
        
        //        var on_check: Bool
        let on_check = json["on_check"]! as! Bool
        print("on_check: \(on_check)")
        
        //        var highlight: String
        let highlight = json["highlight"]! as! String
        print("highlight: \(highlight)")
        
        //        var updated: String
        let updated = json["updated"]! as! String
        print("updated: \(updated)")
        
        //        var created: String
        let created = json["created"]! as! String
        print("created: \(created)")
        
        
        let game: EntityGame = EntityGame(
            id: id,
            state: state,
            moves: moves,
            status: status,
            outcome: outcome,
            white: white,
            white_elo: white_elo,
            white_disp: white_disp,
            white_skin: white_skin,
            black: black,
            black_elo: black_elo,
            black_disp: black_disp,
            black_skin: black_skin,
            challenger: challenger,
            winner: winner,
            turn: turn,
            on_check: on_check,
            highlight: highlight,
            updated: updated,
            created: created)
        
        return game
    }
}

