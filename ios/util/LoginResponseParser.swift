//
//  LoginResponseParser.swift
//  ios
//
//  Created by Matthew on 9/9/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation
class LoginResponseParser {
    
    public func generateFairyElementList(fairyElementStringArray: [String])  -> [FairyElement] {
        var elementSquadList = [FairyElement]()
        for elementString in fairyElementStringArray {
            elementSquadList.append(generateFairyElement(name: elementString)!)
        }
        return elementSquadList
    }
    
    func generateFairyElement(name: String) -> FairyElement? {
        if(name.lowercased().contains("Arrow".lowercased())){
            return ArrowPawn()
        }
        if(name.lowercased().contains("Grasshopper".lowercased())){
            return Grasshopper()
        }
        if(name.lowercased().contains("Hunter".lowercased())){
            return Hunter()
        }
        if(name.lowercased().contains("Landmine".lowercased())){
            return LandminePawn()
        }
        if(name.lowercased().contains("Medusa".lowercased())){
            return Medusa()
        }
        if(name.lowercased().contains("Spy".lowercased())){
            return Spy()
        }
        if(name.lowercased().contains("Amazon".lowercased())){
            return Amazon()
        }
        return nil
    }
    
}
