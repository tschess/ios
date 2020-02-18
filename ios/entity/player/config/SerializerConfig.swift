//
//  SerializerConfig.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SerializerConfig {
    
    func renderClient(config: [[String]]) -> [[Piece?]] {
        let row0: [Piece?] = self.getPiece(rowA: config[0])
        let row1: [Piece?] = self.getPiece(rowA: config[1])
        return [row1, row0]
    }
    
    func getPiece(rowA: [String]) -> [Piece?] {
        var rowB: [Piece?] = [Piece?](repeating: nil, count: 8)
        for col in (0 ..< 8) {
            rowB[col] = self.getPiece(name: rowA[col])
        }
        return rowB
    }
    
    func getPiece(name: String) -> Piece? {
        switch name {
            /***/
        case "Knight":
            return Knight()
            /***/
        case "Rook":
            return Rook()
            /***/
        case "Pawn":
            return Pawn()
            /***/
        case "Bishop":
            return Bishop()
            /***/
        case "Queen":
            return Queen()
            /***/
        case "King":
            return King()
            /***/
        case "Hunter":
            return Hunter()
            /***/
        case "Amazon":
            return Amazon()
            /***/
        default:
            return nil
        }
    }
    
    func renderServer(config: [[Piece?]]) -> [[String]] {
        var rowA = [String](repeating: "", count: 8)
        var rowB = [String](repeating: "", count: 8)
        for col in (0 ..< 8) {
            rowA[col] = self.getName(piece: config[1][col])
            rowB[col] = self.getName(piece: config[0][col])
        }
        return [rowA, rowB]
    }
    
    
    func getName(piece: Piece?) -> String {
        if(piece == nil){
            return ""
        }
        return piece!.name
    }
    
}

