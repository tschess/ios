//
//  Hopped.swift
//  ios
//
//  Created by Matthew on 12/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Hopped {
    
    public func evaluate(coordinate: [Int], proposed: [Int], gamestate: Gamestate) -> Bool {
        var tschessElementMatrix = gamestate.getTschessElementMatrix()
        let elementGrasshopper: TschessElement? = tschessElementMatrix[coordinate[0]][coordinate[1]]
        if(elementGrasshopper == nil){
            return false
        }
        if(!elementGrasshopper!.name.contains("Grasshopper")){
            return false
        }
        let elementDestination: TschessElement? = tschessElementMatrix[proposed[0]][proposed[1]]
        if(elementDestination == nil){
            return false
        }
        if(!elementDestination!.name.contains("LegalMove")){
            return false
        }
        var destination: [Int]?
        let orientation = gamestate.getOrientationBlack()
        if(orientation){
            destination = [7-proposed[0],7-proposed[1]]
        } else {
            destination = [proposed[0],proposed[1]]
        }
        let keyExists = gamestate.dict[destination!] != nil
        if(keyExists){
            for coord in gamestate.dict[destination!]! {
                if(orientation){
                    tschessElementMatrix[7-coord[0]][7-coord[1]] = nil
                    gamestate.setDrawProposer(drawProposer: "HOPPED")
                } else {
                    tschessElementMatrix[coord[0]][coord[1]] = nil
                    gamestate.setDrawProposer(drawProposer: "HOPPED")
                }
            }
        }
        let imageDefault = elementGrasshopper!.getImageDefault()
        elementGrasshopper!.setImageVisible(imageVisible: imageDefault)
        tschessElementMatrix[proposed[0]][proposed[1]] = elementGrasshopper
        tschessElementMatrix[coordinate[0]][coordinate[1]] = nil
        gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
        gamestate.setHighlight(coords: [proposed[0],proposed[1],coordinate[0],coordinate[1]])
        return true
    }
    
}
