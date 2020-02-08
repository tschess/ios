//
//  Processor.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class Processor { //TODO: doesnt need to be its own class...
    
    public func execute(present: [Int], proposed: [Int], state: [[Piece?]]) {
        //var tschessElementMatrix = gamestate.getTschessElementMatrix()
        let elementPresent = state[present[0]][present[1]]!
        let elementPropose = state[proposed[0]][proposed[1]]
//        if(self.validateElement(candidate: elementPropose)){
//            state[present[0]][present[1]] = nil
//            state[proposed[0]][proposed[1]] = elementPresent
            //gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//        }
        
    }
    
    
    
}
