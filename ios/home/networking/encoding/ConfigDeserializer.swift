//
//  ConfigDeserializer.swift
//  ios
//
//  Created by Matthew on 11/8/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class ConfigDeserializer {
    
    public func generateTschessElementMatrix(savedConfigurationNestedStringArray: [[String]])  -> [[TschessElement?]] {
        var outputRow_1 = [TschessElement?](repeating: nil, count: 8)
        let row_1 = savedConfigurationNestedStringArray[1]
        outputRow_1 = self.buildConstituentElementList(rowElementStringArray: row_1)
        
        var outputRow_0 = [TschessElement?](repeating: nil, count: 8)
        let row_0 = savedConfigurationNestedStringArray[0]
        outputRow_0 = self.buildConstituentElementList(rowElementStringArray: row_0)
        
        var tschessElementMatrix: [[TschessElement?]]
        tschessElementMatrix = [
            outputRow_0,
            outputRow_1
        ]
        return tschessElementMatrix
    }
    
    func buildConstituentElementList(rowElementStringArray: [String]) -> [TschessElement?] {
        var outputRow = [TschessElement?](repeating: nil, count: 8)
        outputRow[7] = self.generateTschessElement(name: rowElementStringArray[7])
        outputRow[6] = self.generateTschessElement(name: rowElementStringArray[6])
        outputRow[5] = self.generateTschessElement(name: rowElementStringArray[5])
        outputRow[4] = self.generateTschessElement(name: rowElementStringArray[4])
        outputRow[3] = self.generateTschessElement(name: rowElementStringArray[3])
        outputRow[2] = self.generateTschessElement(name: rowElementStringArray[2])
        outputRow[1] = self.generateTschessElement(name: rowElementStringArray[1])
        outputRow[0] = self.generateTschessElement(name: rowElementStringArray[0])
        return outputRow
    }
    
    func generateTschessElement(name: String) -> TschessElement? {
        if(name.contains("Landmine")){
            return LandminePawn()
        }
        if(name.contains("Arrow")){
            return ArrowPawn()
        }
        if(name.contains("Pawn")){
            return Pawn()
        }
        if(name.contains("Knight")){
            return Knight()
        }
        if(name.contains("Bishop")){
            return Bishop()
        }
        if(name.contains("Rook")){
            return Rook()
        }
        if(name.contains("Queen")){
            return Queen()
        }
        if(name.contains("King")){
            return King()
        }
        if(name.contains("Grasshopper")){
            return Grasshopper()
        }
        if(name.contains("Hunter")){
            return Hunter()
        }
        if(name.contains("Medusa")){
            return Medusa()
        }
        if(name.contains("Spy")){
            return Spy()
        }
        if(name.contains("Amazon")){
            return Amazon()
        }
        return nil
    }
    
}
