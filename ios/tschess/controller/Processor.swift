//
//  Processor.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class Processor { //TODO: doesnt need to be its own class...
    
    public func execute(present: [Int], proposed: [Int], gamestate: Gamestate) {
        var tschessElementMatrix = gamestate.getTschessElementMatrix()
        let elementPresent = tschessElementMatrix[present[0]][present[1]]!
        let elementPropose = tschessElementMatrix[proposed[0]][proposed[1]]
        if(self.validateElement(candidate: elementPropose)){
            tschessElementMatrix[present[0]][present[1]] = nil
            tschessElementMatrix[proposed[0]][proposed[1]] = elementPresent
            gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
        }
        
    }
    
    public func validateElement(candidate: TschessElement?) -> Bool {
        if(candidate == nil){
            return false
        }
        if(candidate!.isTarget){
            return true
        }
        if(candidate!.name == "LegalMove"){
            return true
        }
        return false
    }
    
}
