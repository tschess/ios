//
//  Bishop.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Bishop: TschessElement {
    
    let diagonal = Diagonal()
    
    init(
        name: String = "Bishop",
        imageDefault: UIImage = UIImage(named: "red_bishop")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
    ) {
        super.init(
            name: name,
            strength: "3",
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: true,
            attackVectorList: Array<String>(["Diagonal"]),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if(diagonal.plusPlus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(tschessElementMatrix[proposed[0]][proposed[1]]!.name == "LegalMove") {
                return true
            }
            return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
        }
        if(diagonal.minusPlus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(tschessElementMatrix[proposed[0]][proposed[1]]!.name == "LegalMove") {
                return true
            }
            return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
        }
        if(diagonal.plusMinus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil) {
                return true
            }
            if(tschessElementMatrix[proposed[0]][proposed[1]]!.name == "LegalMove") {
                return true
            }
            return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
        }
        if(diagonal.minusMinus(present: present, proposed: proposed, gamestate: gamestate)){
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
        bezierPath.move(to: CGPoint(x: 51.46, y: 1.21))
        bezierPath.addCurve(to: CGPoint(x: 48.31, y: 2.33), controlPoint1: CGPoint(x: 49.81, y: 1.81), controlPoint2: CGPoint(x: 48.38, y: 2.33))
        bezierPath.addCurve(to: CGPoint(x: 46.21, y: 5.11), controlPoint1: CGPoint(x: 48.23, y: 2.33), controlPoint2: CGPoint(x: 47.26, y: 3.61))
        bezierPath.addCurve(to: CGPoint(x: 49.28, y: 20.86), controlPoint1: CGPoint(x: 42.76, y: 10.21), controlPoint2: CGPoint(x: 44.18, y: 17.48))
        bezierPath.addCurve(to: CGPoint(x: 61.43, y: 20.56), controlPoint1: CGPoint(x: 52.13, y: 22.66), controlPoint2: CGPoint(x: 58.81, y: 22.51))
        bezierPath.addCurve(to: CGPoint(x: 66.38, y: 11.33), controlPoint1: CGPoint(x: 65.11, y: 17.86), controlPoint2: CGPoint(x: 66.46, y: 15.23))
        bezierPath.addCurve(to: CGPoint(x: 60.53, y: 1.28), controlPoint1: CGPoint(x: 66.23, y: 6.76), controlPoint2: CGPoint(x: 63.98, y: 2.93))
        bezierPath.addCurve(to: CGPoint(x: 51.46, y: 1.21), controlPoint1: CGPoint(x: 57.46, y: -0.14), controlPoint2: CGPoint(x: 55.36, y: -0.22))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 44.33, y: 27.91))
        bezier2Path.addCurve(to: CGPoint(x: 26.56, y: 42.38), controlPoint1: CGPoint(x: 38.63, y: 31.21), controlPoint2: CGPoint(x: 31.88, y: 36.68))
        bezier2Path.addCurve(to: CGPoint(x: 7.13, y: 68.78), controlPoint1: CGPoint(x: 19.73, y: 49.66), controlPoint2: CGPoint(x: 10.06, y: 62.86))
        bezier2Path.addCurve(to: CGPoint(x: 12.61, y: 75.16), controlPoint1: CGPoint(x: 2.71, y: 78.08), controlPoint2: CGPoint(x: 3.83, y: 79.43))
        bezier2Path.addCurve(to: CGPoint(x: 45.83, y: 66.61), controlPoint1: CGPoint(x: 25.36, y: 68.93), controlPoint2: CGPoint(x: 32.26, y: 67.13))
        bezier2Path.addLine(to: CGPoint(x: 50.71, y: 66.46))
        bezier2Path.addLine(to: CGPoint(x: 51.16, y: 61.21))
        bezier2Path.addCurve(to: CGPoint(x: 52.21, y: 42.01), controlPoint1: CGPoint(x: 51.46, y: 58.28), controlPoint2: CGPoint(x: 51.91, y: 49.66))
        bezier2Path.addCurve(to: CGPoint(x: 51.46, y: 26.86), controlPoint1: CGPoint(x: 52.66, y: 29.56), controlPoint2: CGPoint(x: 52.58, y: 27.98))
        bezier2Path.addCurve(to: CGPoint(x: 44.33, y: 27.91), controlPoint1: CGPoint(x: 49.81, y: 25.13), controlPoint2: CGPoint(x: 49.06, y: 25.21))
        bezier2Path.close()
        fillColor.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 60.61, y: 28.73))
        bezier3Path.addCurve(to: CGPoint(x: 60.01, y: 65.86), controlPoint1: CGPoint(x: 60.23, y: 30.76), controlPoint2: CGPoint(x: 59.71, y: 62.78))
        bezier3Path.addCurve(to: CGPoint(x: 70.58, y: 67.96), controlPoint1: CGPoint(x: 60.08, y: 66.76), controlPoint2: CGPoint(x: 62.71, y: 67.28))
        bezier3Path.addCurve(to: CGPoint(x: 96.61, y: 77.93), controlPoint1: CGPoint(x: 79.06, y: 68.71), controlPoint2: CGPoint(x: 89.71, y: 72.83))
        bezier3Path.addCurve(to: CGPoint(x: 97.28, y: 65.93), controlPoint1: CGPoint(x: 102.46, y: 82.28), controlPoint2: CGPoint(x: 102.76, y: 77.03))
        bezier3Path.addCurve(to: CGPoint(x: 76.06, y: 34.13), controlPoint1: CGPoint(x: 88.66, y: 48.46), controlPoint2: CGPoint(x: 84.83, y: 42.83))
        bezier3Path.addCurve(to: CGPoint(x: 63.23, y: 26.33), controlPoint1: CGPoint(x: 70.36, y: 28.43), controlPoint2: CGPoint(x: 66.83, y: 26.33))
        bezier3Path.addCurve(to: CGPoint(x: 60.61, y: 28.73), controlPoint1: CGPoint(x: 61.28, y: 26.33), controlPoint2: CGPoint(x: 60.91, y: 26.63))
        bezier3Path.close()
        fillColor.setFill()
        bezier3Path.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 61.21, y: 77.78))
        bezier4Path.addCurve(to: CGPoint(x: 60.16, y: 96.23), controlPoint1: CGPoint(x: 60.53, y: 78.46), controlPoint2: CGPoint(x: 60.23, y: 83.48))
        bezier4Path.addCurve(to: CGPoint(x: 59.71, y: 117.83), controlPoint1: CGPoint(x: 60.08, y: 105.83), controlPoint2: CGPoint(x: 59.86, y: 115.58))
        bezier4Path.addCurve(to: CGPoint(x: 60.23, y: 133.81), controlPoint1: CGPoint(x: 58.43, y: 133.21), controlPoint2: CGPoint(x: 58.43, y: 132.68))
        bezier4Path.addCurve(to: CGPoint(x: 66.46, y: 135.83), controlPoint1: CGPoint(x: 61.21, y: 134.41), controlPoint2: CGPoint(x: 63.98, y: 135.31))
        bezier4Path.addCurve(to: CGPoint(x: 78.31, y: 142.58), controlPoint1: CGPoint(x: 72.53, y: 137.11), controlPoint2: CGPoint(x: 74.26, y: 138.08))
        bezier4Path.addCurve(to: CGPoint(x: 83.56, y: 146.33), controlPoint1: CGPoint(x: 80.63, y: 145.21), controlPoint2: CGPoint(x: 82.28, y: 146.33))
        bezier4Path.addCurve(to: CGPoint(x: 90.16, y: 132.98), controlPoint1: CGPoint(x: 85.58, y: 146.33), controlPoint2: CGPoint(x: 86.48, y: 144.61))
        bezier4Path.addCurve(to: CGPoint(x: 101.03, y: 108.46), controlPoint1: CGPoint(x: 92.03, y: 127.21), controlPoint2: CGPoint(x: 94.28, y: 122.11))
        bezier4Path.addCurve(to: CGPoint(x: 105.83, y: 96.83), controlPoint1: CGPoint(x: 103.66, y: 103.06), controlPoint2: CGPoint(x: 105.83, y: 97.88))
        bezier4Path.addCurve(to: CGPoint(x: 75.46, y: 78.76), controlPoint1: CGPoint(x: 105.83, y: 91.96), controlPoint2: CGPoint(x: 88.96, y: 81.91))
        bezier4Path.addCurve(to: CGPoint(x: 61.21, y: 77.78), controlPoint1: CGPoint(x: 68.71, y: 77.26), controlPoint2: CGPoint(x: 62.26, y: 76.81))
        bezier4Path.close()
        fillColor.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 36.08, y: 78.46))
        bezier5Path.addCurve(to: CGPoint(x: 26.18, y: 80.63), controlPoint1: CGPoint(x: 33.01, y: 79.06), controlPoint2: CGPoint(x: 28.51, y: 80.03))
        bezier5Path.addCurve(to: CGPoint(x: 0.38, y: 94.21), controlPoint1: CGPoint(x: 17.11, y: 83.11), controlPoint2: CGPoint(x: 1.06, y: 91.58))
        bezier5Path.addCurve(to: CGPoint(x: 7.96, y: 121.21), controlPoint1: CGPoint(x: -0.07, y: 95.93), controlPoint2: CGPoint(x: 3.76, y: 109.36))
        bezier5Path.addCurve(to: CGPoint(x: 11.33, y: 130.58), controlPoint1: CGPoint(x: 9.46, y: 125.33), controlPoint2: CGPoint(x: 10.96, y: 129.53))
        bezier5Path.addCurve(to: CGPoint(x: 14.63, y: 138.23), controlPoint1: CGPoint(x: 11.63, y: 131.63), controlPoint2: CGPoint(x: 13.13, y: 135.08))
        bezier5Path.addCurve(to: CGPoint(x: 23.56, y: 141.91), controlPoint1: CGPoint(x: 17.78, y: 144.98), controlPoint2: CGPoint(x: 18.61, y: 145.28))
        bezier5Path.addCurve(to: CGPoint(x: 44.56, y: 134.33), controlPoint1: CGPoint(x: 30.01, y: 137.48), controlPoint2: CGPoint(x: 38.86, y: 134.33))
        bezier5Path.addCurve(to: CGPoint(x: 49.88, y: 105.83), controlPoint1: CGPoint(x: 50.33, y: 134.33), controlPoint2: CGPoint(x: 49.96, y: 136.21))
        bezier5Path.addCurve(to: CGPoint(x: 48.76, y: 78.01), controlPoint1: CGPoint(x: 49.81, y: 83.48), controlPoint2: CGPoint(x: 49.58, y: 78.53))
        bezier5Path.addCurve(to: CGPoint(x: 36.08, y: 78.46), controlPoint1: CGPoint(x: 47.33, y: 77.11), controlPoint2: CGPoint(x: 42.83, y: 77.26))
        bezier5Path.close()
        fillColor.setFill()
        bezier5Path.fill()
        let combined = UIBezierPath()
        combined.append(bezierPath)
        combined.append(bezier2Path)
        combined.append(bezier3Path)
        combined.append(bezier4Path)
        combined.append(bezier5Path)
        
        return combined
    }
}
