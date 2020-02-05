//
//  Pawn.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Pawn: TschessElement {
    
    init(
        name: String = "Pawn",
        imageDefault: UIImage = UIImage(named: "red_pawn")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
    ) {
        super.init(
            name: name,
            strength: "1",
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: true,
            attackVectorList: Array<String>(["Pawn"]),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
//    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        if(advanceOne(present: present, proposed: proposed, gamestate: gamestate)) {
//            return true
//        }
//        if(advanceTwo(present: present, proposed: proposed, gamestate: gamestate)) {
//            return true
//        }
//        if(attack(present: present, proposed: proposed, gamestate: gamestate)) {
//            return true
//        }
//        return false
//    }
    
//    public func advanceOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        
//        if((present[0] - 1) - proposed[0] == 0 && (present[1] - proposed[1] == 0)) {
//            if(tschessElementMatrix[present[0] - 1][present[1]] != nil) {
//                if(tschessElementMatrix[present[0] - 1][present[1]]!.name == "LegalMove") {
//                    return true
//                }
//                return false
//            }
//            return true
//        }
//        return false
//    }
    
//    public func advanceTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        if(present[0] != 6){
//            return false
//        }
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        
//        if((present[0] - 2) - proposed[0] == 0 && (present[1] - proposed[1] == 0)) {
//            
//            if(tschessElementMatrix[present[0] - 2][present[1]] != nil) {
//                if(tschessElementMatrix[present[0] - 2][present[1]]!.name != "LegalMove") {
//                    return false
//                }
//            } //it IS nil (2) ...
//            if(tschessElementMatrix[present[0] - 1][present[1]] != nil) {
//                if(tschessElementMatrix[present[0] - 1][present[1]]!.name != "LegalMove") {
//                    return false
//                }
//            } //it IS nil (1)
//            //either they're both legal move or they're both nil...
//            return tschessElementMatrix[present[0]][present[1]]!.firstTouch
//        }
//        return false
//    }
    
//    public func attack(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        if((present[0] - 1) - proposed[0] == 0 && ((present[1] + 1) - proposed[1] == 0)) {
//            if(tschessElementMatrix[present[0] - 1][present[1] + 1] != nil) {
//                if(tschessElementMatrix[present[0] - 1][present[1] + 1]!.name != "LegalMove") {
//                    return tschessElementMatrix[present[0] - 1][present[1] + 1]!.affiliation !=
//                        tschessElementMatrix[present[0]][present[1]]!.affiliation
//                }
//            }
//        }
//        if((present[0] - 1) - proposed[0] == 0 && ((present[1] - 1) - proposed[1] == 0)) {
//            if(tschessElementMatrix[present[0] - 1][present[1] - 1] != nil) {
//                if(tschessElementMatrix[present[0] - 1][present[1] - 1]!.name != "LegalMove") {
//                    return tschessElementMatrix[present[0] - 1][present[1] - 1]!.affiliation !=
//                        tschessElementMatrix[present[0]][present[1]]!.affiliation
//                }
//            }
//        }
//        return false
//    }
    
    public override func getBezierPath() -> UIBezierPath {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 66.43, y: 1.36))
        bezierPath.addCurve(to: CGPoint(x: 62.31, y: 9.46), controlPoint1: CGPoint(x: 65.76, y: 2.11), controlPoint2: CGPoint(x: 63.96, y: 5.71))
        bezierPath.addCurve(to: CGPoint(x: 55.11, y: 22.43), controlPoint1: CGPoint(x: 60.66, y: 13.13), controlPoint2: CGPoint(x: 57.43, y: 18.98))
        bezierPath.addCurve(to: CGPoint(x: 52.63, y: 33.46), controlPoint1: CGPoint(x: 50.38, y: 29.26), controlPoint2: CGPoint(x: 49.86, y: 31.66))
        bezierPath.addCurve(to: CGPoint(x: 66.96, y: 33.83), controlPoint1: CGPoint(x: 54.88, y: 34.96), controlPoint2: CGPoint(x: 56.98, y: 35.03))
        bezierPath.addCurve(to: CGPoint(x: 80.98, y: 33.38), controlPoint1: CGPoint(x: 71.68, y: 33.31), controlPoint2: CGPoint(x: 77.68, y: 33.08))
        bezierPath.addCurve(to: CGPoint(x: 88.03, y: 31.96), controlPoint1: CGPoint(x: 86.61, y: 33.83), controlPoint2: CGPoint(x: 86.83, y: 33.83))
        bezierPath.addCurve(to: CGPoint(x: 84.81, y: 20.48), controlPoint1: CGPoint(x: 89.98, y: 28.96), controlPoint2: CGPoint(x: 89.01, y: 25.51))
        bezierPath.addCurve(to: CGPoint(x: 76.33, y: 7.51), controlPoint1: CGPoint(x: 79.71, y: 14.48), controlPoint2: CGPoint(x: 78.21, y: 12.23))
        bezierPath.addCurve(to: CGPoint(x: 66.43, y: 1.36), controlPoint1: CGPoint(x: 73.63, y: 1.06), controlPoint2: CGPoint(x: 69.13, y: -1.72))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 65.38, y: 38.93))
        bezier2Path.addCurve(to: CGPoint(x: 62.91, y: 42.61), controlPoint1: CGPoint(x: 64.93, y: 39.23), controlPoint2: CGPoint(x: 63.81, y: 40.88))
        bezier2Path.addCurve(to: CGPoint(x: 52.11, y: 49.73), controlPoint1: CGPoint(x: 60.88, y: 46.58), controlPoint2: CGPoint(x: 58.93, y: 47.93))
        bezier2Path.addCurve(to: CGPoint(x: 44.46, y: 52.28), controlPoint1: CGPoint(x: 49.11, y: 50.56), controlPoint2: CGPoint(x: 45.73, y: 51.68))
        bezier2Path.addCurve(to: CGPoint(x: 34.93, y: 66.31), controlPoint1: CGPoint(x: 41.23, y: 53.86), controlPoint2: CGPoint(x: 37.63, y: 59.11))
        bezier2Path.addCurve(to: CGPoint(x: 25.33, y: 82.73), controlPoint1: CGPoint(x: 32.46, y: 72.83), controlPoint2: CGPoint(x: 28.63, y: 79.36))
        bezier2Path.addCurve(to: CGPoint(x: 8.83, y: 92.41), controlPoint1: CGPoint(x: 23.01, y: 85.21), controlPoint2: CGPoint(x: 12.66, y: 91.21))
        bezier2Path.addCurve(to: CGPoint(x: 0.73, y: 99.76), controlPoint1: CGPoint(x: 1.03, y: 94.73), controlPoint2: CGPoint(x: -0.62, y: 96.23))
        bezier2Path.addCurve(to: CGPoint(x: 10.93, y: 100.96), controlPoint1: CGPoint(x: 1.33, y: 101.48), controlPoint2: CGPoint(x: 1.33, y: 101.48))
        bezier2Path.addCurve(to: CGPoint(x: 60.43, y: 100.88), controlPoint1: CGPoint(x: 21.06, y: 100.36), controlPoint2: CGPoint(x: 59.53, y: 100.28))
        bezier2Path.addCurve(to: CGPoint(x: 67.18, y: 102.08), controlPoint1: CGPoint(x: 60.73, y: 101.03), controlPoint2: CGPoint(x: 63.81, y: 101.56))
        bezier2Path.addCurve(to: CGPoint(x: 79.11, y: 104.41), controlPoint1: CGPoint(x: 70.56, y: 102.53), controlPoint2: CGPoint(x: 75.96, y: 103.58))
        bezier2Path.addCurve(to: CGPoint(x: 107.83, y: 108.08), controlPoint1: CGPoint(x: 89.61, y: 107.18), controlPoint2: CGPoint(x: 96.73, y: 108.08))
        bezier2Path.addCurve(to: CGPoint(x: 131.08, y: 102.68), controlPoint1: CGPoint(x: 122.38, y: 108.08), controlPoint2: CGPoint(x: 131.08, y: 106.06))
        bezier2Path.addCurve(to: CGPoint(x: 124.78, y: 94.88), controlPoint1: CGPoint(x: 131.08, y: 99.91), controlPoint2: CGPoint(x: 129.21, y: 97.58))
        bezier2Path.addCurve(to: CGPoint(x: 109.63, y: 76.51), controlPoint1: CGPoint(x: 118.26, y: 90.91), controlPoint2: CGPoint(x: 112.48, y: 83.93))
        bezier2Path.addCurve(to: CGPoint(x: 107.68, y: 72.46), controlPoint1: CGPoint(x: 108.96, y: 74.71), controlPoint2: CGPoint(x: 108.06, y: 72.91))
        bezier2Path.addCurve(to: CGPoint(x: 107.08, y: 70.81), controlPoint1: CGPoint(x: 107.38, y: 72.08), controlPoint2: CGPoint(x: 107.08, y: 71.33))
        bezier2Path.addCurve(to: CGPoint(x: 97.03, y: 52.36), controlPoint1: CGPoint(x: 107.08, y: 67.21), controlPoint2: CGPoint(x: 100.71, y: 55.43))
        bezier2Path.addCurve(to: CGPoint(x: 87.21, y: 47.86), controlPoint1: CGPoint(x: 94.41, y: 50.11), controlPoint2: CGPoint(x: 90.36, y: 48.31))
        bezier2Path.addCurve(to: CGPoint(x: 76.11, y: 45.16), controlPoint1: CGPoint(x: 80.98, y: 46.96), controlPoint2: CGPoint(x: 77.08, y: 45.98))
        bezier2Path.addCurve(to: CGPoint(x: 74.08, y: 41.33), controlPoint1: CGPoint(x: 75.51, y: 44.71), controlPoint2: CGPoint(x: 74.61, y: 42.98))
        bezier2Path.addCurve(to: CGPoint(x: 69.66, y: 38.33), controlPoint1: CGPoint(x: 73.11, y: 38.41), controlPoint2: CGPoint(x: 73.03, y: 38.33))
        bezier2Path.addCurve(to: CGPoint(x: 65.38, y: 38.93), controlPoint1: CGPoint(x: 67.78, y: 38.33), controlPoint2: CGPoint(x: 65.83, y: 38.63))
        bezier2Path.close()
        bezier2Path.move(to: CGPoint(x: 76.33, y: 75.83))
        bezier2Path.addCurve(to: CGPoint(x: 82.93, y: 85.96), controlPoint1: CGPoint(x: 80.31, y: 77.86), controlPoint2: CGPoint(x: 82.56, y: 81.23))
        bezier2Path.addCurve(to: CGPoint(x: 71.46, y: 99.68), controlPoint1: CGPoint(x: 83.53, y: 93.53), controlPoint2: CGPoint(x: 78.88, y: 99.08))
        bezier2Path.addCurve(to: CGPoint(x: 59.31, y: 81.08), controlPoint1: CGPoint(x: 61.18, y: 100.51), controlPoint2: CGPoint(x: 54.58, y: 90.38))
        bezier2Path.addCurve(to: CGPoint(x: 76.33, y: 75.83), controlPoint1: CGPoint(x: 62.38, y: 74.93), controlPoint2: CGPoint(x: 69.96, y: 72.61))
        bezier2Path.close()
        fillColor.setFill()
        bezier2Path.fill()


        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 97.78, y: 111.68))
        bezier3Path.addCurve(to: CGPoint(x: 104.08, y: 126.83), controlPoint1: CGPoint(x: 96.43, y: 113.03), controlPoint2: CGPoint(x: 97.71, y: 116.11))
        bezier3Path.addCurve(to: CGPoint(x: 108.28, y: 133.96), controlPoint1: CGPoint(x: 105.66, y: 129.53), controlPoint2: CGPoint(x: 107.53, y: 132.68))
        bezier3Path.addCurve(to: CGPoint(x: 119.61, y: 147.16), controlPoint1: CGPoint(x: 110.76, y: 138.31), controlPoint2: CGPoint(x: 117.73, y: 146.41))
        bezier3Path.addCurve(to: CGPoint(x: 126.43, y: 146.11), controlPoint1: CGPoint(x: 122.61, y: 148.28), controlPoint2: CGPoint(x: 124.71, y: 147.98))
        bezier3Path.addCurve(to: CGPoint(x: 125.83, y: 129.16), controlPoint1: CGPoint(x: 129.21, y: 143.18), controlPoint2: CGPoint(x: 129.13, y: 140.71))
        bezier3Path.addCurve(to: CGPoint(x: 122.31, y: 115.06), controlPoint1: CGPoint(x: 124.18, y: 123.23), controlPoint2: CGPoint(x: 122.53, y: 116.86))
        bezier3Path.addCurve(to: CGPoint(x: 121.41, y: 111.76), controlPoint1: CGPoint(x: 122.08, y: 113.33), controlPoint2: CGPoint(x: 121.71, y: 111.83))
        bezier3Path.addCurve(to: CGPoint(x: 97.78, y: 111.68), controlPoint1: CGPoint(x: 119.01, y: 111.46), controlPoint2: CGPoint(x: 98.08, y: 111.31))
        bezier3Path.close()
        fillColor.setFill()
        bezier3Path.fill()

        let combined = UIBezierPath()
        combined.append(bezierPath)
        combined.append(bezier2Path)
        combined.append(bezier3Path)
        
        return combined
    }
}
