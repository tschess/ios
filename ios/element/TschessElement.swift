//
//  FairyElement.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class TschessElement {
    
    var name: String
    var strength: String
    var imageDefault: UIImage
    
    var affiliation: String
    
    var imageVisible: UIImage
    var imageTarget: UIImage?
    var imageSelection: UIImage?
    
    var isTarget: Bool
    var isHopped: Bool
    var firstTouch: Bool
    var standard: Bool
    
    var attackVectorList: Array<String>
    
    init(
        name: String,
        strength: String,
        affiliation: String,
        imageDefault: UIImage,
        standard: Bool,
        attackVectorList: Array<String>,
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        self.name = name
        self.strength = strength
        self.affiliation = affiliation
        self.imageTarget = imageTarget
        self.imageDefault = imageDefault
        self.imageSelection = imageSelection
        self.standard = standard
        self.attackVectorList = attackVectorList
        
        self.isTarget  = false
        self.isHopped = false
        self.firstTouch = true
        self.imageVisible = imageDefault
    }
    
    func getName() -> String {
        return name
    }
    
    func getStrength() -> String {
        return strength
    }
    
    func getImageDefault() -> UIImage {
        return imageDefault
    }
    
    func setImageVisible(imageVisible: UIImage) {
        self.imageVisible = imageVisible
    }
    
    func getImageVisible() -> UIImage {
        return imageVisible
    }
    
    func getImageTarget() -> UIImage {
        return imageTarget!
    }
    
    func getImageSelection() -> UIImage {
        return imageSelection!
    }
    
    func setFirstTouch(firstTouch: Bool) {
        self.firstTouch = firstTouch
    }
    
    func getFirstTouch() -> Bool {
        return firstTouch
    }
    
    func setHopped() {
        self.isHopped = true
    }
    
    func getHopped() -> Bool {
        return self.isHopped
    }
    
//    public func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        return false
//    }
    
    public func getBezierPath() -> UIBezierPath {
        return UIBezierPath()
    }
}

extension TschessElement: Equatable {
    static func == (lhs: TschessElement, rhs: TschessElement) -> Bool {
        return lhs.name == rhs.name
    }
}
