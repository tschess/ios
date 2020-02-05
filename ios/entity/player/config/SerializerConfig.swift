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
        return [row0, row1]
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
        default:
            return nil
        }
        
    }
    
}

