//
//  Landmine.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class LandminePawn: FairyElement {
    
    var username: String?
    var usernameWhite: String?
    var usernameBlack: String?
    
    func setUsername(username: String) {
        self.username = username
    }
    
    func setUsernameWhite(username: String) {
        self.usernameWhite = username
    }
    
    func setUsernameBlack(username: String) {
        self.usernameBlack = username
    }
    
    init(
        name: String = "LandminePawn",
        imageDefault: UIImage = UIImage(named: "red_landmine_pawn")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "2",
            affiliation: affiliation,
            description: "behaviour identical to a standard pawn with the caveat that when it is captured, the piece that captures it is also removed from the board. self-destructs on promotion. if captured by a king result is instant checkmate for taker",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(4),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        return Pawn().validate(present: present, proposed: proposed, gamestate: gamestate)
    }
    
    public override func getBezierPath() -> UIBezierPath {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 125.18, y: -0.22))
        bezierPath.addCurve(to: CGPoint(x: 123.83, y: 0.91), controlPoint1: CGPoint(x: 124.43, y: 0.01), controlPoint2: CGPoint(x: 123.83, y: 0.53))
        bezierPath.addCurve(to: CGPoint(x: 122.78, y: 1.58), controlPoint1: CGPoint(x: 123.83, y: 1.28), controlPoint2: CGPoint(x: 123.38, y: 1.58))
        bezierPath.addCurve(to: CGPoint(x: 116.33, y: 7.88), controlPoint1: CGPoint(x: 121.36, y: 1.58), controlPoint2: CGPoint(x: 116.33, y: 6.53))
        bezierPath.addCurve(to: CGPoint(x: 115.43, y: 9.23), controlPoint1: CGPoint(x: 116.33, y: 8.48), controlPoint2: CGPoint(x: 115.88, y: 9.08))
        bezierPath.addCurve(to: CGPoint(x: 114.46, y: 16.81), controlPoint1: CGPoint(x: 114.76, y: 9.46), controlPoint2: CGPoint(x: 114.46, y: 11.71))
        bezierPath.addCurve(to: CGPoint(x: 112.81, y: 24.46), controlPoint1: CGPoint(x: 114.46, y: 23.56), controlPoint2: CGPoint(x: 114.38, y: 24.01))
        bezierPath.addCurve(to: CGPoint(x: 110.71, y: 26.33), controlPoint1: CGPoint(x: 111.91, y: 24.68), controlPoint2: CGPoint(x: 110.93, y: 25.51))
        bezierPath.addCurve(to: CGPoint(x: 106.96, y: 26.41), controlPoint1: CGPoint(x: 110.11, y: 28.28), controlPoint2: CGPoint(x: 107.56, y: 28.28))
        bezierPath.addCurve(to: CGPoint(x: 105.01, y: 24.46), controlPoint1: CGPoint(x: 106.73, y: 25.58), controlPoint2: CGPoint(x: 105.83, y: 24.68))
        bezierPath.addCurve(to: CGPoint(x: 103.58, y: 23.26), controlPoint1: CGPoint(x: 104.26, y: 24.16), controlPoint2: CGPoint(x: 103.58, y: 23.63))
        bezierPath.addCurve(to: CGPoint(x: 102.08, y: 22.58), controlPoint1: CGPoint(x: 103.58, y: 22.88), controlPoint2: CGPoint(x: 102.91, y: 22.58))
        bezierPath.addCurve(to: CGPoint(x: 93.16, y: 30.08), controlPoint1: CGPoint(x: 101.18, y: 22.58), controlPoint2: CGPoint(x: 97.58, y: 25.66))
        bezierPath.addCurve(to: CGPoint(x: 84.16, y: 37.58), controlPoint1: CGPoint(x: 88.51, y: 34.81), controlPoint2: CGPoint(x: 85.13, y: 37.58))
        bezierPath.addCurve(to: CGPoint(x: 82.58, y: 36.83), controlPoint1: CGPoint(x: 83.26, y: 37.58), controlPoint2: CGPoint(x: 82.58, y: 37.28))
        bezierPath.addCurve(to: CGPoint(x: 79.58, y: 35.63), controlPoint1: CGPoint(x: 82.58, y: 36.46), controlPoint2: CGPoint(x: 81.23, y: 35.86))
        bezierPath.addCurve(to: CGPoint(x: 76.58, y: 34.51), controlPoint1: CGPoint(x: 77.93, y: 35.33), controlPoint2: CGPoint(x: 76.58, y: 34.88))
        bezierPath.addCurve(to: CGPoint(x: 74.78, y: 33.83), controlPoint1: CGPoint(x: 76.58, y: 34.13), controlPoint2: CGPoint(x: 75.76, y: 33.83))
        bezierPath.addCurve(to: CGPoint(x: 72.61, y: 32.86), controlPoint1: CGPoint(x: 73.81, y: 33.83), controlPoint2: CGPoint(x: 72.83, y: 33.38))
        bezierPath.addCurve(to: CGPoint(x: 43.73, y: 32.86), controlPoint1: CGPoint(x: 72.16, y: 31.51), controlPoint2: CGPoint(x: 44.26, y: 31.51))
        bezierPath.addCurve(to: CGPoint(x: 41.26, y: 33.83), controlPoint1: CGPoint(x: 43.58, y: 33.38), controlPoint2: CGPoint(x: 42.46, y: 33.83))
        bezierPath.addCurve(to: CGPoint(x: 39.08, y: 34.51), controlPoint1: CGPoint(x: 40.06, y: 33.83), controlPoint2: CGPoint(x: 39.08, y: 34.13))
        bezierPath.addCurve(to: CGPoint(x: 35.71, y: 35.78), controlPoint1: CGPoint(x: 39.08, y: 34.96), controlPoint2: CGPoint(x: 37.58, y: 35.48))
        bezierPath.addCurve(to: CGPoint(x: 32.33, y: 36.91), controlPoint1: CGPoint(x: 33.83, y: 36.01), controlPoint2: CGPoint(x: 32.33, y: 36.53))
        bezierPath.addCurve(to: CGPoint(x: 31.21, y: 37.58), controlPoint1: CGPoint(x: 32.33, y: 37.28), controlPoint2: CGPoint(x: 31.81, y: 37.58))
        bezierPath.addCurve(to: CGPoint(x: 30.08, y: 38.26), controlPoint1: CGPoint(x: 30.61, y: 37.58), controlPoint2: CGPoint(x: 30.08, y: 37.88))
        bezierPath.addCurve(to: CGPoint(x: 28.21, y: 39.38), controlPoint1: CGPoint(x: 30.08, y: 38.63), controlPoint2: CGPoint(x: 29.26, y: 39.16))
        bezierPath.addCurve(to: CGPoint(x: 26.33, y: 40.58), controlPoint1: CGPoint(x: 27.16, y: 39.68), controlPoint2: CGPoint(x: 26.33, y: 40.21))
        bezierPath.addCurve(to: CGPoint(x: 25.51, y: 41.33), controlPoint1: CGPoint(x: 26.33, y: 41.03), controlPoint2: CGPoint(x: 25.96, y: 41.33))
        bezierPath.addCurve(to: CGPoint(x: 23.71, y: 42.23), controlPoint1: CGPoint(x: 25.06, y: 41.33), controlPoint2: CGPoint(x: 24.23, y: 41.78))
        bezierPath.addCurve(to: CGPoint(x: 19.96, y: 45.08), controlPoint1: CGPoint(x: 21.46, y: 44.26), controlPoint2: CGPoint(x: 20.41, y: 45.08))
        bezierPath.addCurve(to: CGPoint(x: 12.83, y: 52.81), controlPoint1: CGPoint(x: 18.98, y: 45.08), controlPoint2: CGPoint(x: 12.83, y: 51.76))
        bezierPath.addCurve(to: CGPoint(x: 11.41, y: 54.46), controlPoint1: CGPoint(x: 12.83, y: 53.48), controlPoint2: CGPoint(x: 12.16, y: 54.16))
        bezierPath.addCurve(to: CGPoint(x: 9.38, y: 56.56), controlPoint1: CGPoint(x: 10.58, y: 54.68), controlPoint2: CGPoint(x: 9.68, y: 55.66))
        bezierPath.addCurve(to: CGPoint(x: 7.51, y: 59.41), controlPoint1: CGPoint(x: 9.08, y: 57.46), controlPoint2: CGPoint(x: 8.26, y: 58.73))
        bezierPath.addCurve(to: CGPoint(x: 5.63, y: 63.01), controlPoint1: CGPoint(x: 6.68, y: 60.08), controlPoint2: CGPoint(x: 5.86, y: 61.66))
        bezierPath.addCurve(to: CGPoint(x: 4.51, y: 65.33), controlPoint1: CGPoint(x: 5.33, y: 64.28), controlPoint2: CGPoint(x: 4.88, y: 65.33))
        bezierPath.addCurve(to: CGPoint(x: 3.83, y: 66.46), controlPoint1: CGPoint(x: 4.13, y: 65.33), controlPoint2: CGPoint(x: 3.83, y: 65.86))
        bezierPath.addCurve(to: CGPoint(x: 3.16, y: 67.58), controlPoint1: CGPoint(x: 3.83, y: 67.06), controlPoint2: CGPoint(x: 3.53, y: 67.58))
        bezierPath.addCurve(to: CGPoint(x: 1.96, y: 71.11), controlPoint1: CGPoint(x: 2.78, y: 67.58), controlPoint2: CGPoint(x: 2.26, y: 69.16))
        bezierPath.addCurve(to: CGPoint(x: 0.61, y: 75.23), controlPoint1: CGPoint(x: 1.66, y: 73.13), controlPoint2: CGPoint(x: 1.06, y: 74.93))
        bezierPath.addCurve(to: CGPoint(x: 0.61, y: 105.68), controlPoint1: CGPoint(x: -0.67, y: 75.98), controlPoint2: CGPoint(x: -0.67, y: 104.93))
        bezierPath.addCurve(to: CGPoint(x: 1.96, y: 109.73), controlPoint1: CGPoint(x: 1.06, y: 105.98), controlPoint2: CGPoint(x: 1.66, y: 107.78))
        bezierPath.addCurve(to: CGPoint(x: 3.16, y: 113.33), controlPoint1: CGPoint(x: 2.26, y: 111.76), controlPoint2: CGPoint(x: 2.78, y: 113.33))
        bezierPath.addCurve(to: CGPoint(x: 3.83, y: 114.83), controlPoint1: CGPoint(x: 3.53, y: 113.33), controlPoint2: CGPoint(x: 3.83, y: 114.01))
        bezierPath.addCurve(to: CGPoint(x: 4.51, y: 116.33), controlPoint1: CGPoint(x: 3.83, y: 115.66), controlPoint2: CGPoint(x: 4.13, y: 116.33))
        bezierPath.addCurve(to: CGPoint(x: 5.71, y: 118.58), controlPoint1: CGPoint(x: 4.88, y: 116.33), controlPoint2: CGPoint(x: 5.41, y: 117.38))
        bezierPath.addCurve(to: CGPoint(x: 6.91, y: 120.83), controlPoint1: CGPoint(x: 6.01, y: 119.86), controlPoint2: CGPoint(x: 6.53, y: 120.83))
        bezierPath.addCurve(to: CGPoint(x: 7.58, y: 121.96), controlPoint1: CGPoint(x: 7.28, y: 120.83), controlPoint2: CGPoint(x: 7.58, y: 121.36))
        bezierPath.addCurve(to: CGPoint(x: 9.46, y: 124.88), controlPoint1: CGPoint(x: 7.58, y: 122.63), controlPoint2: CGPoint(x: 8.41, y: 123.91))
        bezierPath.addCurve(to: CGPoint(x: 11.33, y: 127.13), controlPoint1: CGPoint(x: 10.51, y: 125.86), controlPoint2: CGPoint(x: 11.33, y: 126.83))
        bezierPath.addCurve(to: CGPoint(x: 12.31, y: 128.71), controlPoint1: CGPoint(x: 11.33, y: 127.43), controlPoint2: CGPoint(x: 11.78, y: 128.18))
        bezierPath.addCurve(to: CGPoint(x: 15.98, y: 132.61), controlPoint1: CGPoint(x: 13.88, y: 130.58), controlPoint2: CGPoint(x: 15.01, y: 131.71))
        bezierPath.addCurve(to: CGPoint(x: 17.86, y: 134.48), controlPoint1: CGPoint(x: 16.51, y: 133.13), controlPoint2: CGPoint(x: 17.33, y: 133.96))
        bezierPath.addCurve(to: CGPoint(x: 21.53, y: 137.33), controlPoint1: CGPoint(x: 19.28, y: 135.98), controlPoint2: CGPoint(x: 21.01, y: 137.33))
        bezierPath.addCurve(to: CGPoint(x: 23.78, y: 139.21), controlPoint1: CGPoint(x: 21.83, y: 137.33), controlPoint2: CGPoint(x: 22.81, y: 138.16))
        bezierPath.addCurve(to: CGPoint(x: 26.71, y: 141.08), controlPoint1: CGPoint(x: 24.76, y: 140.26), controlPoint2: CGPoint(x: 26.03, y: 141.08))
        bezierPath.addCurve(to: CGPoint(x: 27.83, y: 141.76), controlPoint1: CGPoint(x: 27.31, y: 141.08), controlPoint2: CGPoint(x: 27.83, y: 141.38))
        bezierPath.addCurve(to: CGPoint(x: 30.08, y: 142.96), controlPoint1: CGPoint(x: 27.83, y: 142.13), controlPoint2: CGPoint(x: 28.81, y: 142.66))
        bezierPath.addCurve(to: CGPoint(x: 32.33, y: 144.16), controlPoint1: CGPoint(x: 31.28, y: 143.26), controlPoint2: CGPoint(x: 32.33, y: 143.78))
        bezierPath.addCurve(to: CGPoint(x: 33.83, y: 144.83), controlPoint1: CGPoint(x: 32.33, y: 144.53), controlPoint2: CGPoint(x: 33.01, y: 144.83))
        bezierPath.addCurve(to: CGPoint(x: 35.33, y: 145.51), controlPoint1: CGPoint(x: 34.66, y: 144.83), controlPoint2: CGPoint(x: 35.33, y: 145.13))
        bezierPath.addCurve(to: CGPoint(x: 38.93, y: 146.71), controlPoint1: CGPoint(x: 35.33, y: 145.88), controlPoint2: CGPoint(x: 36.91, y: 146.41))
        bezierPath.addCurve(to: CGPoint(x: 42.98, y: 148.06), controlPoint1: CGPoint(x: 40.88, y: 147.01), controlPoint2: CGPoint(x: 42.68, y: 147.61))
        bezierPath.addCurve(to: CGPoint(x: 73.43, y: 148.06), controlPoint1: CGPoint(x: 43.73, y: 149.33), controlPoint2: CGPoint(x: 72.68, y: 149.33))
        bezierPath.addCurve(to: CGPoint(x: 77.56, y: 146.71), controlPoint1: CGPoint(x: 73.73, y: 147.61), controlPoint2: CGPoint(x: 75.53, y: 147.01))
        bezierPath.addCurve(to: CGPoint(x: 81.08, y: 145.51), controlPoint1: CGPoint(x: 79.51, y: 146.41), controlPoint2: CGPoint(x: 81.08, y: 145.88))
        bezierPath.addCurve(to: CGPoint(x: 82.58, y: 144.83), controlPoint1: CGPoint(x: 81.08, y: 145.13), controlPoint2: CGPoint(x: 81.76, y: 144.83))
        bezierPath.addCurve(to: CGPoint(x: 84.08, y: 144.16), controlPoint1: CGPoint(x: 83.41, y: 144.83), controlPoint2: CGPoint(x: 84.08, y: 144.53))
        bezierPath.addCurve(to: CGPoint(x: 86.11, y: 142.96), controlPoint1: CGPoint(x: 84.08, y: 143.78), controlPoint2: CGPoint(x: 84.98, y: 143.26))
        bezierPath.addCurve(to: CGPoint(x: 89.26, y: 141.16), controlPoint1: CGPoint(x: 87.23, y: 142.73), controlPoint2: CGPoint(x: 88.66, y: 141.91))
        bezierPath.addCurve(to: CGPoint(x: 92.11, y: 139.28), controlPoint1: CGPoint(x: 89.93, y: 140.41), controlPoint2: CGPoint(x: 91.21, y: 139.58))
        bezierPath.addCurve(to: CGPoint(x: 94.21, y: 137.41), controlPoint1: CGPoint(x: 93.01, y: 138.98), controlPoint2: CGPoint(x: 93.98, y: 138.16))
        bezierPath.addCurve(to: CGPoint(x: 96.76, y: 135.61), controlPoint1: CGPoint(x: 94.43, y: 136.66), controlPoint2: CGPoint(x: 95.63, y: 135.83))
        bezierPath.addCurve(to: CGPoint(x: 99.46, y: 133.66), controlPoint1: CGPoint(x: 98.03, y: 135.31), controlPoint2: CGPoint(x: 99.16, y: 134.48))
        bezierPath.addCurve(to: CGPoint(x: 101.33, y: 131.71), controlPoint1: CGPoint(x: 99.68, y: 132.83), controlPoint2: CGPoint(x: 100.58, y: 131.93))
        bezierPath.addCurve(to: CGPoint(x: 103.28, y: 129.68), controlPoint1: CGPoint(x: 102.08, y: 131.48), controlPoint2: CGPoint(x: 102.98, y: 130.51))
        bezierPath.addCurve(to: CGPoint(x: 105.53, y: 126.31), controlPoint1: CGPoint(x: 103.51, y: 128.78), controlPoint2: CGPoint(x: 104.56, y: 127.28))
        bezierPath.addCurve(to: CGPoint(x: 107.33, y: 123.46), controlPoint1: CGPoint(x: 106.51, y: 125.33), controlPoint2: CGPoint(x: 107.33, y: 124.06))
        bezierPath.addCurve(to: CGPoint(x: 108.08, y: 122.33), controlPoint1: CGPoint(x: 107.33, y: 122.86), controlPoint2: CGPoint(x: 107.71, y: 122.33))
        bezierPath.addCurve(to: CGPoint(x: 108.83, y: 121.21), controlPoint1: CGPoint(x: 108.53, y: 122.33), controlPoint2: CGPoint(x: 108.83, y: 121.81))
        bezierPath.addCurve(to: CGPoint(x: 109.58, y: 120.08), controlPoint1: CGPoint(x: 108.83, y: 120.61), controlPoint2: CGPoint(x: 109.13, y: 120.08))
        bezierPath.addCurve(to: CGPoint(x: 110.78, y: 118.21), controlPoint1: CGPoint(x: 109.96, y: 120.08), controlPoint2: CGPoint(x: 110.48, y: 119.26))
        bezierPath.addCurve(to: CGPoint(x: 111.91, y: 116.33), controlPoint1: CGPoint(x: 111.01, y: 117.16), controlPoint2: CGPoint(x: 111.53, y: 116.33))
        bezierPath.addCurve(to: CGPoint(x: 112.58, y: 114.46), controlPoint1: CGPoint(x: 112.28, y: 116.33), controlPoint2: CGPoint(x: 112.58, y: 115.51))
        bezierPath.addCurve(to: CGPoint(x: 113.26, y: 112.58), controlPoint1: CGPoint(x: 112.58, y: 113.41), controlPoint2: CGPoint(x: 112.88, y: 112.58))
        bezierPath.addCurve(to: CGPoint(x: 114.46, y: 108.83), controlPoint1: CGPoint(x: 113.63, y: 112.58), controlPoint2: CGPoint(x: 114.16, y: 110.86))
        bezierPath.addCurve(to: CGPoint(x: 115.66, y: 105.08), controlPoint1: CGPoint(x: 114.76, y: 106.73), controlPoint2: CGPoint(x: 115.28, y: 105.08))
        bezierPath.addCurve(to: CGPoint(x: 116.33, y: 101.33), controlPoint1: CGPoint(x: 116.03, y: 105.08), controlPoint2: CGPoint(x: 116.33, y: 103.36))
        bezierPath.addCurve(to: CGPoint(x: 117.08, y: 97.58), controlPoint1: CGPoint(x: 116.33, y: 99.23), controlPoint2: CGPoint(x: 116.71, y: 97.58))
        bezierPath.addCurve(to: CGPoint(x: 117.83, y: 91.21), controlPoint1: CGPoint(x: 117.53, y: 97.58), controlPoint2: CGPoint(x: 117.83, y: 94.96))
        bezierPath.addCurve(to: CGPoint(x: 117.08, y: 84.83), controlPoint1: CGPoint(x: 117.83, y: 87.46), controlPoint2: CGPoint(x: 117.53, y: 84.83))
        bezierPath.addCurve(to: CGPoint(x: 116.33, y: 81.08), controlPoint1: CGPoint(x: 116.71, y: 84.83), controlPoint2: CGPoint(x: 116.33, y: 83.11))
        bezierPath.addCurve(to: CGPoint(x: 115.66, y: 77.33), controlPoint1: CGPoint(x: 116.33, y: 78.98), controlPoint2: CGPoint(x: 116.03, y: 77.33))
        bezierPath.addCurve(to: CGPoint(x: 114.46, y: 73.21), controlPoint1: CGPoint(x: 115.28, y: 77.33), controlPoint2: CGPoint(x: 114.76, y: 75.46))
        bezierPath.addCurve(to: CGPoint(x: 113.26, y: 69.08), controlPoint1: CGPoint(x: 114.23, y: 70.96), controlPoint2: CGPoint(x: 113.63, y: 69.08))
        bezierPath.addCurve(to: CGPoint(x: 112.58, y: 67.58), controlPoint1: CGPoint(x: 112.88, y: 69.08), controlPoint2: CGPoint(x: 112.58, y: 68.41))
        bezierPath.addCurve(to: CGPoint(x: 111.83, y: 66.08), controlPoint1: CGPoint(x: 112.58, y: 66.76), controlPoint2: CGPoint(x: 112.28, y: 66.08))
        bezierPath.addCurve(to: CGPoint(x: 111.08, y: 64.58), controlPoint1: CGPoint(x: 111.46, y: 66.08), controlPoint2: CGPoint(x: 111.08, y: 65.41))
        bezierPath.addCurve(to: CGPoint(x: 118.58, y: 55.66), controlPoint1: CGPoint(x: 111.08, y: 63.68), controlPoint2: CGPoint(x: 114.01, y: 60.16))
        bezierPath.addCurve(to: CGPoint(x: 126.08, y: 46.73), controlPoint1: CGPoint(x: 123.16, y: 51.08), controlPoint2: CGPoint(x: 126.08, y: 47.63))
        bezierPath.addCurve(to: CGPoint(x: 123.01, y: 42.83), controlPoint1: CGPoint(x: 126.08, y: 45.16), controlPoint2: CGPoint(x: 124.28, y: 42.83))
        bezierPath.addCurve(to: CGPoint(x: 121.88, y: 40.96), controlPoint1: CGPoint(x: 122.63, y: 42.83), controlPoint2: CGPoint(x: 122.18, y: 42.01))
        bezierPath.addCurve(to: CGPoint(x: 123.61, y: 36.91), controlPoint1: CGPoint(x: 121.51, y: 39.46), controlPoint2: CGPoint(x: 121.88, y: 38.56))
        bezierPath.addCurve(to: CGPoint(x: 132.98, y: 34.43), controlPoint1: CGPoint(x: 125.63, y: 34.96), controlPoint2: CGPoint(x: 126.38, y: 34.73))
        bezierPath.addLine(to: CGPoint(x: 140.18, y: 34.06))
        bezierPath.addLine(to: CGPoint(x: 143.86, y: 30.38))
        bezierPath.addCurve(to: CGPoint(x: 148.43, y: 24.16), controlPoint1: CGPoint(x: 145.88, y: 28.36), controlPoint2: CGPoint(x: 147.98, y: 25.51))
        bezierPath.addCurve(to: CGPoint(x: 146.26, y: 5.71), controlPoint1: CGPoint(x: 150.31, y: 18.91), controlPoint2: CGPoint(x: 148.81, y: 6.53))
        bezierPath.addCurve(to: CGPoint(x: 144.46, y: 3.83), controlPoint1: CGPoint(x: 145.51, y: 5.48), controlPoint2: CGPoint(x: 144.68, y: 4.58))
        bezierPath.addCurve(to: CGPoint(x: 142.36, y: 1.88), controlPoint1: CGPoint(x: 144.23, y: 3.08), controlPoint2: CGPoint(x: 143.26, y: 2.18))
        bezierPath.addCurve(to: CGPoint(x: 140.18, y: 0.61), controlPoint1: CGPoint(x: 141.46, y: 1.58), controlPoint2: CGPoint(x: 140.48, y: 1.06))
        bezierPath.addCurve(to: CGPoint(x: 125.18, y: -0.22), controlPoint1: CGPoint(x: 139.66, y: -0.22), controlPoint2: CGPoint(x: 127.43, y: -0.89))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        return bezierPath
    }

}
