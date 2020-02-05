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
        
        let id = json["id"]! as! String
        let state = json["state"]! as! [[String]]
        let moves = json["moves"]! as! Int
        let status = json["status"]! as! String
        let outcome = json["outcome"]! as! String
        let whiteX = json["white"]! as! [String: Any]
        let white: EntityPlayer = ParsePlayer().execute(json: whiteX)
        let white_elo = json["white_elo"]! as! Int
        let white_disp = json["white_disp"]! as? Int
        let white_skin = json["white_skin"]! as! String
        let blackX = json["black"]! as! [String: Any]
        let black: EntityPlayer = ParsePlayer().execute(json: blackX)
        let black_elo = json["black_elo"]! as! Int
        let black_disp = json["black_disp"]! as? Int
        let black_skin = json["black_skin"]! as! String
        let challenger = json["challenger"]! as! String
        let winner = json["winner"]! as? String
        let turn = json["turn"]! as! String
        let on_check = json["on_check"]! as! Bool
        let highlight = json["highlight"]! as! String
        let updated = json["updated"]! as! String
        let created = json["created"]! as! String
        
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

