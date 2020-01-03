//
//  Knight.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Knight: TschessElement {
    
    init(
        name: String = "Knight",
        imageDefault: UIImage = UIImage(named: "red_knight")!,
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
            attackVectorList: Array<String>(["Knight"]),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        if(minusTwo_minusOne(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(minusTwo_plusOne(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(plusTwo_minusOne(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(plusTwo_plusOne(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(minusOne_minusTwo(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(minusOne_plusTwo(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(plusOne_minusTwo(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(plusOne_plusTwo(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        
        return false
    }
    
    public func minusTwo_minusOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 2) - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0] - 2][present[1] - 1] != nil) {
                if(tschessElementMatrix[present[0] - 2][present[1] - 1]!.name == "LegalMove") {
                    return true
                }
                return tschessElementMatrix[present[0] - 2][present[1] - 1]!.affiliation !=
                    tschessElementMatrix[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func minusTwo_plusOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 2) - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0] - 2][present[1] + 1] != nil) {
                if(tschessElementMatrix[present[0] - 2][present[1] + 1]!.name == "LegalMove") {
                    return true
                }
                return tschessElementMatrix[present[0] - 2][present[1] + 1]!.affiliation !=
                    tschessElementMatrix[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusTwo_minusOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 2) - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0] + 2][present[1] - 1] != nil) {
                if(tschessElementMatrix[present[0] + 2][present[1] - 1]!.name == "LegalMove") {
                    return true
                }
                return tschessElementMatrix[present[0] + 2][present[1] - 1]!.affiliation !=
                    tschessElementMatrix[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusTwo_plusOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 2) - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0] + 2][present[1] + 1] != nil) {
                if(tschessElementMatrix[present[0] + 2][present[1] + 1]!.name == "LegalMove") {
                    return true
                }
                return tschessElementMatrix[present[0] + 2][present[1] + 1]!.affiliation !=
                    tschessElementMatrix[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    
    public func minusOne_minusTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 1) - proposed[0] == 0 && (present[1] - 2) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0] - 1][present[1] - 2] != nil) {
                if(tschessElementMatrix[present[0] - 1][present[1] - 2]!.name == "LegalMove") {
                    return true
                }
                return tschessElementMatrix[present[0] - 1][present[1] - 2]!.affiliation !=
                    tschessElementMatrix[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    
    public func minusOne_plusTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 1) - proposed[0] == 0 && (present[1] + 2) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0] - 1][present[1] + 2] != nil) {
                if(tschessElementMatrix[present[0] - 1][present[1] + 2]!.name == "LegalMove") {
                    return true
                }
                return tschessElementMatrix[present[0] - 1][present[1] + 2]!.affiliation !=
                    tschessElementMatrix[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusOne_minusTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 1) - proposed[0] == 0 && (present[1] - 2) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0] + 1][present[1] - 2] != nil) {
                if(tschessElementMatrix[present[0] + 1][present[1] - 2]!.name == "LegalMove") {
                    return true
                }
                return tschessElementMatrix[present[0] + 1][present[1] - 2]!.affiliation !=
                    tschessElementMatrix[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusOne_plusTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 1) - proposed[0] == 0 && (present[1] + 2) - proposed[1] == 0) {
            if(tschessElementMatrix[present[0] + 1][present[1] + 2] != nil) {
                if(tschessElementMatrix[present[0] + 1][present[1] + 2]!.name == "LegalMove") {
                    return true
                }
                return tschessElementMatrix[present[0] + 1][present[1] + 2]!.affiliation !=
                    tschessElementMatrix[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public override func getBezierPath() -> UIBezierPath {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 58.33, y: -0.07))
        bezierPath.addCurve(to: CGPoint(x: 27.81, y: 7.28), controlPoint1: CGPoint(x: 45.96, y: 0.46), controlPoint2: CGPoint(x: 34.86, y: 3.16))
        bezierPath.addCurve(to: CGPoint(x: 6.58, y: 34.73), controlPoint1: CGPoint(x: 20.61, y: 11.48), controlPoint2: CGPoint(x: 12.58, y: 21.83))
        bezierPath.addCurve(to: CGPoint(x: 1.26, y: 73.58), controlPoint1: CGPoint(x: 1.48, y: 45.68), controlPoint2: CGPoint(x: -0.99, y: 63.91))
        bezierPath.addCurve(to: CGPoint(x: 14.53, y: 99.53), controlPoint1: CGPoint(x: 2.83, y: 79.96), controlPoint2: CGPoint(x: 9.06, y: 92.26))
        bezierPath.addCurve(to: CGPoint(x: 32.23, y: 129.46), controlPoint1: CGPoint(x: 20.61, y: 107.71), controlPoint2: CGPoint(x: 27.58, y: 119.48))
        bezierPath.addCurve(to: CGPoint(x: 38.38, y: 142.73), controlPoint1: CGPoint(x: 34.11, y: 133.58), controlPoint2: CGPoint(x: 36.96, y: 139.58))
        bezierPath.addLine(to: CGPoint(x: 41.08, y: 148.58))
        bezierPath.addLine(to: CGPoint(x: 47.31, y: 148.58))
        bezierPath.addCurve(to: CGPoint(x: 55.48, y: 145.13), controlPoint1: CGPoint(x: 54.36, y: 148.58), controlPoint2: CGPoint(x: 56.76, y: 147.53))
        bezierPath.addCurve(to: CGPoint(x: 53.08, y: 137.71), controlPoint1: CGPoint(x: 55.11, y: 144.38), controlPoint2: CGPoint(x: 53.98, y: 141.01))
        bezierPath.addCurve(to: CGPoint(x: 50.91, y: 130.96), controlPoint1: CGPoint(x: 52.18, y: 134.41), controlPoint2: CGPoint(x: 51.21, y: 131.33))
        bezierPath.addCurve(to: CGPoint(x: 48.36, y: 124.21), controlPoint1: CGPoint(x: 50.61, y: 130.51), controlPoint2: CGPoint(x: 49.48, y: 127.51))
        bezierPath.addCurve(to: CGPoint(x: 44.38, y: 112.96), controlPoint1: CGPoint(x: 47.31, y: 120.91), controlPoint2: CGPoint(x: 45.51, y: 115.81))
        bezierPath.addCurve(to: CGPoint(x: 40.86, y: 98.26), controlPoint1: CGPoint(x: 41.91, y: 106.36), controlPoint2: CGPoint(x: 40.11, y: 99.01))
        bezierPath.addCurve(to: CGPoint(x: 95.83, y: 95.93), controlPoint1: CGPoint(x: 41.53, y: 97.66), controlPoint2: CGPoint(x: 87.66, y: 95.71))
        bezierPath.addCurve(to: CGPoint(x: 110.83, y: 101.11), controlPoint1: CGPoint(x: 103.11, y: 96.16), controlPoint2: CGPoint(x: 108.81, y: 98.11))
        bezierPath.addCurve(to: CGPoint(x: 112.48, y: 109.43), controlPoint1: CGPoint(x: 112.26, y: 103.21), controlPoint2: CGPoint(x: 112.48, y: 104.48))
        bezierPath.addCurve(to: CGPoint(x: 110.91, y: 119.33), controlPoint1: CGPoint(x: 112.41, y: 113.03), controlPoint2: CGPoint(x: 111.81, y: 116.78))
        bezierPath.addCurve(to: CGPoint(x: 101.68, y: 141.31), controlPoint1: CGPoint(x: 107.08, y: 130.51), controlPoint2: CGPoint(x: 104.46, y: 136.66))
        bezierPath.addCurve(to: CGPoint(x: 99.06, y: 146.78), controlPoint1: CGPoint(x: 100.03, y: 144.08), controlPoint2: CGPoint(x: 98.83, y: 146.56))
        bezierPath.addCurve(to: CGPoint(x: 110.08, y: 147.16), controlPoint1: CGPoint(x: 99.73, y: 147.53), controlPoint2: CGPoint(x: 107.31, y: 147.76))
        bezierPath.addCurve(to: CGPoint(x: 113.46, y: 143.11), controlPoint1: CGPoint(x: 112.26, y: 146.71), controlPoint2: CGPoint(x: 112.63, y: 146.26))
        bezierPath.addCurve(to: CGPoint(x: 117.66, y: 135.23), controlPoint1: CGPoint(x: 113.98, y: 141.08), controlPoint2: CGPoint(x: 115.78, y: 137.71))
        bezierPath.addCurve(to: CGPoint(x: 128.91, y: 117.08), controlPoint1: CGPoint(x: 122.91, y: 128.48), controlPoint2: CGPoint(x: 126.21, y: 123.16))
        bezierPath.addCurve(to: CGPoint(x: 131.68, y: 103.81), controlPoint1: CGPoint(x: 131.16, y: 112.13), controlPoint2: CGPoint(x: 131.46, y: 110.56))
        bezierPath.addCurve(to: CGPoint(x: 126.73, y: 83.71), controlPoint1: CGPoint(x: 131.98, y: 94.96), controlPoint2: CGPoint(x: 131.01, y: 90.91))
        bezierPath.addCurve(to: CGPoint(x: 113.16, y: 70.36), controlPoint1: CGPoint(x: 122.76, y: 77.11), controlPoint2: CGPoint(x: 118.71, y: 73.13))
        bezierPath.addLine(to: CGPoint(x: 108.21, y: 67.96))
        bezierPath.addLine(to: CGPoint(x: 91.71, y: 67.96))
        bezierPath.addCurve(to: CGPoint(x: 61.71, y: 68.18), controlPoint1: CGPoint(x: 82.63, y: 67.96), controlPoint2: CGPoint(x: 69.13, y: 68.03))
        bezierPath.addCurve(to: CGPoint(x: 46.93, y: 67.96), controlPoint1: CGPoint(x: 54.21, y: 68.33), controlPoint2: CGPoint(x: 47.61, y: 68.18))
        bezierPath.addCurve(to: CGPoint(x: 42.13, y: 54.83), controlPoint1: CGPoint(x: 44.91, y: 67.13), controlPoint2: CGPoint(x: 43.41, y: 62.93))
        bezierPath.addCurve(to: CGPoint(x: 44.98, y: 30.61), controlPoint1: CGPoint(x: 40.78, y: 45.38), controlPoint2: CGPoint(x: 41.38, y: 39.83))
        bezierPath.addCurve(to: CGPoint(x: 56.08, y: 15.23), controlPoint1: CGPoint(x: 47.83, y: 23.18), controlPoint2: CGPoint(x: 51.06, y: 18.68))
        bezierPath.addCurve(to: CGPoint(x: 74.23, y: 9.68), controlPoint1: CGPoint(x: 60.43, y: 12.23), controlPoint2: CGPoint(x: 68.31, y: 9.83))
        bezierPath.addCurve(to: CGPoint(x: 92.23, y: 14.18), controlPoint1: CGPoint(x: 80.38, y: 9.46), controlPoint2: CGPoint(x: 89.31, y: 11.71))
        bezierPath.addCurve(to: CGPoint(x: 94.03, y: 20.41), controlPoint1: CGPoint(x: 94.41, y: 16.06), controlPoint2: CGPoint(x: 94.48, y: 16.28))
        bezierPath.addCurve(to: CGPoint(x: 92.46, y: 28.96), controlPoint1: CGPoint(x: 93.73, y: 22.81), controlPoint2: CGPoint(x: 93.06, y: 26.63))
        bezierPath.addCurve(to: CGPoint(x: 83.01, y: 49.58), controlPoint1: CGPoint(x: 91.18, y: 33.61), controlPoint2: CGPoint(x: 83.91, y: 49.58))
        bezierPath.addCurve(to: CGPoint(x: 81.88, y: 47.86), controlPoint1: CGPoint(x: 82.71, y: 49.58), controlPoint2: CGPoint(x: 82.18, y: 48.83))
        bezierPath.addCurve(to: CGPoint(x: 80.91, y: 42.61), controlPoint1: CGPoint(x: 81.06, y: 45.53), controlPoint2: CGPoint(x: 81.06, y: 45.38))
        bezierPath.addCurve(to: CGPoint(x: 77.08, y: 35.33), controlPoint1: CGPoint(x: 80.83, y: 40.96), controlPoint2: CGPoint(x: 79.63, y: 38.71))
        bezierPath.addCurve(to: CGPoint(x: 73.33, y: 28.88), controlPoint1: CGPoint(x: 75.06, y: 32.63), controlPoint2: CGPoint(x: 73.41, y: 29.78))
        bezierPath.addCurve(to: CGPoint(x: 77.76, y: 24.46), controlPoint1: CGPoint(x: 73.33, y: 27.08), controlPoint2: CGPoint(x: 75.43, y: 24.91))
        bezierPath.addCurve(to: CGPoint(x: 78.96, y: 18.61), controlPoint1: CGPoint(x: 81.43, y: 23.78), controlPoint2: CGPoint(x: 81.81, y: 21.83))
        bezierPath.addCurve(to: CGPoint(x: 71.46, y: 17.63), controlPoint1: CGPoint(x: 76.93, y: 16.36), controlPoint2: CGPoint(x: 75.21, y: 16.13))
        bezierPath.addCurve(to: CGPoint(x: 65.76, y: 34.06), controlPoint1: CGPoint(x: 66.81, y: 19.58), controlPoint2: CGPoint(x: 63.66, y: 28.58))
        bezierPath.addCurve(to: CGPoint(x: 73.41, y: 41.71), controlPoint1: CGPoint(x: 66.58, y: 36.23), controlPoint2: CGPoint(x: 70.56, y: 40.21))
        bezierPath.addCurve(to: CGPoint(x: 75.06, y: 48.98), controlPoint1: CGPoint(x: 75.73, y: 42.91), controlPoint2: CGPoint(x: 76.78, y: 47.56))
        bezierPath.addCurve(to: CGPoint(x: 75.13, y: 55.81), controlPoint1: CGPoint(x: 73.78, y: 50.03), controlPoint2: CGPoint(x: 73.86, y: 54.08))
        bezierPath.addCurve(to: CGPoint(x: 82.78, y: 58.58), controlPoint1: CGPoint(x: 76.18, y: 57.16), controlPoint2: CGPoint(x: 80.01, y: 58.58))
        bezierPath.addCurve(to: CGPoint(x: 99.58, y: 32.41), controlPoint1: CGPoint(x: 86.68, y: 58.58), controlPoint2: CGPoint(x: 96.66, y: 43.21))
        bezierPath.addCurve(to: CGPoint(x: 100.33, y: 10.58), controlPoint1: CGPoint(x: 101.23, y: 26.56), controlPoint2: CGPoint(x: 101.61, y: 15.16))
        bezierPath.addCurve(to: CGPoint(x: 70.71, y: 0.23), controlPoint1: CGPoint(x: 98.83, y: 5.11), controlPoint2: CGPoint(x: 87.73, y: 1.21))
        bezierPath.addCurve(to: CGPoint(x: 58.33, y: -0.07), controlPoint1: CGPoint(x: 66.21, y: -0.07), controlPoint2: CGPoint(x: 60.58, y: -0.22))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 46.33, y: 11.03))
        bezierPath.addCurve(to: CGPoint(x: 32.91, y: 34.58), controlPoint1: CGPoint(x: 40.33, y: 16.13), controlPoint2: CGPoint(x: 35.83, y: 24.01))
        bezierPath.addCurve(to: CGPoint(x: 32.01, y: 63.31), controlPoint1: CGPoint(x: 31.26, y: 40.51), controlPoint2: CGPoint(x: 30.81, y: 53.93))
        bezierPath.addLine(to: CGPoint(x: 32.53, y: 67.58))
        bezierPath.addLine(to: CGPoint(x: 29.91, y: 68.33))
        bezierPath.addCurve(to: CGPoint(x: 12.13, y: 68.93), controlPoint1: CGPoint(x: 26.61, y: 69.16), controlPoint2: CGPoint(x: 12.88, y: 69.61))
        bezierPath.addCurve(to: CGPoint(x: 12.58, y: 54.08), controlPoint1: CGPoint(x: 11.46, y: 68.18), controlPoint2: CGPoint(x: 11.68, y: 60.53))
        bezierPath.addCurve(to: CGPoint(x: 20.31, y: 30.76), controlPoint1: CGPoint(x: 13.48, y: 47.78), controlPoint2: CGPoint(x: 17.61, y: 35.33))
        bezierPath.addCurve(to: CGPoint(x: 40.93, y: 11.63), controlPoint1: CGPoint(x: 25.26, y: 22.43), controlPoint2: CGPoint(x: 34.93, y: 13.51))
        bezierPath.addCurve(to: CGPoint(x: 45.58, y: 9.83), controlPoint1: CGPoint(x: 42.88, y: 11.11), controlPoint2: CGPoint(x: 44.98, y: 10.28))
        bezierPath.addCurve(to: CGPoint(x: 46.33, y: 11.03), controlPoint1: CGPoint(x: 47.98, y: 8.26), controlPoint2: CGPoint(x: 48.58, y: 9.16))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 91.03, y: 101.48))
        bezier2Path.addCurve(to: CGPoint(x: 84.73, y: 116.71), controlPoint1: CGPoint(x: 89.98, y: 103.21), controlPoint2: CGPoint(x: 88.86, y: 105.91))
        bezier2Path.addCurve(to: CGPoint(x: 79.48, y: 133.73), controlPoint1: CGPoint(x: 80.61, y: 127.66), controlPoint2: CGPoint(x: 79.26, y: 132.08))
        bezier2Path.addCurve(to: CGPoint(x: 85.26, y: 137.48), controlPoint1: CGPoint(x: 79.63, y: 135.01), controlPoint2: CGPoint(x: 80.98, y: 135.83))
        bezier2Path.addCurve(to: CGPoint(x: 92.38, y: 139.43), controlPoint1: CGPoint(x: 88.33, y: 138.68), controlPoint2: CGPoint(x: 91.56, y: 139.58))
        bezier2Path.addCurve(to: CGPoint(x: 99.58, y: 126.08), controlPoint1: CGPoint(x: 94.18, y: 139.13), controlPoint2: CGPoint(x: 94.63, y: 138.38))
        bezier2Path.addCurve(to: CGPoint(x: 105.28, y: 112.51), controlPoint1: CGPoint(x: 101.68, y: 120.91), controlPoint2: CGPoint(x: 104.23, y: 114.83))
        bezier2Path.addCurve(to: CGPoint(x: 98.46, y: 101.26), controlPoint1: CGPoint(x: 108.51, y: 104.93), controlPoint2: CGPoint(x: 108.13, y: 104.33))
        bezier2Path.addCurve(to: CGPoint(x: 91.03, y: 101.48), controlPoint1: CGPoint(x: 92.76, y: 99.46), controlPoint2: CGPoint(x: 92.31, y: 99.46))
        bezier2Path.close()
        fillColor.setFill()
        bezier2Path.fill()


        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 8.98, y: 105.98))
        bezier3Path.addCurve(to: CGPoint(x: 15.13, y: 139.58), controlPoint1: CGPoint(x: 9.51, y: 111.98), controlPoint2: CGPoint(x: 14.16, y: 137.48))
        bezier3Path.addCurve(to: CGPoint(x: 20.38, y: 141.31), controlPoint1: CGPoint(x: 15.96, y: 141.31), controlPoint2: CGPoint(x: 16.41, y: 141.46))
        bezier3Path.addCurve(to: CGPoint(x: 25.11, y: 140.86), controlPoint1: CGPoint(x: 22.78, y: 141.23), controlPoint2: CGPoint(x: 24.88, y: 141.01))
        bezier3Path.addCurve(to: CGPoint(x: 23.61, y: 127.58), controlPoint1: CGPoint(x: 25.26, y: 140.63), controlPoint2: CGPoint(x: 24.58, y: 134.71))
        bezier3Path.addCurve(to: CGPoint(x: 18.88, y: 110.48), controlPoint1: CGPoint(x: 21.81, y: 115.21), controlPoint2: CGPoint(x: 21.66, y: 114.53))
        bezier3Path.addCurve(to: CGPoint(x: 10.56, y: 102.08), controlPoint1: CGPoint(x: 14.16, y: 103.66), controlPoint2: CGPoint(x: 12.58, y: 102.08))
        bezier3Path.addCurve(to: CGPoint(x: 8.98, y: 105.98), controlPoint1: CGPoint(x: 8.76, y: 102.08), controlPoint2: CGPoint(x: 8.68, y: 102.23))
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
