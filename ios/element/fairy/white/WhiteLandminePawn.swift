//
//  WhiteLandmine.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteLandminePawn: LandminePawn {
    
    init() {
        super.init(
            name: "WhiteLandminePawn",
            imageDefault: UIImage(named: "white_landmine_pawn")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_landmine_pawn"),
            imageSelection: UIImage(named: "selection_white_landmine_pawn")
        )
    }
    
    public override func setImageVisible(imageVisible: UIImage) {
        //let viewController = UIApplication.shared.windows.first!.rootViewController as? Dojo
        //if(viewController != nil){
            //self.imageVisible = imageVisible
            //return
        //}
        if(username! == usernameWhite!){ // it's us...
            self.imageVisible = imageVisible
            return
        }
        if(imageVisible.isEqual(UIImage(named: "white_pawn"))){
            self.imageVisible = UIImage(named: "white_pawn")!
            return
        }
        if(imageVisible.isEqual(UIImage(named: "target_white_pawn"))){
            self.imageVisible = UIImage(named: "target_white_pawn")!
            return
        }
    }
    
    public override func getImageDefault() -> UIImage {
        //let viewController = UIApplication.shared.windows.first!.rootViewController as? Dojo
        //if(viewController != nil){
            //return UIImage(named: "white_landmine_pawn")!
        //}
        if(username! == usernameWhite!){
            return imageDefault
        }
        return UIImage(named: "white_pawn")!
    }

    public override func getImageTarget() -> UIImage {
        if(username! == usernameWhite!){
            return imageTarget!
        }
        return UIImage(named: "target_white_pawn")!
    }
    
}

