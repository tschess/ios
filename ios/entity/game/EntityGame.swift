//
//  EntityGame.swift
//  ios
//
//  Created by Matthew on 2/4/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EntityGame: Equatable, Hashable {
    
    var id_game: String
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
        id_game: String,
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
        self.id_game = id_game
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
        hasher.combine(self.id_game)
    }
    
    static func == (lhs: EntityGame, rhs: EntityGame) -> Bool {
        return lhs.id_game == rhs.id_game
    }
    
}
