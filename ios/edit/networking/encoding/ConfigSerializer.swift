//
//  ConfigSerializer.swift
//  ios
//
//  Created by Matthew on 11/6/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class ConfigSerializer {
    
    public func serializeConfiguration(savedConfigurationMatrix: [[TschessElement?]]) -> [[String]] {
        let row0 = savedConfigurationMatrix[0]
        let row1 = savedConfigurationMatrix[1]
        
        var gamestateRow0 = Array(repeating: "", count: 8)
        var gamestateRow1 = Array(repeating: "", count: 8)
        
        for i in (0 ..< 8) {
            if (row0[i] != nil) {
                gamestateRow0[i] = row0[i]!.name
            }
        }
        for i in (0 ..< 8) {
            if (row1[i] != nil) {
                gamestateRow1[i] = row1[i]!.name
            }
        }
        return [gamestateRow1, gamestateRow0]
    }
    
}
