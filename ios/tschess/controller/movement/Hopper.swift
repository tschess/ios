//
//  Hopper.swift
//  ios
//
//  Created by Matthew on 10/14/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class Hopper {
    
    func allClear(indexSquare: TschessElement?) -> Bool {
        if(indexSquare == nil){
            return true
        }
        if(indexSquare!.name == "LegalMove"){
            return true
        }
        return false
    }
    
//    func direction_UP(present: [Int], proposed: [Int], gamestate: Gamestate, affiliation: String) -> Bool {
//        var collection: Array<[Int]> = Array<[Int]>()
//        if(present[1] - proposed[1] != 0){
//            return false
//        }
//        let proposed0 = proposed[0]
//        let present0 = present[0]
//        if(present0 <= proposed0){
//            return false
//        }
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if(!allClear(indexSquare: tschessElementMatrix[proposed[0]][proposed[1]])){
//            return false
//        }
//        var squaresHopped: Int = 0
//        var squaresGlide: Int = 0
//        let present_UP = present0 - 1
//        if(!bounded(coordinate: present_UP)){
//            return false
//        }
//        for index in stride(from: proposed0, through: present_UP, by: 1) {
//            let indexSquare = tschessElementMatrix[index][present[1]]
//            if(!allClear(indexSquare: indexSquare)){ //you need to jump here...
//                if(indexSquare!.affiliation == affiliation){
//                    return false
//                }
//                indexSquare!.setHopped()
//                collection.append([index,present[1]])
//                let indexSquareAdjacent_Nxt_index = index - 1
//                if(!bounded(coordinate: indexSquareAdjacent_Nxt_index)){
//                    return false
//                }
//                let indexSquareNxt = tschessElementMatrix[indexSquareAdjacent_Nxt_index][present[1]]
//                if(!allClear(indexSquare: indexSquareNxt)){
//                    return false
//                }
//                if(squaresGlide > 1){
//                    return false
//                }
//                squaresHopped += 1
//                squaresGlide = 0
//                continue
//            }
//            if(squaresGlide > 1 && squaresHopped > 1){
//                return false
//            }
//            squaresGlide += 1
//            continue
//        }
//        gamestate.dict[proposed] = collection
//        return true
//    }
    
//    func direction_DOWN(present: [Int], proposed: [Int], gamestate: Gamestate, affiliation: String) -> Bool {
//        var collection: Array<[Int]> = Array<[Int]>()
//        if(present[1] - proposed[1] != 0){
//            return false
//        }
//        let proposed0 = proposed[0]
//        let present0 = present[0]
//        if(present0 >= proposed0){
//            return false
//        }
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if(!allClear(indexSquare: tschessElementMatrix[proposed[0]][proposed[1]])){
//            return false
//        }
//        var squaresHopped: Int = 0
//        var squaresGlide: Int = 0
//        let present_DOWN = present0 + 1
//        if(!bounded(coordinate: present_DOWN)){
//            return false
//        }
//        for index in stride(from: proposed0, through: present_DOWN, by: -1) {
//            let indexSquare = tschessElementMatrix[index][present[1]]
//            if(!allClear(indexSquare: indexSquare)){ //you need to jump here...
//                if(indexSquare!.affiliation == affiliation){
//                    return false
//                }
//                indexSquare!.setHopped()
//                collection.append([index,present[1]])
//                let indexSquareAdjacent_Nxt_index = index + 1
//                if(!bounded(coordinate: indexSquareAdjacent_Nxt_index)){
//                    return false
//                }
//                let indexSquareNxt = tschessElementMatrix[indexSquareAdjacent_Nxt_index][present[1]]
//                if(!allClear(indexSquare: indexSquareNxt)){
//                    return false
//                }
//                if(squaresGlide > 1){
//                    return false
//                }
//                squaresHopped += 1
//                squaresGlide = 0
//                continue
//            }
//            if(squaresGlide > 1 && squaresHopped > 1){
//                return false
//            }
//            squaresGlide += 1
//            continue
//        }
//        gamestate.dict[proposed] = collection
//        return true
//    }
    
//    func direction_LEFT(present: [Int], proposed: [Int], gamestate: Gamestate, affiliation: String) -> Bool {
//        var collection: Array<[Int]> = Array<[Int]>()
//        if(present[0] - proposed[0] != 0){
//            return false
//        }
//        let proposed1 = proposed[1]
//        let present1 = present[1]
//        if(present1 <= proposed1){
//            return false
//        }
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if(!allClear(indexSquare: tschessElementMatrix[proposed[0]][proposed[1]])){
//            return false
//        }
//        var squaresHopped: Int = 0
//        var squaresGlide: Int = 0
//        let present_UP = present1 - 1
//        if(!bounded(coordinate: present_UP)){
//            return false
//        }
//        for index in stride(from: proposed1, through: present_UP, by: 1) {
//            let indexSquare = tschessElementMatrix[present[0]][index]
//            if(!allClear(indexSquare: indexSquare)){ //you need to jump here...
//                //if(indexSquare!.affiliation == gamestate.getSelfAffiliation()){
//                if(indexSquare!.affiliation == affiliation){
//                    return false
//                }
//                indexSquare!.setHopped()
//                collection.append([present[0],index])
//                
//                let indexSquareAdjacent_Nxt_index = index - 1
//                if(!bounded(coordinate: indexSquareAdjacent_Nxt_index)){
//                    return false
//                }
//                let indexSquareNxt = tschessElementMatrix[present[0]][indexSquareAdjacent_Nxt_index]
//                if(!allClear(indexSquare: indexSquareNxt)){
//                    return false
//                }
//                if(squaresGlide > 1){
//                    return false
//                }
//                squaresHopped += 1
//                squaresGlide = 0
//                continue
//            }
//            if(squaresGlide > 1 && squaresHopped > 1){
//                return false
//            }
//            squaresGlide += 1
//            continue
//        }
//        gamestate.dict[proposed] = collection
//        return true
//    }
    
//    func direction_RIGHT(present: [Int], proposed: [Int], gamestate: Gamestate, affiliation: String) -> Bool {
//        var collection: Array<[Int]> = Array<[Int]>()
//        if(present[0] - proposed[0] != 0){
//            return false
//        }
//        let proposed1 = proposed[1]
//        let present1 = present[1]
//        if(present1 >= proposed1){
//            return false
//        }
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if(!allClear(indexSquare: tschessElementMatrix[proposed[0]][proposed[1]])){
//            return false
//        }
//        var squaresHopped: Int = 0
//        var squaresGlide: Int = 0
//        let present_UP = present1 + 1
//        if(!bounded(coordinate: present_UP)){
//            return false
//        }
//        for index in stride(from: proposed1, through: present_UP, by: -1) {
//            let indexSquare = tschessElementMatrix[present[0]][index]
//            if(!allClear(indexSquare: indexSquare)){ //you need to jump here...
//                //if(indexSquare!.affiliation == gamestate.getSelfAffiliation()){
//                if(indexSquare!.affiliation == affiliation){
//                    return false
//                }
//                indexSquare!.setHopped()
//                collection.append([present[0],index])
//                
//                let indexSquareAdjacent_Nxt_index = index + 1
//                if(!bounded(coordinate: indexSquareAdjacent_Nxt_index)){
//                    return false
//                }
//                let indexSquareNxt = tschessElementMatrix[present[0]][indexSquareAdjacent_Nxt_index]
//                if(!allClear(indexSquare: indexSquareNxt)){
//                    return false
//                }
//                if(squaresGlide > 1){
//                    return false
//                }
//                squaresHopped += 1
//                squaresGlide = 0
//                continue
//            }
//            if(squaresGlide > 1 && squaresHopped > 1){
//                return false
//            }
//            squaresGlide += 1
//            continue
//        }
//        gamestate.dict[proposed] = collection
//        return true
//    }
    
    func bounded(coordinate: Int) -> Bool {
        return coordinate >= 0 && coordinate <= 7
    }
    
}
