//
//  EntityGame.swift
//  ios
//
//  Created by Matthew on 2/4/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

 class EntityGame { //: Equatable, Hashable
     
     var id_game: String
     
     var state: String
     
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
    
}
