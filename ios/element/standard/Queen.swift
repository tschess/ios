//
//  Queen.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Queen: TschessElement {
    
    let horizontalVertical = HorizontalVertical()
    let diagonal = Diagonal()
    
    init(
        name: String = "Queen",
        imageDefault: UIImage = UIImage(named: "red_queen")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "9",
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: true,
            attackVectorList: Array<String>(["Diagonal", "HorizontalVertical"]),
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
        /* * */
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
        bezierPath.move(to: CGPoint(x: 58.46, y: 0.83))
        bezierPath.addCurve(to: CGPoint(x: 45.18, y: 8.48), controlPoint1: CGPoint(x: 53.96, y: 1.88), controlPoint2: CGPoint(x: 48.71, y: 4.96))
        bezierPath.addCurve(to: CGPoint(x: 41.58, y: 12.83), controlPoint1: CGPoint(x: 43.23, y: 10.43), controlPoint2: CGPoint(x: 41.58, y: 12.38))
        bezierPath.addCurve(to: CGPoint(x: 40.91, y: 13.58), controlPoint1: CGPoint(x: 41.58, y: 13.21), controlPoint2: CGPoint(x: 41.28, y: 13.58))
        bezierPath.addCurve(to: CGPoint(x: 37.38, y: 19.36), controlPoint1: CGPoint(x: 40.53, y: 13.58), controlPoint2: CGPoint(x: 38.96, y: 16.21))
        bezierPath.addCurve(to: CGPoint(x: 34.46, y: 33.83), controlPoint1: CGPoint(x: 34.53, y: 25.13), controlPoint2: CGPoint(x: 34.46, y: 25.36))
        bezierPath.addCurve(to: CGPoint(x: 35.81, y: 46.28), controlPoint1: CGPoint(x: 34.46, y: 40.21), controlPoint2: CGPoint(x: 34.83, y: 43.43))
        bezierPath.addCurve(to: CGPoint(x: 47.06, y: 63.61), controlPoint1: CGPoint(x: 37.23, y: 50.41), controlPoint2: CGPoint(x: 43.23, y: 59.63))
        bezierPath.addCurve(to: CGPoint(x: 48.86, y: 66.61), controlPoint1: CGPoint(x: 48.33, y: 64.96), controlPoint2: CGPoint(x: 49.16, y: 66.31))
        bezierPath.addCurve(to: CGPoint(x: 30.33, y: 63.08), controlPoint1: CGPoint(x: 48.26, y: 67.21), controlPoint2: CGPoint(x: 43.23, y: 66.23))
        bezierPath.addCurve(to: CGPoint(x: 6.11, y: 57.46), controlPoint1: CGPoint(x: 20.96, y: 60.83), controlPoint2: CGPoint(x: 8.66, y: 57.98))
        bezierPath.addCurve(to: CGPoint(x: 0.78, y: 61.51), controlPoint1: CGPoint(x: 3.48, y: 56.86), controlPoint2: CGPoint(x: 1.23, y: 58.66))
        bezierPath.addCurve(to: CGPoint(x: 0.78, y: 79.58), controlPoint1: CGPoint(x: -0.04, y: 66.98), controlPoint2: CGPoint(x: -0.04, y: 78.76))
        bezierPath.addCurve(to: CGPoint(x: 10.91, y: 79.28), controlPoint1: CGPoint(x: 1.46, y: 80.26), controlPoint2: CGPoint(x: 4.08, y: 80.18))
        bezierPath.addCurve(to: CGPoint(x: 27.33, y: 77.71), controlPoint1: CGPoint(x: 16.01, y: 78.61), controlPoint2: CGPoint(x: 23.43, y: 77.93))
        bezierPath.addCurve(to: CGPoint(x: 45.48, y: 76.06), controlPoint1: CGPoint(x: 31.23, y: 77.48), controlPoint2: CGPoint(x: 39.41, y: 76.73))
        bezierPath.addCurve(to: CGPoint(x: 57.03, y: 75.31), controlPoint1: CGPoint(x: 51.56, y: 75.38), controlPoint2: CGPoint(x: 56.73, y: 75.01))
        bezierPath.addCurve(to: CGPoint(x: 56.36, y: 78.23), controlPoint1: CGPoint(x: 57.33, y: 75.53), controlPoint2: CGPoint(x: 57.03, y: 76.88))
        bezierPath.addCurve(to: CGPoint(x: 52.46, y: 91.58), controlPoint1: CGPoint(x: 55.38, y: 80.26), controlPoint2: CGPoint(x: 53.66, y: 86.26))
        bezierPath.addCurve(to: CGPoint(x: 47.96, y: 107.71), controlPoint1: CGPoint(x: 51.71, y: 94.66), controlPoint2: CGPoint(x: 49.61, y: 102.31))
        bezierPath.addCurve(to: CGPoint(x: 41.88, y: 146.26), controlPoint1: CGPoint(x: 43.91, y: 120.91), controlPoint2: CGPoint(x: 40.16, y: 144.83))
        bezierPath.addCurve(to: CGPoint(x: 72.11, y: 147.23), controlPoint1: CGPoint(x: 44.06, y: 148.06), controlPoint2: CGPoint(x: 69.18, y: 148.88))
        bezierPath.addCurve(to: CGPoint(x: 72.33, y: 120.83), controlPoint1: CGPoint(x: 75.18, y: 145.51), controlPoint2: CGPoint(x: 75.26, y: 139.88))
        bezierPath.addCurve(to: CGPoint(x: 69.33, y: 99.46), controlPoint1: CGPoint(x: 71.58, y: 115.66), controlPoint2: CGPoint(x: 70.23, y: 106.06))
        bezierPath.addCurve(to: CGPoint(x: 65.81, y: 76.28), controlPoint1: CGPoint(x: 67.46, y: 85.21), controlPoint2: CGPoint(x: 66.41, y: 78.23))
        bezierPath.addCurve(to: CGPoint(x: 75.41, y: 75.38), controlPoint1: CGPoint(x: 65.43, y: 74.93), controlPoint2: CGPoint(x: 65.88, y: 74.93))
        bezierPath.addCurve(to: CGPoint(x: 95.58, y: 76.96), controlPoint1: CGPoint(x: 80.96, y: 75.68), controlPoint2: CGPoint(x: 90.03, y: 76.36))
        bezierPath.addCurve(to: CGPoint(x: 124.38, y: 78.16), controlPoint1: CGPoint(x: 111.33, y: 78.53), controlPoint2: CGPoint(x: 123.86, y: 79.06))
        bezierPath.addCurve(to: CGPoint(x: 124.23, y: 59.93), controlPoint1: CGPoint(x: 125.28, y: 76.73), controlPoint2: CGPoint(x: 125.13, y: 60.83))
        bezierPath.addCurve(to: CGPoint(x: 78.78, y: 66.08), controlPoint1: CGPoint(x: 123.03, y: 58.73), controlPoint2: CGPoint(x: 113.58, y: 60.01))
        bezierPath.addCurve(to: CGPoint(x: 69.56, y: 67.28), controlPoint1: CGPoint(x: 73.83, y: 66.91), controlPoint2: CGPoint(x: 69.71, y: 67.43))
        bezierPath.addCurve(to: CGPoint(x: 71.73, y: 64.73), controlPoint1: CGPoint(x: 69.33, y: 67.13), controlPoint2: CGPoint(x: 70.38, y: 65.93))
        bezierPath.addCurve(to: CGPoint(x: 89.81, y: 40.13), controlPoint1: CGPoint(x: 83.96, y: 53.63), controlPoint2: CGPoint(x: 87.33, y: 49.06))
        bezierPath.addCurve(to: CGPoint(x: 79.83, y: 7.58), controlPoint1: CGPoint(x: 93.03, y: 28.73), controlPoint2: CGPoint(x: 89.43, y: 17.11))
        bezierPath.addCurve(to: CGPoint(x: 70.38, y: 1.36), controlPoint1: CGPoint(x: 75.71, y: 3.53), controlPoint2: CGPoint(x: 74.06, y: 2.48))
        bezierPath.addCurve(to: CGPoint(x: 58.46, y: 0.83), controlPoint1: CGPoint(x: 65.66, y: 0.01), controlPoint2: CGPoint(x: 62.28, y: -0.14))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 69.26, y: 9.68))
        bezierPath.addCurve(to: CGPoint(x: 75.71, y: 22.66), controlPoint1: CGPoint(x: 71.81, y: 11.56), controlPoint2: CGPoint(x: 75.11, y: 18.16))
        bezierPath.addCurve(to: CGPoint(x: 76.23, y: 32.03), controlPoint1: CGPoint(x: 76.01, y: 24.61), controlPoint2: CGPoint(x: 76.23, y: 28.81))
        bezierPath.addCurve(to: CGPoint(x: 69.33, y: 52.73), controlPoint1: CGPoint(x: 76.23, y: 38.41), controlPoint2: CGPoint(x: 75.71, y: 39.91))
        bezierPath.addCurve(to: CGPoint(x: 61.01, y: 66.08), controlPoint1: CGPoint(x: 66.11, y: 59.11), controlPoint2: CGPoint(x: 61.76, y: 66.08))
        bezierPath.addCurve(to: CGPoint(x: 48.41, y: 40.58), controlPoint1: CGPoint(x: 59.43, y: 66.08), controlPoint2: CGPoint(x: 51.56, y: 50.11))
        bezierPath.addCurve(to: CGPoint(x: 58.83, y: 8.41), controlPoint1: CGPoint(x: 43.01, y: 24.53), controlPoint2: CGPoint(x: 47.13, y: 11.93))
        bezierPath.addCurve(to: CGPoint(x: 69.26, y: 9.68), controlPoint1: CGPoint(x: 62.36, y: 7.36), controlPoint2: CGPoint(x: 66.93, y: 7.88))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        return bezierPath
    }
}
