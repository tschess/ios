//
//  Arrow.swift
//  ios
//
//  Created by Jacob on 8/30/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class ArrowPawn: FairyElement {
    
    init(
        name: String = "ArrowPawn",
        imageDefault: UIImage = UIImage(named: "red_arrow")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "2",
            affiliation: affiliation,
            description: "moves as a truncated rook (one square at a time), captures diagonally one square as a standard pawn. cannot be promoted.",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(4),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        if(zeroPlus(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        if(zeroMinus(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        if(onePlus(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        if(oneMinus(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        /* * */
        if(attack(present: present, proposed: proposed, gamestate: gamestate, invert: -1)) {
            return true
        }
        return false
    }
  
    public func zeroPlus(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if((present[0] + 1) - proposed[0] == 0 && (present[1] - proposed[1] == 0)) {
            if(tschessElementMatrix[present[0] + 1][present[1]] != nil) {
                if(tschessElementMatrix[present[0] + 1][present[1]]!.name == "LegalMove") {
                    return true
                }
                return false
            }
            return true
        }
        return false
    }
    
    public func zeroMinus(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if((present[0] - 1) - proposed[0] == 0 && (present[1] - proposed[1] == 0)) {
            if(tschessElementMatrix[present[0] - 1][present[1]] != nil) {
                if(tschessElementMatrix[present[0] - 1][present[1]]!.name == "LegalMove") {
                    return true
                }
                return false
            }
            return true
        }
        return false
    }
    
    public func onePlus(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if(present[0] - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0]][present[1] + 1] != nil) {
                if(tschessElementMatrix[present[0]][present[1] + 1]!.name == "LegalMove") {
                    return true
                }
                return false
            }
            return true
        }
        return false
    }
    
    public func oneMinus(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if(present[0] - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0]][present[1] - 1] != nil) {
                if(tschessElementMatrix[present[0]][present[1] - 1]!.name == "LegalMove") {
                    return true
                }
                return false
            }
            return true
        }
        return false
    }
    
    public func attack(present: [Int], proposed: [Int], gamestate: Gamestate, invert: Int) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - (1 * invert)) - proposed[0] == 0 && ((present[1] + 1) - proposed[1] == 0)) {
            if(tschessElementMatrix[present[0] - (1 * invert)][present[1] + 1] != nil) {
                if(tschessElementMatrix[present[0] - (1 * invert)][present[1] + 1]!.name != "LegalMove") {
                    return tschessElementMatrix[present[0] - (1 * invert)][present[1] + 1]!.affiliation !=
                        tschessElementMatrix[present[0]][present[1]]!.affiliation
                }
            }
        }
        if((present[0] - (1 * invert)) - proposed[0] == 0 && ((present[1] - 1) - proposed[1] == 0)) {
            if(tschessElementMatrix[present[0] - (1 * invert)][present[1] - 1] != nil) {
                if(tschessElementMatrix[present[0] - (1 * invert)][present[1] - 1]!.name != "LegalMove") {
                    return tschessElementMatrix[present[0] - (1 * invert)][present[1] - 1]!.affiliation !=
                        tschessElementMatrix[present[0]][present[1]]!.affiliation
                }
            }
        }
        return false
    }
    
    public override func getBezierPath() -> UIBezierPath {

        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 3.31, y: 1.46))
        bezierPath.addCurve(to: CGPoint(x: 2.33, y: 13.38), controlPoint1: CGPoint(x: 2.63, y: 2.21), controlPoint2: CGPoint(x: 2.33, y: 5.73))
        bezierPath.addCurve(to: CGPoint(x: 3.76, y: 24.71), controlPoint1: CGPoint(x: 2.33, y: 23.51), controlPoint2: CGPoint(x: 2.41, y: 24.26))
        bezierPath.addCurve(to: CGPoint(x: 5.71, y: 26.58), controlPoint1: CGPoint(x: 4.58, y: 24.93), controlPoint2: CGPoint(x: 5.48, y: 25.83))
        bezierPath.addCurve(to: CGPoint(x: 7.58, y: 28.46), controlPoint1: CGPoint(x: 5.93, y: 27.33), controlPoint2: CGPoint(x: 6.83, y: 28.23))
        bezierPath.addCurve(to: CGPoint(x: 9.46, y: 30.33), controlPoint1: CGPoint(x: 8.33, y: 28.68), controlPoint2: CGPoint(x: 9.23, y: 29.58))
        bezierPath.addCurve(to: CGPoint(x: 11.33, y: 32.21), controlPoint1: CGPoint(x: 9.68, y: 31.08), controlPoint2: CGPoint(x: 10.58, y: 31.98))
        bezierPath.addCurve(to: CGPoint(x: 13.21, y: 34.08), controlPoint1: CGPoint(x: 12.08, y: 32.43), controlPoint2: CGPoint(x: 12.98, y: 33.33))
        bezierPath.addCurve(to: CGPoint(x: 15.08, y: 35.96), controlPoint1: CGPoint(x: 13.43, y: 34.83), controlPoint2: CGPoint(x: 14.33, y: 35.73))
        bezierPath.addCurve(to: CGPoint(x: 16.96, y: 37.83), controlPoint1: CGPoint(x: 15.83, y: 36.18), controlPoint2: CGPoint(x: 16.73, y: 37.08))
        bezierPath.addCurve(to: CGPoint(x: 18.83, y: 39.71), controlPoint1: CGPoint(x: 17.18, y: 38.58), controlPoint2: CGPoint(x: 18.08, y: 39.48))
        bezierPath.addCurve(to: CGPoint(x: 20.71, y: 41.58), controlPoint1: CGPoint(x: 19.58, y: 39.93), controlPoint2: CGPoint(x: 20.48, y: 40.83))
        bezierPath.addCurve(to: CGPoint(x: 22.58, y: 43.46), controlPoint1: CGPoint(x: 20.93, y: 42.33), controlPoint2: CGPoint(x: 21.83, y: 43.23))
        bezierPath.addCurve(to: CGPoint(x: 24.46, y: 45.33), controlPoint1: CGPoint(x: 23.33, y: 43.68), controlPoint2: CGPoint(x: 24.23, y: 44.58))
        bezierPath.addCurve(to: CGPoint(x: 26.33, y: 47.21), controlPoint1: CGPoint(x: 24.68, y: 46.08), controlPoint2: CGPoint(x: 25.58, y: 46.98))
        bezierPath.addCurve(to: CGPoint(x: 28.21, y: 49.08), controlPoint1: CGPoint(x: 27.08, y: 47.43), controlPoint2: CGPoint(x: 27.98, y: 48.33))
        bezierPath.addCurve(to: CGPoint(x: 30.08, y: 50.96), controlPoint1: CGPoint(x: 28.43, y: 49.83), controlPoint2: CGPoint(x: 29.33, y: 50.73))
        bezierPath.addCurve(to: CGPoint(x: 31.96, y: 52.83), controlPoint1: CGPoint(x: 30.83, y: 51.18), controlPoint2: CGPoint(x: 31.73, y: 52.08))
        bezierPath.addCurve(to: CGPoint(x: 33.83, y: 54.71), controlPoint1: CGPoint(x: 32.18, y: 53.58), controlPoint2: CGPoint(x: 33.08, y: 54.48))
        bezierPath.addCurve(to: CGPoint(x: 35.71, y: 56.58), controlPoint1: CGPoint(x: 34.58, y: 54.93), controlPoint2: CGPoint(x: 35.48, y: 55.83))
        bezierPath.addCurve(to: CGPoint(x: 37.58, y: 58.46), controlPoint1: CGPoint(x: 35.93, y: 57.33), controlPoint2: CGPoint(x: 36.83, y: 58.23))
        bezierPath.addCurve(to: CGPoint(x: 39.46, y: 60.33), controlPoint1: CGPoint(x: 38.33, y: 58.68), controlPoint2: CGPoint(x: 39.23, y: 59.58))
        bezierPath.addCurve(to: CGPoint(x: 41.33, y: 62.21), controlPoint1: CGPoint(x: 39.68, y: 61.08), controlPoint2: CGPoint(x: 40.58, y: 61.98))
        bezierPath.addCurve(to: CGPoint(x: 43.21, y: 64.08), controlPoint1: CGPoint(x: 42.08, y: 62.43), controlPoint2: CGPoint(x: 42.98, y: 63.33))
        bezierPath.addCurve(to: CGPoint(x: 45.08, y: 65.96), controlPoint1: CGPoint(x: 43.43, y: 64.83), controlPoint2: CGPoint(x: 44.33, y: 65.73))
        bezierPath.addCurve(to: CGPoint(x: 46.96, y: 67.83), controlPoint1: CGPoint(x: 45.83, y: 66.18), controlPoint2: CGPoint(x: 46.73, y: 67.08))
        bezierPath.addCurve(to: CGPoint(x: 48.83, y: 69.71), controlPoint1: CGPoint(x: 47.18, y: 68.58), controlPoint2: CGPoint(x: 48.01, y: 69.48))
        bezierPath.addCurve(to: CGPoint(x: 48.83, y: 74.96), controlPoint1: CGPoint(x: 51.46, y: 70.53), controlPoint2: CGPoint(x: 51.46, y: 74.13))
        bezierPath.addCurve(to: CGPoint(x: 46.96, y: 76.83), controlPoint1: CGPoint(x: 48.01, y: 75.18), controlPoint2: CGPoint(x: 47.18, y: 76.08))
        bezierPath.addCurve(to: CGPoint(x: 45.08, y: 78.71), controlPoint1: CGPoint(x: 46.73, y: 77.58), controlPoint2: CGPoint(x: 45.83, y: 78.48))
        bezierPath.addCurve(to: CGPoint(x: 43.21, y: 80.58), controlPoint1: CGPoint(x: 44.33, y: 78.93), controlPoint2: CGPoint(x: 43.43, y: 79.83))
        bezierPath.addCurve(to: CGPoint(x: 41.33, y: 82.46), controlPoint1: CGPoint(x: 42.98, y: 81.33), controlPoint2: CGPoint(x: 42.08, y: 82.23))
        bezierPath.addCurve(to: CGPoint(x: 39.46, y: 84.33), controlPoint1: CGPoint(x: 40.58, y: 82.68), controlPoint2: CGPoint(x: 39.68, y: 83.58))
        bezierPath.addCurve(to: CGPoint(x: 37.58, y: 86.21), controlPoint1: CGPoint(x: 39.23, y: 85.08), controlPoint2: CGPoint(x: 38.33, y: 85.98))
        bezierPath.addCurve(to: CGPoint(x: 35.71, y: 88.16), controlPoint1: CGPoint(x: 36.83, y: 86.43), controlPoint2: CGPoint(x: 35.93, y: 87.33))
        bezierPath.addCurve(to: CGPoint(x: 33.83, y: 88.83), controlPoint1: CGPoint(x: 35.18, y: 89.66), controlPoint2: CGPoint(x: 33.83, y: 90.18))
        bezierPath.addCurve(to: CGPoint(x: 32.71, y: 88.08), controlPoint1: CGPoint(x: 33.83, y: 88.38), controlPoint2: CGPoint(x: 33.31, y: 88.08))
        bezierPath.addCurve(to: CGPoint(x: 31.58, y: 87.33), controlPoint1: CGPoint(x: 32.11, y: 88.08), controlPoint2: CGPoint(x: 31.58, y: 87.71))
        bezierPath.addCurve(to: CGPoint(x: 28.96, y: 86.58), controlPoint1: CGPoint(x: 31.58, y: 86.88), controlPoint2: CGPoint(x: 30.38, y: 86.58))
        bezierPath.addCurve(to: CGPoint(x: 26.33, y: 87.33), controlPoint1: CGPoint(x: 27.53, y: 86.58), controlPoint2: CGPoint(x: 26.33, y: 86.88))
        bezierPath.addCurve(to: CGPoint(x: 25.51, y: 88.08), controlPoint1: CGPoint(x: 26.33, y: 87.71), controlPoint2: CGPoint(x: 25.96, y: 88.08))
        bezierPath.addCurve(to: CGPoint(x: 23.63, y: 89.13), controlPoint1: CGPoint(x: 25.06, y: 88.08), controlPoint2: CGPoint(x: 24.23, y: 88.53))
        bezierPath.addCurve(to: CGPoint(x: 21.76, y: 90.48), controlPoint1: CGPoint(x: 23.11, y: 89.73), controlPoint2: CGPoint(x: 22.21, y: 90.33))
        bezierPath.addCurve(to: CGPoint(x: 21.68, y: 99.18), controlPoint1: CGPoint(x: 20.56, y: 90.86), controlPoint2: CGPoint(x: 20.56, y: 98.81))
        bezierPath.addCurve(to: CGPoint(x: 22.58, y: 100.23), controlPoint1: CGPoint(x: 22.21, y: 99.33), controlPoint2: CGPoint(x: 22.58, y: 99.78))
        bezierPath.addCurve(to: CGPoint(x: 24.46, y: 102.78), controlPoint1: CGPoint(x: 22.58, y: 100.68), controlPoint2: CGPoint(x: 23.41, y: 101.81))
        bezierPath.addCurve(to: CGPoint(x: 25.58, y: 106.83), controlPoint1: CGPoint(x: 26.33, y: 104.51), controlPoint2: CGPoint(x: 27.01, y: 106.83))
        bezierPath.addCurve(to: CGPoint(x: 24.83, y: 107.96), controlPoint1: CGPoint(x: 25.21, y: 106.83), controlPoint2: CGPoint(x: 24.83, y: 107.36))
        bezierPath.addCurve(to: CGPoint(x: 21.16, y: 112.68), controlPoint1: CGPoint(x: 24.83, y: 108.56), controlPoint2: CGPoint(x: 23.18, y: 110.66))
        bezierPath.addCurve(to: CGPoint(x: 17.03, y: 117.93), controlPoint1: CGPoint(x: 19.13, y: 114.71), controlPoint2: CGPoint(x: 17.26, y: 117.03))
        bezierPath.addCurve(to: CGPoint(x: 15.08, y: 119.96), controlPoint1: CGPoint(x: 16.73, y: 118.76), controlPoint2: CGPoint(x: 15.83, y: 119.73))
        bezierPath.addCurve(to: CGPoint(x: 13.21, y: 121.91), controlPoint1: CGPoint(x: 14.33, y: 120.18), controlPoint2: CGPoint(x: 13.43, y: 121.08))
        bezierPath.addCurve(to: CGPoint(x: 12.23, y: 123.41), controlPoint1: CGPoint(x: 12.91, y: 122.66), controlPoint2: CGPoint(x: 12.53, y: 123.33))
        bezierPath.addCurve(to: CGPoint(x: 7.06, y: 123.71), controlPoint1: CGPoint(x: 11.93, y: 123.48), controlPoint2: CGPoint(x: 9.61, y: 123.56))
        bezierPath.addCurve(to: CGPoint(x: -0.29, y: 131.13), controlPoint1: CGPoint(x: 0.83, y: 123.93), controlPoint2: CGPoint(x: -0.29, y: 125.13))
        bezierPath.addLine(to: CGPoint(x: -0.29, y: 135.71))
        bezierPath.addLine(to: CGPoint(x: 5.71, y: 141.63))
        bezierPath.addLine(to: CGPoint(x: 11.63, y: 147.48))
        bezierPath.addLine(to: CGPoint(x: 15.91, y: 147.18))
        bezierPath.addCurve(to: CGPoint(x: 22.58, y: 142.91), controlPoint1: CGPoint(x: 20.48, y: 146.88), controlPoint2: CGPoint(x: 22.58, y: 145.46))
        bezierPath.addCurve(to: CGPoint(x: 23.33, y: 141.33), controlPoint1: CGPoint(x: 22.58, y: 142.01), controlPoint2: CGPoint(x: 22.96, y: 141.33))
        bezierPath.addCurve(to: CGPoint(x: 24.08, y: 139.83), controlPoint1: CGPoint(x: 23.78, y: 141.33), controlPoint2: CGPoint(x: 24.08, y: 140.66))
        bezierPath.addCurve(to: CGPoint(x: 23.33, y: 138.33), controlPoint1: CGPoint(x: 24.08, y: 139.01), controlPoint2: CGPoint(x: 23.78, y: 138.33))
        bezierPath.addCurve(to: CGPoint(x: 22.58, y: 137.21), controlPoint1: CGPoint(x: 22.96, y: 138.33), controlPoint2: CGPoint(x: 22.58, y: 137.81))
        bezierPath.addCurve(to: CGPoint(x: 30.31, y: 129.33), controlPoint1: CGPoint(x: 22.58, y: 135.63), controlPoint2: CGPoint(x: 28.81, y: 129.33))
        bezierPath.addCurve(to: CGPoint(x: 31.96, y: 127.91), controlPoint1: CGPoint(x: 30.98, y: 129.33), controlPoint2: CGPoint(x: 31.66, y: 128.66))
        bezierPath.addCurve(to: CGPoint(x: 33.83, y: 125.96), controlPoint1: CGPoint(x: 32.18, y: 127.08), controlPoint2: CGPoint(x: 33.08, y: 126.18))
        bezierPath.addCurve(to: CGPoint(x: 35.71, y: 124.08), controlPoint1: CGPoint(x: 34.58, y: 125.73), controlPoint2: CGPoint(x: 35.48, y: 124.83))
        bezierPath.addCurve(to: CGPoint(x: 38.03, y: 122.13), controlPoint1: CGPoint(x: 36.01, y: 123.26), controlPoint2: CGPoint(x: 36.98, y: 122.36))
        bezierPath.addCurve(to: CGPoint(x: 39.83, y: 121.01), controlPoint1: CGPoint(x: 39.01, y: 121.91), controlPoint2: CGPoint(x: 39.83, y: 121.38))
        bezierPath.addCurve(to: CGPoint(x: 44.78, y: 123.03), controlPoint1: CGPoint(x: 39.83, y: 119.51), controlPoint2: CGPoint(x: 42.31, y: 120.48))
        bezierPath.addCurve(to: CGPoint(x: 51.53, y: 125.81), controlPoint1: CGPoint(x: 47.18, y: 125.58), controlPoint2: CGPoint(x: 47.78, y: 125.81))
        bezierPath.addCurve(to: CGPoint(x: 57.08, y: 124.08), controlPoint1: CGPoint(x: 54.83, y: 125.81), controlPoint2: CGPoint(x: 55.88, y: 125.51))
        bezierPath.addCurve(to: CGPoint(x: 58.58, y: 121.31), controlPoint1: CGPoint(x: 57.91, y: 123.11), controlPoint2: CGPoint(x: 58.58, y: 121.91))
        bezierPath.addCurve(to: CGPoint(x: 59.33, y: 120.33), controlPoint1: CGPoint(x: 58.58, y: 120.78), controlPoint2: CGPoint(x: 58.96, y: 120.33))
        bezierPath.addCurve(to: CGPoint(x: 60.08, y: 118.46), controlPoint1: CGPoint(x: 59.78, y: 120.33), controlPoint2: CGPoint(x: 60.08, y: 119.51))
        bezierPath.addCurve(to: CGPoint(x: 59.41, y: 116.58), controlPoint1: CGPoint(x: 60.08, y: 117.41), controlPoint2: CGPoint(x: 59.78, y: 116.58))
        bezierPath.addCurve(to: CGPoint(x: 58.43, y: 114.18), controlPoint1: CGPoint(x: 59.03, y: 116.58), controlPoint2: CGPoint(x: 58.58, y: 115.53))
        bezierPath.addCurve(to: CGPoint(x: 66.16, y: 103.68), controlPoint1: CGPoint(x: 58.06, y: 111.93), controlPoint2: CGPoint(x: 58.66, y: 111.18))
        bezierPath.addCurve(to: CGPoint(x: 76.96, y: 97.83), controlPoint1: CGPoint(x: 74.26, y: 95.58), controlPoint2: CGPoint(x: 75.98, y: 94.68))
        bezierPath.addCurve(to: CGPoint(x: 78.83, y: 99.71), controlPoint1: CGPoint(x: 77.18, y: 98.66), controlPoint2: CGPoint(x: 78.08, y: 99.48))
        bezierPath.addCurve(to: CGPoint(x: 80.71, y: 101.58), controlPoint1: CGPoint(x: 79.58, y: 99.93), controlPoint2: CGPoint(x: 80.48, y: 100.83))
        bezierPath.addCurve(to: CGPoint(x: 82.58, y: 103.46), controlPoint1: CGPoint(x: 80.93, y: 102.33), controlPoint2: CGPoint(x: 81.83, y: 103.23))
        bezierPath.addCurve(to: CGPoint(x: 84.46, y: 105.33), controlPoint1: CGPoint(x: 83.33, y: 103.68), controlPoint2: CGPoint(x: 84.23, y: 104.58))
        bezierPath.addCurve(to: CGPoint(x: 86.33, y: 107.21), controlPoint1: CGPoint(x: 84.68, y: 106.08), controlPoint2: CGPoint(x: 85.58, y: 106.98))
        bezierPath.addCurve(to: CGPoint(x: 88.21, y: 109.08), controlPoint1: CGPoint(x: 87.08, y: 107.43), controlPoint2: CGPoint(x: 87.98, y: 108.33))
        bezierPath.addCurve(to: CGPoint(x: 90.16, y: 110.96), controlPoint1: CGPoint(x: 88.43, y: 109.83), controlPoint2: CGPoint(x: 89.33, y: 110.73))
        bezierPath.addCurve(to: CGPoint(x: 90.83, y: 112.83), controlPoint1: CGPoint(x: 91.66, y: 111.48), controlPoint2: CGPoint(x: 92.18, y: 112.83))
        bezierPath.addCurve(to: CGPoint(x: 90.08, y: 114.71), controlPoint1: CGPoint(x: 90.46, y: 112.83), controlPoint2: CGPoint(x: 90.08, y: 113.66))
        bezierPath.addCurve(to: CGPoint(x: 89.33, y: 116.58), controlPoint1: CGPoint(x: 90.08, y: 115.76), controlPoint2: CGPoint(x: 89.78, y: 116.58))
        bezierPath.addCurve(to: CGPoint(x: 88.58, y: 118.46), controlPoint1: CGPoint(x: 88.96, y: 116.58), controlPoint2: CGPoint(x: 88.58, y: 117.41))
        bezierPath.addCurve(to: CGPoint(x: 89.33, y: 120.33), controlPoint1: CGPoint(x: 88.58, y: 119.51), controlPoint2: CGPoint(x: 88.96, y: 120.33))
        bezierPath.addCurve(to: CGPoint(x: 90.08, y: 121.16), controlPoint1: CGPoint(x: 89.78, y: 120.33), controlPoint2: CGPoint(x: 90.08, y: 120.71))
        bezierPath.addCurve(to: CGPoint(x: 91.13, y: 123.03), controlPoint1: CGPoint(x: 90.08, y: 121.61), controlPoint2: CGPoint(x: 90.53, y: 122.43))
        bezierPath.addCurve(to: CGPoint(x: 92.48, y: 124.91), controlPoint1: CGPoint(x: 91.73, y: 123.56), controlPoint2: CGPoint(x: 92.33, y: 124.46))
        bezierPath.addCurve(to: CGPoint(x: 102.68, y: 124.91), controlPoint1: CGPoint(x: 92.93, y: 126.18), controlPoint2: CGPoint(x: 102.23, y: 126.18))
        bezierPath.addCurve(to: CGPoint(x: 106.13, y: 121.31), controlPoint1: CGPoint(x: 102.98, y: 124.08), controlPoint2: CGPoint(x: 103.66, y: 123.41))
        bezierPath.addCurve(to: CGPoint(x: 108.83, y: 121.08), controlPoint1: CGPoint(x: 107.48, y: 120.11), controlPoint2: CGPoint(x: 108.83, y: 120.03))
        bezierPath.addCurve(to: CGPoint(x: 109.96, y: 121.83), controlPoint1: CGPoint(x: 108.83, y: 121.46), controlPoint2: CGPoint(x: 109.36, y: 121.83))
        bezierPath.addCurve(to: CGPoint(x: 114.68, y: 125.51), controlPoint1: CGPoint(x: 110.56, y: 121.83), controlPoint2: CGPoint(x: 112.66, y: 123.48))
        bezierPath.addCurve(to: CGPoint(x: 119.93, y: 129.63), controlPoint1: CGPoint(x: 116.71, y: 127.53), controlPoint2: CGPoint(x: 119.03, y: 129.41))
        bezierPath.addCurve(to: CGPoint(x: 121.96, y: 131.58), controlPoint1: CGPoint(x: 120.76, y: 129.93), controlPoint2: CGPoint(x: 121.73, y: 130.83))
        bezierPath.addCurve(to: CGPoint(x: 123.91, y: 133.46), controlPoint1: CGPoint(x: 122.18, y: 132.33), controlPoint2: CGPoint(x: 123.08, y: 133.23))
        bezierPath.addCurve(to: CGPoint(x: 125.71, y: 139.61), controlPoint1: CGPoint(x: 125.56, y: 133.98), controlPoint2: CGPoint(x: 125.48, y: 133.68))
        bezierPath.addCurve(to: CGPoint(x: 132.83, y: 147.18), controlPoint1: CGPoint(x: 125.93, y: 145.53), controlPoint2: CGPoint(x: 127.06, y: 146.81))
        bezierPath.addLine(to: CGPoint(x: 137.11, y: 147.48))
        bezierPath.addLine(to: CGPoint(x: 142.88, y: 141.86))
        bezierPath.addCurve(to: CGPoint(x: 149.03, y: 132.86), controlPoint1: CGPoint(x: 147.91, y: 136.91), controlPoint2: CGPoint(x: 148.66, y: 135.86))
        bezierPath.addCurve(to: CGPoint(x: 148.66, y: 126.86), controlPoint1: CGPoint(x: 149.33, y: 130.98), controlPoint2: CGPoint(x: 149.11, y: 128.36))
        bezierPath.addCurve(to: CGPoint(x: 144.76, y: 123.78), controlPoint1: CGPoint(x: 147.91, y: 124.61), controlPoint2: CGPoint(x: 147.38, y: 124.23))
        bezierPath.addCurve(to: CGPoint(x: 139.96, y: 123.78), controlPoint1: CGPoint(x: 143.18, y: 123.56), controlPoint2: CGPoint(x: 140.93, y: 123.56))
        bezierPath.addCurve(to: CGPoint(x: 134.71, y: 120.86), controlPoint1: CGPoint(x: 138.38, y: 124.16), controlPoint2: CGPoint(x: 137.48, y: 123.63))
        bezierPath.addCurve(to: CGPoint(x: 131.33, y: 116.96), controlPoint1: CGPoint(x: 132.83, y: 118.91), controlPoint2: CGPoint(x: 131.33, y: 117.18))
        bezierPath.addCurve(to: CGPoint(x: 126.68, y: 111.56), controlPoint1: CGPoint(x: 131.33, y: 116.43), controlPoint2: CGPoint(x: 129.01, y: 113.73))
        bezierPath.addCurve(to: CGPoint(x: 123.83, y: 107.58), controlPoint1: CGPoint(x: 124.96, y: 109.91), controlPoint2: CGPoint(x: 123.83, y: 108.41))
        bezierPath.addCurve(to: CGPoint(x: 123.08, y: 106.83), controlPoint1: CGPoint(x: 123.83, y: 107.21), controlPoint2: CGPoint(x: 123.53, y: 106.83))
        bezierPath.addCurve(to: CGPoint(x: 123.83, y: 103.46), controlPoint1: CGPoint(x: 121.66, y: 106.83), controlPoint2: CGPoint(x: 122.33, y: 103.91))
        bezierPath.addCurve(to: CGPoint(x: 125.78, y: 101.13), controlPoint1: CGPoint(x: 124.66, y: 103.23), controlPoint2: CGPoint(x: 125.56, y: 102.18))
        bezierPath.addCurve(to: CGPoint(x: 126.91, y: 99.33), controlPoint1: CGPoint(x: 126.01, y: 100.16), controlPoint2: CGPoint(x: 126.53, y: 99.33))
        bezierPath.addCurve(to: CGPoint(x: 127.58, y: 95.21), controlPoint1: CGPoint(x: 127.28, y: 99.33), controlPoint2: CGPoint(x: 127.58, y: 97.46))
        bezierPath.addCurve(to: CGPoint(x: 123.46, y: 88.08), controlPoint1: CGPoint(x: 127.58, y: 90.93), controlPoint2: CGPoint(x: 125.93, y: 88.08))
        bezierPath.addCurve(to: CGPoint(x: 122.33, y: 87.33), controlPoint1: CGPoint(x: 122.86, y: 88.08), controlPoint2: CGPoint(x: 122.33, y: 87.71))
        bezierPath.addCurve(to: CGPoint(x: 120.08, y: 86.58), controlPoint1: CGPoint(x: 122.33, y: 86.88), controlPoint2: CGPoint(x: 121.36, y: 86.58))
        bezierPath.addCurve(to: CGPoint(x: 117.83, y: 87.33), controlPoint1: CGPoint(x: 118.88, y: 86.58), controlPoint2: CGPoint(x: 117.83, y: 86.88))
        bezierPath.addCurve(to: CGPoint(x: 116.33, y: 88.08), controlPoint1: CGPoint(x: 117.83, y: 87.71), controlPoint2: CGPoint(x: 117.16, y: 88.08))
        bezierPath.addCurve(to: CGPoint(x: 114.83, y: 88.83), controlPoint1: CGPoint(x: 115.51, y: 88.08), controlPoint2: CGPoint(x: 114.83, y: 88.46))
        bezierPath.addCurve(to: CGPoint(x: 106.13, y: 80.96), controlPoint1: CGPoint(x: 114.83, y: 89.28), controlPoint2: CGPoint(x: 110.93, y: 85.76))
        bezierPath.addLine(to: CGPoint(x: 97.51, y: 72.33))
        bezierPath.addLine(to: CGPoint(x: 121.88, y: 47.96))
        bezierPath.addLine(to: CGPoint(x: 146.33, y: 23.51))
        bezierPath.addLine(to: CGPoint(x: 146.33, y: 13.01))
        bezierPath.addCurve(to: CGPoint(x: 145.28, y: 1.38), controlPoint1: CGPoint(x: 146.33, y: 4.91), controlPoint2: CGPoint(x: 146.11, y: 2.21))
        bezierPath.addCurve(to: CGPoint(x: 133.28, y: 0.33), controlPoint1: CGPoint(x: 144.46, y: 0.56), controlPoint2: CGPoint(x: 141.76, y: 0.33))
        bezierPath.addCurve(to: CGPoint(x: 121.96, y: 1.76), controlPoint1: CGPoint(x: 123.16, y: 0.33), controlPoint2: CGPoint(x: 122.41, y: 0.41))
        bezierPath.addCurve(to: CGPoint(x: 120.08, y: 3.71), controlPoint1: CGPoint(x: 121.73, y: 2.58), controlPoint2: CGPoint(x: 120.83, y: 3.48))
        bezierPath.addCurve(to: CGPoint(x: 118.21, y: 5.58), controlPoint1: CGPoint(x: 119.33, y: 3.93), controlPoint2: CGPoint(x: 118.43, y: 4.83))
        bezierPath.addCurve(to: CGPoint(x: 116.33, y: 7.46), controlPoint1: CGPoint(x: 117.98, y: 6.33), controlPoint2: CGPoint(x: 117.08, y: 7.23))
        bezierPath.addCurve(to: CGPoint(x: 114.46, y: 9.33), controlPoint1: CGPoint(x: 115.58, y: 7.68), controlPoint2: CGPoint(x: 114.68, y: 8.58))
        bezierPath.addCurve(to: CGPoint(x: 112.58, y: 11.21), controlPoint1: CGPoint(x: 114.23, y: 10.08), controlPoint2: CGPoint(x: 113.33, y: 10.98))
        bezierPath.addCurve(to: CGPoint(x: 110.71, y: 13.08), controlPoint1: CGPoint(x: 111.83, y: 11.43), controlPoint2: CGPoint(x: 110.93, y: 12.33))
        bezierPath.addCurve(to: CGPoint(x: 108.83, y: 14.96), controlPoint1: CGPoint(x: 110.48, y: 13.83), controlPoint2: CGPoint(x: 109.58, y: 14.73))
        bezierPath.addCurve(to: CGPoint(x: 106.96, y: 16.83), controlPoint1: CGPoint(x: 108.08, y: 15.18), controlPoint2: CGPoint(x: 107.18, y: 16.08))
        bezierPath.addCurve(to: CGPoint(x: 105.08, y: 18.71), controlPoint1: CGPoint(x: 106.73, y: 17.58), controlPoint2: CGPoint(x: 105.83, y: 18.48))
        bezierPath.addCurve(to: CGPoint(x: 103.21, y: 20.58), controlPoint1: CGPoint(x: 104.33, y: 18.93), controlPoint2: CGPoint(x: 103.43, y: 19.83))
        bezierPath.addCurve(to: CGPoint(x: 101.33, y: 22.46), controlPoint1: CGPoint(x: 102.98, y: 21.33), controlPoint2: CGPoint(x: 102.08, y: 22.23))
        bezierPath.addCurve(to: CGPoint(x: 99.46, y: 24.33), controlPoint1: CGPoint(x: 100.58, y: 22.68), controlPoint2: CGPoint(x: 99.68, y: 23.58))
        bezierPath.addCurve(to: CGPoint(x: 97.58, y: 26.21), controlPoint1: CGPoint(x: 99.23, y: 25.08), controlPoint2: CGPoint(x: 98.33, y: 25.98))
        bezierPath.addCurve(to: CGPoint(x: 95.71, y: 28.08), controlPoint1: CGPoint(x: 96.83, y: 26.43), controlPoint2: CGPoint(x: 95.93, y: 27.33))
        bezierPath.addCurve(to: CGPoint(x: 93.83, y: 29.96), controlPoint1: CGPoint(x: 95.48, y: 28.83), controlPoint2: CGPoint(x: 94.58, y: 29.73))
        bezierPath.addCurve(to: CGPoint(x: 91.96, y: 31.83), controlPoint1: CGPoint(x: 93.08, y: 30.18), controlPoint2: CGPoint(x: 92.18, y: 31.08))
        bezierPath.addCurve(to: CGPoint(x: 90.08, y: 33.71), controlPoint1: CGPoint(x: 91.73, y: 32.58), controlPoint2: CGPoint(x: 90.83, y: 33.48))
        bezierPath.addCurve(to: CGPoint(x: 88.21, y: 35.58), controlPoint1: CGPoint(x: 89.33, y: 33.93), controlPoint2: CGPoint(x: 88.43, y: 34.83))
        bezierPath.addCurve(to: CGPoint(x: 86.33, y: 37.46), controlPoint1: CGPoint(x: 87.98, y: 36.33), controlPoint2: CGPoint(x: 87.08, y: 37.23))
        bezierPath.addCurve(to: CGPoint(x: 84.46, y: 39.33), controlPoint1: CGPoint(x: 85.58, y: 37.68), controlPoint2: CGPoint(x: 84.68, y: 38.58))
        bezierPath.addCurve(to: CGPoint(x: 82.58, y: 41.21), controlPoint1: CGPoint(x: 84.23, y: 40.08), controlPoint2: CGPoint(x: 83.33, y: 40.98))
        bezierPath.addCurve(to: CGPoint(x: 80.71, y: 43.08), controlPoint1: CGPoint(x: 81.83, y: 41.43), controlPoint2: CGPoint(x: 80.93, y: 42.33))
        bezierPath.addCurve(to: CGPoint(x: 78.83, y: 44.96), controlPoint1: CGPoint(x: 80.48, y: 43.83), controlPoint2: CGPoint(x: 79.58, y: 44.73))
        bezierPath.addCurve(to: CGPoint(x: 76.96, y: 46.83), controlPoint1: CGPoint(x: 78.08, y: 45.18), controlPoint2: CGPoint(x: 77.18, y: 46.01))
        bezierPath.addCurve(to: CGPoint(x: 49.88, y: 24.71), controlPoint1: CGPoint(x: 75.83, y: 50.43), controlPoint2: CGPoint(x: 74.33, y: 49.16))
        bezierPath.addLine(to: CGPoint(x: 25.51, y: 0.33))
        bezierPath.addLine(to: CGPoint(x: 14.86, y: 0.33))
        bezierPath.addCurve(to: CGPoint(x: 3.31, y: 1.46), controlPoint1: CGPoint(x: 6.61, y: 0.41), controlPoint2: CGPoint(x: 3.98, y: 0.63))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()

        return bezierPath
    }
    
}
