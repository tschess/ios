//
//  Serialize.swift
//  ios
//
//  Created by Matthew on 11/6/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class MatrixSerializer {
    
    func canonicalGenerator(localMatrix: [[TschessElement?]], orientation: Bool) -> [[TschessElement?]] {
        let rowA = [TschessElement?](repeating: nil, count: 8)
        let rowB = [TschessElement?](repeating: nil, count: 8)
        let rowC = [TschessElement?](repeating: nil, count: 8)
        let rowD = [TschessElement?](repeating: nil, count: 8)
        let rowE = [TschessElement?](repeating: nil, count: 8)
        let rowF = [TschessElement?](repeating: nil, count: 8)
        let rowG = [TschessElement?](repeating: nil, count: 8)
        let rowH = [TschessElement?](repeating: nil, count: 8)
        var tschessElementMatrix: [[TschessElement?]] = [rowA,rowB,rowC,rowD,rowE,rowF,rowG,rowH]
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if(orientation){
                    tschessElementMatrix[i][j] = localMatrix[7-i][7-j]
                    continue
                }
                tschessElementMatrix[i][j] = localMatrix[i][j]
            }
        }
        return tschessElementMatrix
    }
    
    public func serialize(elementRepresentation: [[TschessElement?]], orientationBlack: Bool) -> [[String]] {
        
        let row_A = elementRepresentation[0]
        let row_B = elementRepresentation[1]
        let row_C = elementRepresentation[2]
        let row_D = elementRepresentation[3]
        let row_E = elementRepresentation[4]
        let row_F = elementRepresentation[5]
        let row_G = elementRepresentation[6]
        let row_H = elementRepresentation[7]
        
        var gamestateRow_A = [String](repeating: "", count: 8)
        var gamestateRow_B = [String](repeating: "", count: 8)
        var gamestateRow_C = [String](repeating: "", count: 8)
        var gamestateRow_D = [String](repeating: "", count: 8)
        var gamestateRow_E = [String](repeating: "", count: 8)
        var gamestateRow_F = [String](repeating: "", count: 8)
        var gamestateRow_G = [String](repeating: "", count: 8)
        var gamestateRow_H = [String](repeating: "", count: 8)
        
        for i in (0 ..< 8) {
            var tschessElementName: String = ""
            if (orientationBlack) {
                if (row_A[(7 - i)] != nil) {
                    tschessElementName = row_A[(7 - i)]!.name
                    if(row_A[(7 - i)]!.firstTouch){
                        tschessElementName.append("_x")
                    }
                }
            } else {
                if (row_A[i] != nil) {
                    tschessElementName = row_A[i]!.name
                    if(row_A[i]!.firstTouch){
                        tschessElementName.append("_x")
                    }
                }
            }
            gamestateRow_A[i] = tschessElementName
        }
        for i in (0 ..< 8) {
            var tschessElementName: String = ""
            if (orientationBlack) {
                if (row_B[(7 - i)] != nil) {
                    tschessElementName = row_B[(7 - i)]!.name
                    if(row_B[(7 - i)]!.firstTouch){
                        tschessElementName.append("_x")
                    }
                }
            } else {
                if (row_B[i] != nil) {
                    tschessElementName = row_B[i]!.name
                    if(row_B[i]!.firstTouch){
                        tschessElementName.append("_x")
                    }
                }
            }
            gamestateRow_B[i] = tschessElementName
        }
        for i in (0 ..< 8) {
            var tschessElementName: String = ""
            if (orientationBlack) {
                if (row_C[(7 - i)] != nil) {
                    tschessElementName = row_C[(7 - i)]!.name
                }
            } else {
                if (row_C[i] != nil) {
                    tschessElementName = row_C[i]!.name
                }
            }
            gamestateRow_C[i] = tschessElementName
        }
        for i in (0 ..< 8) {
            var tschessElementName: String = ""
            if (orientationBlack) {
                if (row_D[(7 - i)] != nil) {
                    tschessElementName = row_D[(7 - i)]!.name
                }
            } else {
                if (row_D[i] != nil) {
                    tschessElementName = row_D[i]!.name
                }
            }
            gamestateRow_D[i] = tschessElementName
        }
        for i in (0 ..< 8) {
            var tschessElementName: String = ""
            if (orientationBlack) {
                if (row_E[(7 - i)] != nil) {
                    tschessElementName = row_E[(7 - i)]!.name
                }
            } else {
                if (row_E[i] != nil) {
                    tschessElementName = row_E[i]!.name
                }
            }
            gamestateRow_E[i] = tschessElementName
        }
        for i in (0 ..< 8) {
            var tschessElementName: String = ""
            if (orientationBlack) {
                if (row_F[(7 - i)] != nil) {
                    tschessElementName = row_F[(7 - i)]!.name
                }
            } else {
                if (row_F[i] != nil) {
                    tschessElementName = row_F[i]!.name
                }
            }
            gamestateRow_F[i] = tschessElementName
        }
        for i in (0 ..< 8) {
            var tschessElementName: String = ""
            if (orientationBlack) {
                if (row_G[(7 - i)] != nil) {
                    tschessElementName = row_G[(7 - i)]!.name
                    if(row_G[(7 - i)]!.firstTouch){
                        tschessElementName.append("_x")
                    }
                }
            } else {
                if (row_G[i] != nil) {
                    tschessElementName = row_G[i]!.name
                    if(row_G[i]!.firstTouch){
                        tschessElementName.append("_x")
                    }
                }
            }
            gamestateRow_G[i] = tschessElementName
        }
        for i in (0 ..< 8) {
            var tschessElementName: String = ""
            if (orientationBlack) {
                if (row_H[(7 - i)] != nil) {
                    tschessElementName = row_H[(7 - i)]!.name
                    if(row_H[(7 - i)]!.firstTouch){
                        tschessElementName.append("_x")
                    }
                }
            } else {
                if (row_H[i] != nil) {
                    tschessElementName = row_H[i]!.name
                    if(row_H[i]!.firstTouch){
                        tschessElementName.append("_x")
                    }
                }
            }
            gamestateRow_H[i] = tschessElementName
        }
        var x: [[String]]
        if(orientationBlack){
            x = [
                gamestateRow_H,
                gamestateRow_G,
                gamestateRow_F,
                gamestateRow_E,
                gamestateRow_D,
                gamestateRow_C,
                gamestateRow_B,
                gamestateRow_A
            ]
        } else {
            x = [
                gamestateRow_A,
                gamestateRow_B,
                gamestateRow_C,
                gamestateRow_D,
                gamestateRow_E,
                gamestateRow_F,
                gamestateRow_G,
                gamestateRow_H
            ]
        }
        return x
    }
    
}
