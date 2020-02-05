//
//  Hunter.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Hunter: FairyElement {
    
    let diagonal = Diagonal()
    
    init(
        name: String = "Hunter",
        imageDefault: UIImage = UIImage(named: "red_hunter")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "6",
            affiliation: affiliation,
            description: "moves forward as bishop. moves backward as a knight.",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Diagonal", "Knight"]),
            tschxValue: String(4),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    
//    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) -> Bool {
//
//            // forward bishop moves...
//            let tschessElementMatrix = gamestate.getTschessElementMatrix()
//            if(diagonal.minusPlus(present: present, proposed: proposed, gamestate: gamestate)){
//                if(tschessElementMatrix[proposed[0]][proposed[1]] == nil){
//                    return true
//                } else {
//                    return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
//                        tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
//                }
//            }
//            if(diagonal.minusMinus(present: present, proposed: proposed, gamestate: gamestate)){
//                if(tschessElementMatrix[proposed[0]][proposed[1]] == nil){
//                    return true
//                } else {
//                    return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
//                        tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
//                }
//            }
//            // backwards knight moves...
//            if(plusTwo_minusOne(present: present, proposed: proposed, gamestate: gamestate)){
//                return true
//            }
//            if(plusTwo_plusOne(present: present, proposed: proposed, gamestate: gamestate)){
//                return true
//            }
//            if(plusOne_minusTwo(present: present, proposed: proposed, gamestate: gamestate)){
//                return true
//            }
//            if(plusOne_plusTwo(present: present, proposed: proposed, gamestate: gamestate)){
//                return true
//            }
//
//
//        return false
//    }
    
//    public func plusTwo_minusOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] + 2) - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0){
//            if(tschessElementMatrix[present[0] + 2][present[1] - 1] != nil) {
//                return tschessElementMatrix[present[0] + 2][present[1] - 1]!.affiliation !=
//                    tschessElementMatrix[present[0]][present[1]]!.affiliation
//            }
//            return true
//        }
//        return false
//    }

//    public func plusTwo_plusOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] + 2) - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0){
//            if(tschessElementMatrix[present[0] + 2][present[1] + 1] != nil) {
//                return tschessElementMatrix[present[0] + 2][present[1] + 1]!.affiliation !=
//                    tschessElementMatrix[present[0]][present[1]]!.affiliation
//            }
//            return true
//        }
//        return false
//    }
    
//    public func plusOne_minusTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] + 1) - proposed[0] == 0 && (present[1] - 2) - proposed[1] == 0){
//            if(tschessElementMatrix[present[0] + 1][present[1] - 2] != nil) {
//                return tschessElementMatrix[present[0] + 1][present[1] - 2]!.affiliation !=
//                    tschessElementMatrix[present[0]][present[1]]!.affiliation
//            }
//            return true
//        }
//        return false
//    }
    
    
//    public func plusOne_plusTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] + 1) - proposed[0] == 0 && (present[1] + 2) - proposed[1] == 0){
//            if(tschessElementMatrix[present[0] + 1][present[1] + 2] != nil) {
//                return tschessElementMatrix[present[0] + 1][present[1] + 2]!.affiliation !=
//                    tschessElementMatrix[present[0]][present[1]]!.affiliation
//            }
//            return true
//        }
//        return false
//    }
    
//    public func minusTwo_minusOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] - 2) - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0){
//            if(tschessElementMatrix[present[0] - 2][present[1] - 1] != nil) {
//                return tschessElementMatrix[present[0] - 2][present[1] - 1]!.affiliation !=
//                    tschessElementMatrix[present[0]][present[1]]!.affiliation
//            }
//            return true
//        }
//        return false
//    }

//    public func minusTwo_plusOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] - 2) - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0){
//            if(tschessElementMatrix[present[0] - 2][present[1] + 1] != nil) {
//                return tschessElementMatrix[present[0] - 2][present[1] + 1]!.affiliation !=
//                    tschessElementMatrix[present[0]][present[1]]!.affiliation
//            }
//            return true
//        }
//        return false
//    }
  
//    public func minusOne_minusTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] - 1) - proposed[0] == 0 && (present[1] - 2) - proposed[1] == 0){
//            if(tschessElementMatrix[present[0] - 1][present[1] - 2] != nil) {
//                return tschessElementMatrix[present[0] - 1][present[1] - 2]!.affiliation !=
//                    tschessElementMatrix[present[0]][present[1]]!.affiliation
//            }
//            return true
//        }
//        return false
//    }
    
//    public func minusOne_plusTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] - 1) - proposed[0] == 0 && (present[1] + 2) - proposed[1] == 0){
//            if(tschessElementMatrix[present[0] - 1][present[1] + 2] != nil) {
//                return tschessElementMatrix[present[0] - 1][present[1] + 2]!.affiliation !=
//                    tschessElementMatrix[present[0]][present[1]]!.affiliation
//            }
//            return true
//        }
//        return false
//    }
    
    public override func getBezierPath() -> UIBezierPath {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 48.68, y: 2.31))
        bezierPath.addCurve(to: CGPoint(x: 42.01, y: 12.28), controlPoint1: CGPoint(x: 44.78, y: 6.06), controlPoint2: CGPoint(x: 43.06, y: 8.76))
        bezierPath.addCurve(to: CGPoint(x: 40.51, y: 15.58), controlPoint1: CGPoint(x: 41.41, y: 14.08), controlPoint2: CGPoint(x: 40.81, y: 15.58))
        bezierPath.addCurve(to: CGPoint(x: 38.63, y: 21.58), controlPoint1: CGPoint(x: 40.28, y: 15.58), controlPoint2: CGPoint(x: 39.38, y: 18.28))
        bezierPath.addCurve(to: CGPoint(x: 35.56, y: 28.03), controlPoint1: CGPoint(x: 37.43, y: 26.53), controlPoint2: CGPoint(x: 36.91, y: 27.73))
        bezierPath.addCurve(to: CGPoint(x: 23.63, y: 24.96), controlPoint1: CGPoint(x: 33.46, y: 28.56), controlPoint2: CGPoint(x: 25.06, y: 26.38))
        bezierPath.addCurve(to: CGPoint(x: 21.76, y: 23.83), controlPoint1: CGPoint(x: 22.96, y: 24.36), controlPoint2: CGPoint(x: 22.13, y: 23.83))
        bezierPath.addCurve(to: CGPoint(x: 17.86, y: 20.61), controlPoint1: CGPoint(x: 21.38, y: 23.83), controlPoint2: CGPoint(x: 19.58, y: 22.41))
        bezierPath.addCurve(to: CGPoint(x: 8.56, y: 15.58), controlPoint1: CGPoint(x: 13.88, y: 16.48), controlPoint2: CGPoint(x: 12.16, y: 15.58))
        bezierPath.addCurve(to: CGPoint(x: 1.21, y: 18.66), controlPoint1: CGPoint(x: 4.13, y: 15.58), controlPoint2: CGPoint(x: 2.33, y: 16.33))
        bezierPath.addCurve(to: CGPoint(x: 3.53, y: 35.31), controlPoint1: CGPoint(x: -1.04, y: 22.86), controlPoint2: CGPoint(x: 0.46, y: 33.58))
        bezierPath.addCurve(to: CGPoint(x: 4.58, y: 36.96), controlPoint1: CGPoint(x: 4.13, y: 35.61), controlPoint2: CGPoint(x: 4.58, y: 36.36))
        bezierPath.addCurve(to: CGPoint(x: 5.93, y: 38.98), controlPoint1: CGPoint(x: 4.58, y: 37.56), controlPoint2: CGPoint(x: 5.18, y: 38.46))
        bezierPath.addCurve(to: CGPoint(x: 8.63, y: 42.28), controlPoint1: CGPoint(x: 6.68, y: 39.51), controlPoint2: CGPoint(x: 7.88, y: 41.01))
        bezierPath.addCurve(to: CGPoint(x: 12.53, y: 45.96), controlPoint1: CGPoint(x: 9.38, y: 43.56), controlPoint2: CGPoint(x: 11.18, y: 45.21))
        bezierPath.addCurve(to: CGPoint(x: 15.08, y: 47.91), controlPoint1: CGPoint(x: 13.96, y: 46.71), controlPoint2: CGPoint(x: 15.08, y: 47.61))
        bezierPath.addCurve(to: CGPoint(x: 17.33, y: 49.71), controlPoint1: CGPoint(x: 15.08, y: 48.28), controlPoint2: CGPoint(x: 16.06, y: 49.03))
        bezierPath.addCurve(to: CGPoint(x: 18.61, y: 53.61), controlPoint1: CGPoint(x: 19.73, y: 50.91), controlPoint2: CGPoint(x: 20.26, y: 52.63))
        bezierPath.addCurve(to: CGPoint(x: 16.21, y: 58.71), controlPoint1: CGPoint(x: 18.08, y: 53.91), controlPoint2: CGPoint(x: 16.96, y: 56.23))
        bezierPath.addCurve(to: CGPoint(x: 14.26, y: 63.58), controlPoint1: CGPoint(x: 15.38, y: 61.18), controlPoint2: CGPoint(x: 14.48, y: 63.36))
        bezierPath.addCurve(to: CGPoint(x: 14.26, y: 101.83), controlPoint1: CGPoint(x: 11.48, y: 65.83), controlPoint2: CGPoint(x: 11.56, y: 99.81))
        bezierPath.addCurve(to: CGPoint(x: 16.13, y: 106.48), controlPoint1: CGPoint(x: 14.56, y: 102.06), controlPoint2: CGPoint(x: 15.38, y: 104.16))
        bezierPath.addCurve(to: CGPoint(x: 17.93, y: 110.83), controlPoint1: CGPoint(x: 16.88, y: 108.88), controlPoint2: CGPoint(x: 17.71, y: 110.83))
        bezierPath.addCurve(to: CGPoint(x: 19.81, y: 114.13), controlPoint1: CGPoint(x: 18.23, y: 110.83), controlPoint2: CGPoint(x: 19.06, y: 112.33))
        bezierPath.addCurve(to: CGPoint(x: 22.28, y: 117.88), controlPoint1: CGPoint(x: 20.56, y: 115.93), controlPoint2: CGPoint(x: 21.68, y: 117.66))
        bezierPath.addCurve(to: CGPoint(x: 23.33, y: 119.38), controlPoint1: CGPoint(x: 22.88, y: 118.11), controlPoint2: CGPoint(x: 23.33, y: 118.78))
        bezierPath.addCurve(to: CGPoint(x: 24.68, y: 121.48), controlPoint1: CGPoint(x: 23.33, y: 119.98), controlPoint2: CGPoint(x: 23.93, y: 120.96))
        bezierPath.addCurve(to: CGPoint(x: 27.38, y: 124.71), controlPoint1: CGPoint(x: 25.36, y: 122.01), controlPoint2: CGPoint(x: 26.63, y: 123.43))
        bezierPath.addCurve(to: CGPoint(x: 32.63, y: 129.58), controlPoint1: CGPoint(x: 28.96, y: 127.11), controlPoint2: CGPoint(x: 31.51, y: 129.51))
        bezierPath.addCurve(to: CGPoint(x: 34.73, y: 131.46), controlPoint1: CGPoint(x: 32.93, y: 129.58), controlPoint2: CGPoint(x: 33.91, y: 130.41))
        bezierPath.addCurve(to: CGPoint(x: 37.28, y: 133.33), controlPoint1: CGPoint(x: 35.56, y: 132.51), controlPoint2: CGPoint(x: 36.68, y: 133.33))
        bezierPath.addCurve(to: CGPoint(x: 38.33, y: 134.08), controlPoint1: CGPoint(x: 37.88, y: 133.33), controlPoint2: CGPoint(x: 38.33, y: 133.63))
        bezierPath.addCurve(to: CGPoint(x: 40.96, y: 136.03), controlPoint1: CGPoint(x: 38.33, y: 134.46), controlPoint2: CGPoint(x: 39.53, y: 135.36))
        bezierPath.addCurve(to: CGPoint(x: 43.58, y: 137.83), controlPoint1: CGPoint(x: 42.38, y: 136.71), controlPoint2: CGPoint(x: 43.58, y: 137.53))
        bezierPath.addCurve(to: CGPoint(x: 47.93, y: 139.78), controlPoint1: CGPoint(x: 43.58, y: 138.06), controlPoint2: CGPoint(x: 45.53, y: 138.96))
        bezierPath.addCurve(to: CGPoint(x: 52.66, y: 141.81), controlPoint1: CGPoint(x: 50.26, y: 140.53), controlPoint2: CGPoint(x: 52.43, y: 141.43))
        bezierPath.addCurve(to: CGPoint(x: 74.33, y: 144.81), controlPoint1: CGPoint(x: 53.71, y: 143.23), controlPoint2: CGPoint(x: 64.73, y: 144.81))
        bezierPath.addCurve(to: CGPoint(x: 96.01, y: 141.81), controlPoint1: CGPoint(x: 83.93, y: 144.81), controlPoint2: CGPoint(x: 94.96, y: 143.23))
        bezierPath.addCurve(to: CGPoint(x: 100.81, y: 139.78), controlPoint1: CGPoint(x: 96.23, y: 141.43), controlPoint2: CGPoint(x: 98.41, y: 140.53))
        bezierPath.addCurve(to: CGPoint(x: 105.08, y: 137.83), controlPoint1: CGPoint(x: 103.13, y: 138.96), controlPoint2: CGPoint(x: 105.08, y: 138.06))
        bezierPath.addCurve(to: CGPoint(x: 107.71, y: 136.03), controlPoint1: CGPoint(x: 105.08, y: 137.53), controlPoint2: CGPoint(x: 106.28, y: 136.71))
        bezierPath.addCurve(to: CGPoint(x: 110.33, y: 134.08), controlPoint1: CGPoint(x: 109.13, y: 135.36), controlPoint2: CGPoint(x: 110.33, y: 134.46))
        bezierPath.addCurve(to: CGPoint(x: 111.38, y: 133.33), controlPoint1: CGPoint(x: 110.33, y: 133.63), controlPoint2: CGPoint(x: 110.78, y: 133.33))
        bezierPath.addCurve(to: CGPoint(x: 113.93, y: 131.46), controlPoint1: CGPoint(x: 111.98, y: 133.33), controlPoint2: CGPoint(x: 113.11, y: 132.51))
        bezierPath.addCurve(to: CGPoint(x: 116.03, y: 129.58), controlPoint1: CGPoint(x: 114.76, y: 130.41), controlPoint2: CGPoint(x: 115.73, y: 129.58))
        bezierPath.addCurve(to: CGPoint(x: 121.28, y: 124.71), controlPoint1: CGPoint(x: 117.16, y: 129.51), controlPoint2: CGPoint(x: 119.71, y: 127.11))
        bezierPath.addCurve(to: CGPoint(x: 123.98, y: 121.48), controlPoint1: CGPoint(x: 122.03, y: 123.43), controlPoint2: CGPoint(x: 123.31, y: 122.01))
        bezierPath.addCurve(to: CGPoint(x: 125.33, y: 119.38), controlPoint1: CGPoint(x: 124.73, y: 120.96), controlPoint2: CGPoint(x: 125.33, y: 119.98))
        bezierPath.addCurve(to: CGPoint(x: 126.38, y: 117.88), controlPoint1: CGPoint(x: 125.33, y: 118.78), controlPoint2: CGPoint(x: 125.78, y: 118.11))
        bezierPath.addCurve(to: CGPoint(x: 128.86, y: 114.13), controlPoint1: CGPoint(x: 126.98, y: 117.66), controlPoint2: CGPoint(x: 128.11, y: 115.93))
        bezierPath.addCurve(to: CGPoint(x: 130.73, y: 110.83), controlPoint1: CGPoint(x: 129.61, y: 112.33), controlPoint2: CGPoint(x: 130.43, y: 110.83))
        bezierPath.addCurve(to: CGPoint(x: 132.53, y: 106.48), controlPoint1: CGPoint(x: 130.96, y: 110.83), controlPoint2: CGPoint(x: 131.78, y: 108.88))
        bezierPath.addCurve(to: CGPoint(x: 134.41, y: 101.83), controlPoint1: CGPoint(x: 133.28, y: 104.16), controlPoint2: CGPoint(x: 134.11, y: 102.06))
        bezierPath.addCurve(to: CGPoint(x: 134.41, y: 63.58), controlPoint1: CGPoint(x: 137.11, y: 99.81), controlPoint2: CGPoint(x: 137.18, y: 65.83))
        bezierPath.addCurve(to: CGPoint(x: 132.46, y: 58.71), controlPoint1: CGPoint(x: 134.18, y: 63.36), controlPoint2: CGPoint(x: 133.28, y: 61.18))
        bezierPath.addCurve(to: CGPoint(x: 130.06, y: 53.61), controlPoint1: CGPoint(x: 131.71, y: 56.23), controlPoint2: CGPoint(x: 130.58, y: 53.91))
        bezierPath.addCurve(to: CGPoint(x: 131.33, y: 49.71), controlPoint1: CGPoint(x: 128.41, y: 52.63), controlPoint2: CGPoint(x: 128.93, y: 50.91))
        bezierPath.addCurve(to: CGPoint(x: 133.58, y: 47.91), controlPoint1: CGPoint(x: 132.61, y: 49.03), controlPoint2: CGPoint(x: 133.58, y: 48.28))
        bezierPath.addCurve(to: CGPoint(x: 136.13, y: 45.96), controlPoint1: CGPoint(x: 133.58, y: 47.61), controlPoint2: CGPoint(x: 134.71, y: 46.71))
        bezierPath.addCurve(to: CGPoint(x: 140.03, y: 42.28), controlPoint1: CGPoint(x: 137.48, y: 45.21), controlPoint2: CGPoint(x: 139.28, y: 43.56))
        bezierPath.addCurve(to: CGPoint(x: 142.73, y: 38.98), controlPoint1: CGPoint(x: 140.78, y: 41.01), controlPoint2: CGPoint(x: 141.98, y: 39.51))
        bezierPath.addCurve(to: CGPoint(x: 144.08, y: 36.96), controlPoint1: CGPoint(x: 143.48, y: 38.46), controlPoint2: CGPoint(x: 144.08, y: 37.56))
        bezierPath.addCurve(to: CGPoint(x: 145.13, y: 35.31), controlPoint1: CGPoint(x: 144.08, y: 36.36), controlPoint2: CGPoint(x: 144.53, y: 35.61))
        bezierPath.addCurve(to: CGPoint(x: 147.46, y: 18.66), controlPoint1: CGPoint(x: 148.21, y: 33.58), controlPoint2: CGPoint(x: 149.71, y: 22.86))
        bezierPath.addCurve(to: CGPoint(x: 139.88, y: 15.58), controlPoint1: CGPoint(x: 146.26, y: 16.33), controlPoint2: CGPoint(x: 144.53, y: 15.58))
        bezierPath.addCurve(to: CGPoint(x: 130.81, y: 20.76), controlPoint1: CGPoint(x: 136.73, y: 15.58), controlPoint2: CGPoint(x: 132.98, y: 17.76))
        bezierPath.addCurve(to: CGPoint(x: 127.36, y: 23.53), controlPoint1: CGPoint(x: 130.21, y: 21.66), controlPoint2: CGPoint(x: 128.63, y: 22.86))
        bezierPath.addCurve(to: CGPoint(x: 124.58, y: 25.41), controlPoint1: CGPoint(x: 126.01, y: 24.21), controlPoint2: CGPoint(x: 124.81, y: 25.11))
        bezierPath.addCurve(to: CGPoint(x: 113.11, y: 28.03), controlPoint1: CGPoint(x: 123.91, y: 26.38), controlPoint2: CGPoint(x: 114.83, y: 28.48))
        bezierPath.addCurve(to: CGPoint(x: 110.03, y: 21.58), controlPoint1: CGPoint(x: 111.76, y: 27.73), controlPoint2: CGPoint(x: 111.23, y: 26.53))
        bezierPath.addCurve(to: CGPoint(x: 108.16, y: 15.58), controlPoint1: CGPoint(x: 109.28, y: 18.28), controlPoint2: CGPoint(x: 108.38, y: 15.58))
        bezierPath.addCurve(to: CGPoint(x: 106.66, y: 12.21), controlPoint1: CGPoint(x: 107.86, y: 15.58), controlPoint2: CGPoint(x: 107.18, y: 14.08))
        bezierPath.addCurve(to: CGPoint(x: 104.78, y: 8.23), controlPoint1: CGPoint(x: 106.13, y: 10.33), controlPoint2: CGPoint(x: 105.31, y: 8.53))
        bezierPath.addCurve(to: CGPoint(x: 102.53, y: 5.01), controlPoint1: CGPoint(x: 104.33, y: 7.93), controlPoint2: CGPoint(x: 103.28, y: 6.51))
        bezierPath.addCurve(to: CGPoint(x: 92.11, y: -0.17), controlPoint1: CGPoint(x: 100.58, y: 1.26), controlPoint2: CGPoint(x: 97.66, y: -0.17))
        bezierPath.addCurve(to: CGPoint(x: 77.63, y: 2.83), controlPoint1: CGPoint(x: 86.63, y: -0.09), controlPoint2: CGPoint(x: 82.13, y: 0.81))
        bezierPath.addCurve(to: CGPoint(x: 71.33, y: 2.83), controlPoint1: CGPoint(x: 74.71, y: 4.18), controlPoint2: CGPoint(x: 72.31, y: 4.18))
        bezierPath.addCurve(to: CGPoint(x: 56.18, y: -0.17), controlPoint1: CGPoint(x: 70.58, y: 1.71), controlPoint2: CGPoint(x: 60.91, y: -0.17))
        bezierPath.addCurve(to: CGPoint(x: 48.68, y: 2.31), controlPoint1: CGPoint(x: 51.53, y: -0.17), controlPoint2: CGPoint(x: 51.01, y: -0.02))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 56.71, y: 69.21))
        bezierPath.addCurve(to: CGPoint(x: 58.58, y: 72.21), controlPoint1: CGPoint(x: 57.76, y: 70.18), controlPoint2: CGPoint(x: 58.58, y: 71.53))
        bezierPath.addCurve(to: CGPoint(x: 59.33, y: 73.33), controlPoint1: CGPoint(x: 58.58, y: 72.81), controlPoint2: CGPoint(x: 58.96, y: 73.33))
        bezierPath.addCurve(to: CGPoint(x: 59.48, y: 82.48), controlPoint1: CGPoint(x: 60.23, y: 73.33), controlPoint2: CGPoint(x: 60.38, y: 82.11))
        bezierPath.addCurve(to: CGPoint(x: 57.76, y: 84.96), controlPoint1: CGPoint(x: 59.11, y: 82.63), controlPoint2: CGPoint(x: 58.36, y: 83.68))
        bezierPath.addCurve(to: CGPoint(x: 46.73, y: 84.73), controlPoint1: CGPoint(x: 55.66, y: 89.31), controlPoint2: CGPoint(x: 48.83, y: 89.16))
        bezierPath.addCurve(to: CGPoint(x: 45.83, y: 72.43), controlPoint1: CGPoint(x: 45.16, y: 81.58), controlPoint2: CGPoint(x: 44.71, y: 75.21))
        bezierPath.addCurve(to: CGPoint(x: 56.71, y: 69.21), controlPoint1: CGPoint(x: 47.86, y: 67.26), controlPoint2: CGPoint(x: 53.26, y: 65.68))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 100.28, y: 68.68))
        bezierPath.addCurve(to: CGPoint(x: 101.93, y: 84.73), controlPoint1: CGPoint(x: 103.73, y: 71.53), controlPoint2: CGPoint(x: 104.56, y: 79.41))
        bezierPath.addCurve(to: CGPoint(x: 90.91, y: 84.96), controlPoint1: CGPoint(x: 99.83, y: 89.16), controlPoint2: CGPoint(x: 93.01, y: 89.31))
        bezierPath.addCurve(to: CGPoint(x: 89.18, y: 82.48), controlPoint1: CGPoint(x: 90.31, y: 83.68), controlPoint2: CGPoint(x: 89.56, y: 82.56))
        bezierPath.addCurve(to: CGPoint(x: 89.33, y: 73.33), controlPoint1: CGPoint(x: 88.28, y: 82.11), controlPoint2: CGPoint(x: 88.43, y: 73.33))
        bezierPath.addCurve(to: CGPoint(x: 90.08, y: 72.21), controlPoint1: CGPoint(x: 89.78, y: 73.33), controlPoint2: CGPoint(x: 90.08, y: 72.81))
        bezierPath.addCurve(to: CGPoint(x: 91.96, y: 69.21), controlPoint1: CGPoint(x: 90.08, y: 71.53), controlPoint2: CGPoint(x: 90.91, y: 70.18))
        bezierPath.addCurve(to: CGPoint(x: 100.28, y: 68.68), controlPoint1: CGPoint(x: 94.13, y: 66.96), controlPoint2: CGPoint(x: 97.96, y: 66.73))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 47.26, y: 104.08))
        bezierPath.addCurve(to: CGPoint(x: 51.76, y: 106.41), controlPoint1: CGPoint(x: 48.23, y: 104.83), controlPoint2: CGPoint(x: 50.18, y: 105.88))
        bezierPath.addCurve(to: CGPoint(x: 54.91, y: 107.98), controlPoint1: CGPoint(x: 53.26, y: 106.93), controlPoint2: CGPoint(x: 54.68, y: 107.61))
        bezierPath.addCurve(to: CGPoint(x: 61.66, y: 109.93), controlPoint1: CGPoint(x: 55.13, y: 108.36), controlPoint2: CGPoint(x: 58.21, y: 109.18))
        bezierPath.addCurve(to: CGPoint(x: 68.18, y: 111.73), controlPoint1: CGPoint(x: 65.11, y: 110.61), controlPoint2: CGPoint(x: 68.03, y: 111.43))
        bezierPath.addCurve(to: CGPoint(x: 80.33, y: 111.58), controlPoint1: CGPoint(x: 68.56, y: 112.63), controlPoint2: CGPoint(x: 80.33, y: 112.48))
        bezierPath.addCurve(to: CGPoint(x: 82.58, y: 110.83), controlPoint1: CGPoint(x: 80.33, y: 111.13), controlPoint2: CGPoint(x: 81.38, y: 110.83))
        bezierPath.addCurve(to: CGPoint(x: 94.58, y: 107.76), controlPoint1: CGPoint(x: 85.13, y: 110.83), controlPoint2: CGPoint(x: 93.98, y: 108.58))
        bezierPath.addCurve(to: CGPoint(x: 97.81, y: 106.03), controlPoint1: CGPoint(x: 94.81, y: 107.46), controlPoint2: CGPoint(x: 96.23, y: 106.71))
        bezierPath.addCurve(to: CGPoint(x: 101.78, y: 103.71), controlPoint1: CGPoint(x: 99.38, y: 105.43), controlPoint2: CGPoint(x: 101.18, y: 104.38))
        bezierPath.addCurve(to: CGPoint(x: 105.38, y: 103.48), controlPoint1: CGPoint(x: 103.13, y: 102.36), controlPoint2: CGPoint(x: 106.21, y: 102.13))
        bezierPath.addCurve(to: CGPoint(x: 97.21, y: 112.33), controlPoint1: CGPoint(x: 104.26, y: 105.28), controlPoint2: CGPoint(x: 97.73, y: 112.33))
        bezierPath.addCurve(to: CGPoint(x: 93.91, y: 114.43), controlPoint1: CGPoint(x: 96.98, y: 112.33), controlPoint2: CGPoint(x: 95.48, y: 113.31))
        bezierPath.addCurve(to: CGPoint(x: 87.76, y: 117.58), controlPoint1: CGPoint(x: 92.33, y: 115.56), controlPoint2: CGPoint(x: 89.56, y: 116.98))
        bezierPath.addCurve(to: CGPoint(x: 83.93, y: 119.46), controlPoint1: CGPoint(x: 85.96, y: 118.18), controlPoint2: CGPoint(x: 84.23, y: 119.01))
        bezierPath.addCurve(to: CGPoint(x: 74.33, y: 120.21), controlPoint1: CGPoint(x: 83.63, y: 119.91), controlPoint2: CGPoint(x: 79.73, y: 120.21))
        bezierPath.addCurve(to: CGPoint(x: 64.73, y: 119.46), controlPoint1: CGPoint(x: 68.93, y: 120.21), controlPoint2: CGPoint(x: 65.03, y: 119.91))
        bezierPath.addCurve(to: CGPoint(x: 60.91, y: 117.58), controlPoint1: CGPoint(x: 64.43, y: 119.01), controlPoint2: CGPoint(x: 62.71, y: 118.18))
        bezierPath.addCurve(to: CGPoint(x: 56.78, y: 115.71), controlPoint1: CGPoint(x: 59.11, y: 116.98), controlPoint2: CGPoint(x: 57.23, y: 116.16))
        bezierPath.addCurve(to: CGPoint(x: 54.83, y: 114.36), controlPoint1: CGPoint(x: 56.33, y: 115.26), controlPoint2: CGPoint(x: 55.43, y: 114.66))
        bezierPath.addCurve(to: CGPoint(x: 43.28, y: 103.48), controlPoint1: CGPoint(x: 51.76, y: 112.93), controlPoint2: CGPoint(x: 45.46, y: 107.01))
        bezierPath.addCurve(to: CGPoint(x: 47.26, y: 104.08), controlPoint1: CGPoint(x: 42.38, y: 101.98), controlPoint2: CGPoint(x: 45.46, y: 102.43))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        return bezierPath
    }
    
}
