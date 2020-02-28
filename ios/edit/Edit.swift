//
//  Edit.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Edit {
    
    func generateTschessElement(name: String) -> Piece? {
        if(name.contains("grasshopper")){
            return Grasshopper()
        }
        if(name.contains("hunter")){
            return Hunter()
        }
        if(name.contains("poison")){
            return Poison()
        }
        if(name.contains("amazon")){
            return Amazon()
        }
        if(name.contains("pawn")){
            return Pawn()
        }
        if(name.contains("knight")){
            return Knight()
        }
        if(name.contains("bishop")){
            return Bishop()
        }
        if(name.contains("rook")){
            return Rook()
        }
        if(name.contains("queen")){
            return Queen()
        }
        if(name.contains("king")){
            return King()
        }
        return nil
    }
    
    func imageNameFromPiece(piece: Piece) -> String? {
        if(piece.name == Grasshopper().name){
            return "red_grasshopper"
        }
        if(piece.name == Hunter().name){
            return "red_hunter"
        }
        if(piece.name == Poison().name){
            return "red_poison"
        }
        if(piece.name == Amazon().name){
            return "red_amazon"
        }
        if(piece.name == Pawn().name){
            return "red_pawn"
        }
        if(piece.name == Knight().name){
            return "red_knight"
        }
        if(piece.name == Bishop().name){
            return "red_bishop"
        }
        if(piece.name == Rook().name){
            return "red_rook"
        }
        if(piece.name == Queen().name){
            return "red_queen"
        }
        if(piece.name == King().name){
            return "red_king"
        }
        return nil
    }
    
}
