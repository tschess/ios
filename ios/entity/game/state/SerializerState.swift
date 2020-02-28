//
//  SerializerState.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

//CANONICAL
class SerializerState {
    
    var white: Bool
    var offset: Int
    
    init(white: Bool){
        self.white = white
        self.offset = 7
        if(self.white){
            self.offset = 0
        }
    }
    
    func renderClient(state: [[String]]) -> [[Piece?]] {
        let rowA: [Piece?] = self.getPiece(row0: state[0])
        let rowB: [Piece?] = self.getPiece(row0: state[1])
        let rowC: [Piece?] = self.getPiece(row0: state[2])
        let rowD: [Piece?] = self.getPiece(row0: state[3])
        let rowE: [Piece?] = self.getPiece(row0: state[4])
        let rowF: [Piece?] = self.getPiece(row0: state[5])
        let rowG: [Piece?] = self.getPiece(row0: state[6])
        let rowH: [Piece?] = self.getPiece(row0: state[7])
        if(self.white){
            return [rowH, rowG, rowF, rowE, rowD, rowC, rowB, rowA]
        }
        return [rowA, rowB, rowC, rowD, rowE, rowF, rowG, rowH]
    }
    
    func getPiece(row0: [String]) -> [Piece?] {
        var row1: [Piece?] = [Piece?](repeating: nil, count: 8)
        for col0 in (0 ..< 8) {
            let col1: Int = abs(self.offset - col0)
            row1[col1] = self.getPiece(name: row0[col0])
        }
        return row1
    }
    
    func getPiece(name: String) -> Piece? {
        if(name.contains("Knight")){
            if(name.contains("White")){
                return KnightWhite()
            }
            return KnightBlack()
        }
        if(name.contains("Bishop")){
            if(name.contains("White")){
                return BishopWhite()
            }
            return BishopBlack()
        }
        if(name.contains("Queen")){
            if(name.contains("White")){
                return QueenWhite()
            }
            return QueenBlack()
        }
        if(name.contains("Rook")){
            var rook: Rook
            if(name.contains("White")){
                rook = RookWhite()
            } else {
                rook = RookBlack()
            }
            if(!name.contains("_x")){
                rook.firstTouch = false
            }
            return rook
        }
        if(name.contains("Pawn")){
            var pawn: Pawn
            if(name.contains("White")){
                pawn = PawnWhite()
            } else {
                pawn = PawnBlack()
            }
            if(!name.contains("_x")){
                pawn.firstTouch = false
            }
            return pawn
        }
        if(name.contains("King")){
            var king: King
            if(name.contains("White")){
                king = KingWhite()
            } else {
                king = KingBlack()
            }
            if(!name.contains("_x")){
                king.firstTouch = false
            }
            return king
        }
        if(name.contains("Poison")){
            var poison: Poison
            if(name.contains("White")){
                poison = PoisonWhite(white: self.white)
            } else {
                poison = PoisonBlack(white: self.white)
            }
            if(!name.contains("_x")){
                poison.firstTouch = false
            }
            return poison
        }
        if(name.contains("Hunter")){
            if(name.contains("White")){
                return HunterWhite()
            }
            return HunterBlack()
        }
        if(name.contains("Amazon")){
            if(name.contains("White")){
                return AmazonWhite()
            }
            return AmazonBlack()
        }
        if(name.contains("Reveal")){
            if(name.contains("White")){
                return RevealWhite()
            }
            return RevealBlack()
        }
       return nil
    }
    
    func renderServer(state: [[Piece?]]) -> [[String]] {
        let rowA: [String] = self.getName(row0: state[0])
        let rowB: [String] = self.getName(row0: state[1])
        let rowC: [String] = self.getName(row0: state[2])
        let rowD: [String] = self.getName(row0: state[3])
        let rowE: [String] = self.getName(row0: state[4])
        let rowF: [String] = self.getName(row0: state[5])
        let rowG: [String] = self.getName(row0: state[6])
        let rowH: [String] = self.getName(row0: state[7])
        if(self.white){
            return [rowH, rowG, rowF, rowE, rowD, rowC, rowB, rowA]
        }
        return [rowA, rowB, rowC, rowD, rowE, rowF, rowG, rowH]
    }
    
    func getName(row0: [Piece?]) -> [String] {
        var row1: [String] = [String](repeating: "", count: 8)
        for col0 in (0 ..< 8) {
            let col1: Int = abs(self.offset - col0)
            row1[col1] = self.getX(x: row0[col0])
        }
        return row1
    }
    
    func getX(x: Piece?) -> String {
        if(x == nil){
            return ""
        }
        if(x!.firstTouch){
            return "\(x!.name)_x"
        }
        return x!.name
    }
    
}
