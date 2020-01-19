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
        let row_0 = savedConfigurationMatrix[0]
        let row_1 = savedConfigurationMatrix[1]
        
        var gamestateRow_0 = Array(repeating: "", count: 8)
        var gamestateRow_1 = Array(repeating: "", count: 8)
        
        for i in (0 ..< 8) {
            if (row_0[i] != nil) {
                gamestateRow_0[i] = row_0[i]!.name
            }
        }
        for i in (0 ..< 8) {
            if (row_1[i] != nil) {
                gamestateRow_1[i] = row_1[i]!.name
            }
        }
        return [gamestateRow_0, gamestateRow_1]
    }
    
}
