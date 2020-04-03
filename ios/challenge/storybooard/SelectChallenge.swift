//
//  SelectChallenge.swift
//  ios
//
//  Created by Matthew on 2/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectChallenge {
    
    public func execute(selection: Int, playerSelf: EntityPlayer, playerOther: EntityPlayer, BACK: String, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeL") as! Challenge
            viewController.setPlayerSelf(playerSelf: playerSelf)
            viewController.setPlayerOther(playerOther: playerOther)
            viewController.setSelection(selection: selection)
            viewController.BACK = BACK
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeP") as! Challenge
        viewController.setPlayerSelf(playerSelf: playerSelf)
        viewController.setPlayerOther(playerOther: playerOther)
        viewController.setSelection(selection: selection)
        viewController.BACK = BACK
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
