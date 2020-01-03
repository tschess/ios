//
//  BlackLandmine.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackLandminePawn: LandminePawn {
    
    init() {
        super.init(
            name: "BlackLandminePawn",
            imageDefault: UIImage(named: "black_landmine_pawn")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_landmine_pawn"),
            imageSelection: UIImage(named: "selection_black_landmine_pawn")
        )
     }
    
    override public func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        return BlackPawn().validate(present: present, proposed: proposed, gamestate: gamestate)
    }
    
    public override func setImageVisible(imageVisible: UIImage) {
       // let viewController = UIApplication.shared.windows.first!.rootViewController as? Dojo
        //if(viewController != nil){
            //if(imageVisible.isEqual(UIImage(named: "black_pawn"))){
                //self.imageVisible = UIImage(named: "black_pawn")!
                //return
            //}
            //if(imageVisible.isEqual(UIImage(named: "target_black_pawn"))){
                //self.imageVisible = UIImage(named: "target_black_pawn")!
                //return
            //}
            //return
        //}
        if(username! == usernameBlack!){ // it's us...
            self.imageVisible = imageVisible
            return
        }
        if(imageVisible.isEqual(UIImage(named: "black_pawn"))){
            self.imageVisible = UIImage(named: "black_pawn")!
            return
        }
        if(imageVisible.isEqual(UIImage(named: "target_black_pawn"))){
            self.imageVisible = UIImage(named: "target_black_pawn")!
            return
        }
    }
    
    public override func getImageDefault() -> UIImage {
        //let viewController = UIApplication.shared.windows.first!.rootViewController as? Dojo
        //if(viewController != nil){
            //return UIImage(named: "black_pawn")!
        //}
        if(username! == usernameBlack!){
            return imageDefault
        }
        return UIImage(named: "black_pawn")!
    }

    public override func getImageTarget() -> UIImage {
        if(username! == usernameBlack!){
            return imageTarget!
        }
        return UIImage(named: "target_black_pawn")!
    }

}
