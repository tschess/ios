//
//  Rook.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Rook: TschessElement {
    
    let horizontalVertical = HorizontalVertical()
    
    init(
        name: String = "Rook",
        imageDefault: UIImage = UIImage(named: "red_rook")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
    ) {
        super.init(
            name: name,
            strength: "5",
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: true,
            attackVectorList: Array<String>(["HorizontalVertical"]),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if(horizontalVertical.zeroPlus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(tschessElementMatrix[proposed[0]][proposed[1]]!.name == "LegalMove") {
                return true
            }
            return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
        }
        if(horizontalVertical.zeroMinus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(tschessElementMatrix[proposed[0]][proposed[1]]!.name == "LegalMove") {
                return true
            }
            return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
        }
        if(horizontalVertical.onePlus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(tschessElementMatrix[proposed[0]][proposed[1]]!.name == "LegalMove") {
                return true
            }
            return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
        }
        if(horizontalVertical.oneMinus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(tschessElementMatrix[proposed[0]][proposed[1]]!.name == "LegalMove") {
                return true
            }
            return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
        }
        return false
    }
    
    public override func getBezierPath() -> UIBezierPath {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 12.93, y: 0.68))
        bezierPath.addCurve(to: CGPoint(x: 8.21, y: 2.56), controlPoint1: CGPoint(x: 9.18, y: 0.91), controlPoint2: CGPoint(x: 8.58, y: 1.13))
        bezierPath.addCurve(to: CGPoint(x: 7.08, y: 23.71), controlPoint1: CGPoint(x: 8.06, y: 3.46), controlPoint2: CGPoint(x: 7.53, y: 12.98))
        bezierPath.addCurve(to: CGPoint(x: 3.26, y: 87.46), controlPoint1: CGPoint(x: 5.88, y: 54.08), controlPoint2: CGPoint(x: 5.06, y: 67.88))
        bezierPath.addCurve(to: CGPoint(x: 2.13, y: 101.71), controlPoint1: CGPoint(x: 2.88, y: 91.96), controlPoint2: CGPoint(x: 2.36, y: 98.41))
        bezierPath.addCurve(to: CGPoint(x: 1.46, y: 111.46), controlPoint1: CGPoint(x: 1.91, y: 105.01), controlPoint2: CGPoint(x: 1.61, y: 109.36))
        bezierPath.addCurve(to: CGPoint(x: 0.63, y: 129.83), controlPoint1: CGPoint(x: 1.23, y: 113.48), controlPoint2: CGPoint(x: 0.86, y: 121.81))
        bezierPath.addCurve(to: CGPoint(x: 1.23, y: 145.36), controlPoint1: CGPoint(x: 0.18, y: 142.13), controlPoint2: CGPoint(x: 0.33, y: 144.61))
        bezierPath.addCurve(to: CGPoint(x: 19.76, y: 146.41), controlPoint1: CGPoint(x: 1.98, y: 146.03), controlPoint2: CGPoint(x: 7.46, y: 146.33))
        bezierPath.addCurve(to: CGPoint(x: 38.43, y: 145.36), controlPoint1: CGPoint(x: 34.98, y: 146.56), controlPoint2: CGPoint(x: 37.31, y: 146.41))
        bezierPath.addCurve(to: CGPoint(x: 39.78, y: 86.18), controlPoint1: CGPoint(x: 39.48, y: 144.23), controlPoint2: CGPoint(x: 39.63, y: 138.61))
        bezierPath.addCurve(to: CGPoint(x: 40.38, y: 15.98), controlPoint1: CGPoint(x: 39.86, y: 54.31), controlPoint2: CGPoint(x: 40.16, y: 22.66))
        bezierPath.addCurve(to: CGPoint(x: 27.86, y: 0.23), controlPoint1: CGPoint(x: 41.06, y: -0.82), controlPoint2: CGPoint(x: 41.81, y: 0.01))
        bezierPath.addCurve(to: CGPoint(x: 12.93, y: 0.68), controlPoint1: CGPoint(x: 22.01, y: 0.31), controlPoint2: CGPoint(x: 15.26, y: 0.53))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 96.56, y: 1.73))
        bezier2Path.addCurve(to: CGPoint(x: 94.38, y: 22.58), controlPoint1: CGPoint(x: 95.06, y: 3.38), controlPoint2: CGPoint(x: 94.91, y: 4.73))
        bezier2Path.addCurve(to: CGPoint(x: 93.93, y: 49.96), controlPoint1: CGPoint(x: 94.08, y: 33.08), controlPoint2: CGPoint(x: 93.86, y: 45.38))
        bezier2Path.addCurve(to: CGPoint(x: 94.16, y: 100.66), controlPoint1: CGPoint(x: 94.01, y: 54.46), controlPoint2: CGPoint(x: 94.08, y: 77.33))
        bezier2Path.addCurve(to: CGPoint(x: 94.76, y: 144.01), controlPoint1: CGPoint(x: 94.16, y: 123.98), controlPoint2: CGPoint(x: 94.46, y: 143.48))
        bezier2Path.addCurve(to: CGPoint(x: 133.61, y: 143.71), controlPoint1: CGPoint(x: 95.73, y: 145.58), controlPoint2: CGPoint(x: 124.68, y: 145.36))
        bezier2Path.addCurve(to: CGPoint(x: 135.71, y: 139.73), controlPoint1: CGPoint(x: 136.01, y: 143.26), controlPoint2: CGPoint(x: 136.08, y: 143.18))
        bezier2Path.addCurve(to: CGPoint(x: 134.96, y: 126.46), controlPoint1: CGPoint(x: 135.56, y: 137.78), controlPoint2: CGPoint(x: 135.18, y: 131.86))
        bezier2Path.addCurve(to: CGPoint(x: 132.71, y: 81.46), controlPoint1: CGPoint(x: 134.58, y: 117.76), controlPoint2: CGPoint(x: 133.76, y: 101.63))
        bezier2Path.addCurve(to: CGPoint(x: 130.46, y: 48.83), controlPoint1: CGPoint(x: 132.26, y: 73.36), controlPoint2: CGPoint(x: 130.76, y: 51.46))
        bezier2Path.addCurve(to: CGPoint(x: 129.71, y: 30.08), controlPoint1: CGPoint(x: 130.31, y: 47.78), controlPoint2: CGPoint(x: 130.01, y: 39.38))
        bezier2Path.addCurve(to: CGPoint(x: 129.03, y: 7.81), controlPoint1: CGPoint(x: 129.41, y: 20.78), controlPoint2: CGPoint(x: 129.11, y: 10.81))
        bezier2Path.addCurve(to: CGPoint(x: 127.91, y: 1.28), controlPoint1: CGPoint(x: 128.96, y: 4.73), controlPoint2: CGPoint(x: 128.43, y: 1.96))
        bezier2Path.addCurve(to: CGPoint(x: 112.53, y: 0.08), controlPoint1: CGPoint(x: 127.08, y: 0.23), controlPoint2: CGPoint(x: 124.68, y: 0.08))
        bezier2Path.addCurve(to: CGPoint(x: 96.56, y: 1.73), controlPoint1: CGPoint(x: 98.51, y: 0.08), controlPoint2: CGPoint(x: 98.06, y: 0.16))
        bezier2Path.close()
        fillColor.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 58.08, y: 33.76))
        bezier3Path.addLine(to: CGPoint(x: 47.21, y: 34.21))
        bezier3Path.addLine(to: CGPoint(x: 46.31, y: 37.06))
        bezier3Path.addCurve(to: CGPoint(x: 45.33, y: 72.98), controlPoint1: CGPoint(x: 45.56, y: 39.16), controlPoint2: CGPoint(x: 45.33, y: 48.68))
        bezier3Path.addCurve(to: CGPoint(x: 46.31, y: 107.18), controlPoint1: CGPoint(x: 45.26, y: 100.81), controlPoint2: CGPoint(x: 45.41, y: 106.28))
        bezier3Path.addCurve(to: CGPoint(x: 51.63, y: 102.68), controlPoint1: CGPoint(x: 48.41, y: 109.21), controlPoint2: CGPoint(x: 50.28, y: 107.63))
        bezier3Path.addCurve(to: CGPoint(x: 57.33, y: 92.56), controlPoint1: CGPoint(x: 52.91, y: 98.18), controlPoint2: CGPoint(x: 55.01, y: 94.36))
        bezier3Path.addCurve(to: CGPoint(x: 69.33, y: 90.91), controlPoint1: CGPoint(x: 59.51, y: 90.83), controlPoint2: CGPoint(x: 65.36, y: 90.01))
        bezier3Path.addCurve(to: CGPoint(x: 81.18, y: 105.08), controlPoint1: CGPoint(x: 74.51, y: 92.03), controlPoint2: CGPoint(x: 77.43, y: 95.48))
        bezier3Path.addCurve(to: CGPoint(x: 84.18, y: 107.18), controlPoint1: CGPoint(x: 81.71, y: 106.51), controlPoint2: CGPoint(x: 82.53, y: 107.03))
        bezier3Path.addCurve(to: CGPoint(x: 86.81, y: 103.43), controlPoint1: CGPoint(x: 86.36, y: 107.33), controlPoint2: CGPoint(x: 86.43, y: 107.26))
        bezier3Path.addCurve(to: CGPoint(x: 88.46, y: 52.96), controlPoint1: CGPoint(x: 87.71, y: 95.71), controlPoint2: CGPoint(x: 88.46, y: 72.16))
        bezier3Path.addLine(to: CGPoint(x: 88.46, y: 33.46))
        bezier3Path.addLine(to: CGPoint(x: 78.71, y: 33.38))
        bezier3Path.addCurve(to: CGPoint(x: 58.08, y: 33.76), controlPoint1: CGPoint(x: 73.38, y: 33.38), controlPoint2: CGPoint(x: 64.08, y: 33.53))
        bezier3Path.close()
        fillColor.setFill()
        bezier3Path.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 61.46, y: 134.86))
        bezier4Path.addCurve(to: CGPoint(x: 45.93, y: 136.06), controlPoint1: CGPoint(x: 50.73, y: 135.01), controlPoint2: CGPoint(x: 46.38, y: 135.38))
        bezier4Path.addCurve(to: CGPoint(x: 45.33, y: 140.78), controlPoint1: CGPoint(x: 45.63, y: 136.51), controlPoint2: CGPoint(x: 45.33, y: 138.68))
        bezier4Path.addCurve(to: CGPoint(x: 46.53, y: 145.13), controlPoint1: CGPoint(x: 45.33, y: 143.63), controlPoint2: CGPoint(x: 45.63, y: 144.76))
        bezier4Path.addCurve(to: CGPoint(x: 85.68, y: 145.13), controlPoint1: CGPoint(x: 48.03, y: 145.73), controlPoint2: CGPoint(x: 83.43, y: 145.73))
        bezier4Path.addCurve(to: CGPoint(x: 87.33, y: 140.71), controlPoint1: CGPoint(x: 87.11, y: 144.68), controlPoint2: CGPoint(x: 87.33, y: 144.16))
        bezier4Path.addCurve(to: CGPoint(x: 61.46, y: 134.86), controlPoint1: CGPoint(x: 87.33, y: 134.26), controlPoint2: CGPoint(x: 88.01, y: 134.41))
        bezier4Path.close()
        fillColor.setFill()
        bezier4Path.fill()
        let combined = UIBezierPath()
        combined.append(bezierPath)
        combined.append(bezier2Path)
        combined.append(bezier3Path)
        combined.append(bezier4Path)
        
        return combined
    }
}
