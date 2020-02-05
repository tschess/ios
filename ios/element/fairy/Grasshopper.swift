//
//  Grasshopper.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Grasshopper: FairyElement {
    
    let hopper = Hopper()
    
    init(
        name: String = "Grasshopper",
        imageDefault: UIImage = UIImage(named: "red_grasshopper")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "10",
            affiliation: affiliation,
            description: "moves along the same lines as the rook. when capturing lands on the square immediately beyond the target.",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(6),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
//    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) -> Bool {
//        if(hopper.direction_UP(present: present, proposed: proposed, gamestate: gamestate, affiliation: gamestate.getSelfAffiliation())){
//            return true
//        }
//        if(hopper.direction_DOWN(present: present, proposed: proposed, gamestate: gamestate, affiliation: gamestate.getSelfAffiliation())){
//            return true
//        }
//        if(hopper.direction_LEFT(present: present, proposed: proposed, gamestate: gamestate, affiliation: gamestate.getSelfAffiliation())){
//            return true
//        }
//        if(hopper.direction_RIGHT(present: present, proposed: proposed, gamestate: gamestate, affiliation: gamestate.getSelfAffiliation())){
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
        bezierPath.move(to: CGPoint(x: 53.58, y: 8.71))
        bezierPath.addLine(to: CGPoint(x: 53.58, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 47.21, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 40.83, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 40.83, y: 21.46))
        bezierPath.addLine(to: CGPoint(x: 40.83, y: 25.58))
        bezierPath.addLine(to: CGPoint(x: 36.71, y: 25.58))
        bezierPath.addLine(to: CGPoint(x: 32.58, y: 25.58))
        bezierPath.addLine(to: CGPoint(x: 32.58, y: 29.71))
        bezierPath.addLine(to: CGPoint(x: 32.58, y: 33.83))
        bezierPath.addLine(to: CGPoint(x: 28.46, y: 33.83))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 33.83))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 48.46))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 63.08))
        bezierPath.addLine(to: CGPoint(x: 17.21, y: 63.08))
        bezierPath.addLine(to: CGPoint(x: 10.08, y: 63.08))
        bezierPath.addLine(to: CGPoint(x: 10.08, y: 40.21))
        bezierPath.addLine(to: CGPoint(x: 10.08, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 5.21, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 0.33, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 0.33, y: 41.33))
        bezierPath.addLine(to: CGPoint(x: 0.33, y: 65.33))
        bezierPath.addLine(to: CGPoint(x: 3.71, y: 65.33))
        bezierPath.addLine(to: CGPoint(x: 7.08, y: 65.33))
        bezierPath.addLine(to: CGPoint(x: 7.08, y: 69.46))
        bezierPath.addLine(to: CGPoint(x: 7.08, y: 73.58))
        bezierPath.addLine(to: CGPoint(x: 15.71, y: 73.58))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 73.58))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 88.21))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 32.58, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 40.83, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 40.83, y: 112.21))
        bezierPath.addLine(to: CGPoint(x: 40.83, y: 121.58))
        bezierPath.addLine(to: CGPoint(x: 32.58, y: 121.58))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 121.58))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 130.96))
        bezierPath.addLine(to: CGPoint(x: 24.33, y: 140.33))
        bezierPath.addLine(to: CGPoint(x: 33.71, y: 140.33))
        bezierPath.addLine(to: CGPoint(x: 43.08, y: 140.33))
        bezierPath.addLine(to: CGPoint(x: 43.08, y: 132.08))
        bezierPath.addLine(to: CGPoint(x: 43.08, y: 123.83))
        bezierPath.addLine(to: CGPoint(x: 52.76, y: 123.83))
        bezierPath.addCurve(to: CGPoint(x: 63.63, y: 123.38), controlPoint1: CGPoint(x: 58.08, y: 123.83), controlPoint2: CGPoint(x: 62.96, y: 123.61))
        bezierPath.addCurve(to: CGPoint(x: 64.83, y: 112.88), controlPoint1: CGPoint(x: 64.68, y: 123.01), controlPoint2: CGPoint(x: 64.83, y: 121.36))
        bezierPath.addLine(to: CGPoint(x: 64.83, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 75.33, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 85.83, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 85.83, y: 112.88))
        bezierPath.addCurve(to: CGPoint(x: 87.03, y: 123.38), controlPoint1: CGPoint(x: 85.83, y: 121.36), controlPoint2: CGPoint(x: 85.98, y: 123.01))
        bezierPath.addCurve(to: CGPoint(x: 97.91, y: 123.83), controlPoint1: CGPoint(x: 87.71, y: 123.61), controlPoint2: CGPoint(x: 92.58, y: 123.83))
        bezierPath.addLine(to: CGPoint(x: 107.58, y: 123.83))
        bezierPath.addLine(to: CGPoint(x: 107.58, y: 132.08))
        bezierPath.addLine(to: CGPoint(x: 107.58, y: 140.33))
        bezierPath.addLine(to: CGPoint(x: 116.96, y: 140.33))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 140.33))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 130.96))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 121.58))
        bezierPath.addLine(to: CGPoint(x: 118.08, y: 121.58))
        bezierPath.addLine(to: CGPoint(x: 109.83, y: 121.58))
        bezierPath.addLine(to: CGPoint(x: 109.83, y: 112.21))
        bezierPath.addLine(to: CGPoint(x: 109.83, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 118.08, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 102.83))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 88.21))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 73.58))
        bezierPath.addLine(to: CGPoint(x: 134.96, y: 73.58))
        bezierPath.addLine(to: CGPoint(x: 143.58, y: 73.58))
        bezierPath.addLine(to: CGPoint(x: 143.58, y: 69.46))
        bezierPath.addLine(to: CGPoint(x: 143.58, y: 65.33))
        bezierPath.addLine(to: CGPoint(x: 146.96, y: 65.33))
        bezierPath.addLine(to: CGPoint(x: 150.33, y: 65.33))
        bezierPath.addLine(to: CGPoint(x: 150.33, y: 41.33))
        bezierPath.addLine(to: CGPoint(x: 150.33, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 145.46, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 140.58, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 140.58, y: 40.21))
        bezierPath.addLine(to: CGPoint(x: 140.58, y: 63.08))
        bezierPath.addLine(to: CGPoint(x: 133.46, y: 63.08))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 63.08))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 48.46))
        bezierPath.addLine(to: CGPoint(x: 126.33, y: 33.83))
        bezierPath.addLine(to: CGPoint(x: 122.21, y: 33.83))
        bezierPath.addLine(to: CGPoint(x: 118.08, y: 33.83))
        bezierPath.addLine(to: CGPoint(x: 118.08, y: 29.71))
        bezierPath.addLine(to: CGPoint(x: 118.08, y: 25.58))
        bezierPath.addLine(to: CGPoint(x: 113.96, y: 25.58))
        bezierPath.addLine(to: CGPoint(x: 109.83, y: 25.58))
        bezierPath.addLine(to: CGPoint(x: 109.83, y: 21.46))
        bezierPath.addLine(to: CGPoint(x: 109.83, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 103.46, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 97.08, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 97.08, y: 8.71))
        bezierPath.addLine(to: CGPoint(x: 97.08, y: 0.01))
        bezierPath.addLine(to: CGPoint(x: 91.68, y: 0.23))
        bezierPath.addLine(to: CGPoint(x: 86.21, y: 0.46))
        bezierPath.addLine(to: CGPoint(x: 85.98, y: 8.86))
        bezierPath.addLine(to: CGPoint(x: 85.76, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 75.33, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 64.83, y: 17.33))
        bezierPath.addLine(to: CGPoint(x: 64.83, y: 8.71))
        bezierPath.addLine(to: CGPoint(x: 64.83, y: 0.08))
        bezierPath.addLine(to: CGPoint(x: 59.21, y: 0.08))
        bezierPath.addLine(to: CGPoint(x: 53.58, y: 0.08))
        bezierPath.addLine(to: CGPoint(x: 53.58, y: 8.71))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 65.58, y: 63.83))
        bezierPath.addLine(to: CGPoint(x: 65.58, y: 78.83))
        bezierPath.addLine(to: CGPoint(x: 58.46, y: 78.83))
        bezierPath.addLine(to: CGPoint(x: 51.33, y: 78.83))
        bezierPath.addLine(to: CGPoint(x: 51.33, y: 63.83))
        bezierPath.addLine(to: CGPoint(x: 51.33, y: 48.83))
        bezierPath.addLine(to: CGPoint(x: 58.46, y: 48.83))
        bezierPath.addLine(to: CGPoint(x: 65.58, y: 48.83))
        bezierPath.addLine(to: CGPoint(x: 65.58, y: 63.83))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 99.33, y: 63.83))
        bezierPath.addLine(to: CGPoint(x: 99.33, y: 78.83))
        bezierPath.addLine(to: CGPoint(x: 92.21, y: 78.83))
        bezierPath.addLine(to: CGPoint(x: 85.08, y: 78.83))
        bezierPath.addLine(to: CGPoint(x: 85.08, y: 63.83))
        bezierPath.addLine(to: CGPoint(x: 85.08, y: 48.83))
        bezierPath.addLine(to: CGPoint(x: 92.21, y: 48.83))
        bezierPath.addLine(to: CGPoint(x: 99.33, y: 48.83))
        bezierPath.addLine(to: CGPoint(x: 99.33, y: 63.83))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        return bezierPath
    }
    
}
