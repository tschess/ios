//
//  SerializerState.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SerializerState {
    
    var game: EntityGame?
    
    func setGame(game: EntityGame){
        self.game = game
    }
    
    func renderClient(state: [[String]]) -> [[Piece?]] {
        var rowA: [Piece?] = [Piece?](repeating: nil, count: 8) // 0
        var rowB: [Piece?] = [Piece?](repeating: nil, count: 8) // 1
        var rowC: [Piece?] = [Piece?](repeating: nil, count: 8) // 2
        var rowD: [Piece?] = [Piece?](repeating: nil, count: 8) // 3
        var rowE: [Piece?] = [Piece?](repeating: nil, count: 8) // 4
        var rowF: [Piece?] = [Piece?](repeating: nil, count: 8) // 5
        var rowG: [Piece?] = [Piece?](repeating: nil, count: 8) // 6
        var rowH: [Piece?] = [Piece?](repeating: nil, count: 8) // 7
        
        
        //
        //row1[i] = getPiece(name: state[i][j])
        
    }
    
    func getName(piece: Piece?) -> String {
        if(piece == nil){
            return ""
        }
        return piece!.name
    }
    
    func renderServer(state: [[Piece?]]) -> [[String]] {
        var rowA: [String] = [String](repeating: "", count: 8) // 0
        var rowB: [String] = [String](repeating: "", count: 8) // 1
        var rowC: [String] = [String](repeating: "", count: 8) // 2
        var rowD: [String] = [String](repeating: "", count: 8) // 3
        var rowE: [String] = [String](repeating: "", count: 8) // 4
        var rowF: [String] = [String](repeating: "", count: 8) // 5
        var rowG: [String] = [String](repeating: "", count: 8) // 6
        var rowH: [String] = [String](repeating: "", count: 8) // 7
        for row in (0 ..< 8) {
            for col in (0 ..< 8) {
                rowA[col] = getName(piece: state[row][col])
                rowB[col] = getName(piece: state[row][col])
                rowC[col] = getName(piece: state[row][col])
                rowD[col] = getName(piece: state[row][col])
                rowE[col] = getName(piece: state[row][col])
                rowF[col] = getName(piece: state[row][col])
                rowG[col] = getName(piece: state[row][col])
                rowH[col] = getName(piece: state[row][col])
            }
        }
        //if(self.game!.white){
            //return [rowA, rowB, rowC, rowD, rowE, rowF, rowG, rowH]
        //}
        return [rowH, rowG, rowF, rowE, rowD, rowC, rowB, rowA]
    }
    
    func getPiece(name: String) -> Piece? {
        switch name {
            /***/
        case "KnightWhite":
            return KnightWhite()
        case "KnightBlack":
            return KnightBlack()
            /***/
        case "RookWhite":
            return RookWhite()
        case "RookBlack":
            return RookBlack()
            /***/
        case "PawnWhite":
            return PawnWhite()
        case "PawnBlack":
            return PawnBlack()
            /***/
        case "BishopWhite":
            return BishopWhite()
        case "BishopBlack":
            return BishopBlack()
            /***/
        case "QueenWhite":
            return QueenWhite()
        case "QueenBlack":
            return QueenBlack()
            /***/
        case "KingWhite":
            return KingWhite()
        case "KingBlack":
            return KingBlack()
            /***/
        default:
            return nil
        }
        
    }
    
}
