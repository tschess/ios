//
//  SelectProfile.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectProfile {
    
    public func execute(player: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileL", bundle: nil)
            let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileL") as! Profile
            profileViewController.setPlayer(player: player)
            UIApplication.shared.keyWindow?.rootViewController = profileViewController
            return
        }
        let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileP", bundle: nil)
        let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileP") as! Profile
        profileViewController.setPlayer(player: player)
        UIApplication.shared.keyWindow?.rootViewController = profileViewController
    }
}
