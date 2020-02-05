//
//  Rook.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Rook: Piece {
    
    let horizontalVertical = HorizontalVertical()
    
    init(
        name: String = "Rook",
        imageDefault: UIImage = UIImage(named: "red_rook")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
    ) {
        super.init(
            name: name,
            strength: "5",
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: true,
            attackVectorList: Array<String>(["HorizontalVertical"]),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        
        if(horizontalVertical.zeroPlus(present: present, proposed: proposed, state: state)){
            if(state[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(state[proposed[0]][proposed[1]]!.name == "PieceAnte") {
                return true
            }
            return state[present[0]][present[1]]!.affiliation !=
                state[proposed[0]][proposed[1]]!.affiliation
        }
        if(horizontalVertical.zeroMinus(present: present, proposed: proposed, state: state)){
            if(state[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(state[proposed[0]][proposed[1]]!.name == "PieceAnte") {
                return true
            }
            return state[present[0]][present[1]]!.affiliation !=
                state[proposed[0]][proposed[1]]!.affiliation
        }
        if(horizontalVertical.onePlus(present: present, proposed: proposed, state: state)){
            if(state[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(state[proposed[0]][proposed[1]]!.name == "PieceAnte") {
                return true
            }
            return state[present[0]][present[1]]!.affiliation !=
                state[proposed[0]][proposed[1]]!.affiliation
        }
        if(horizontalVertical.oneMinus(present: present, proposed: proposed, state: state)){
            if(state[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(state[proposed[0]][proposed[1]]!.name == "PieceAnte") {
                return true
            }
            return state[present[0]][present[1]]!.affiliation !=
                state[proposed[0]][proposed[1]]!.affiliation
        }
        return false
    }
    
}
