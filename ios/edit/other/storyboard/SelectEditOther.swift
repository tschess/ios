//
//  SelectEditOther.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectEditOther {
    
    public func execute(playerSelf: EntityPlayer, playerOther: EntityPlayer, title: String, selection: Int, BACK: String, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "EditOtherL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "EditOtherL") as! EditOther
            viewController.setBACK(BACK: BACK)
            viewController.setPlayerOther(playerOther: playerOther)
            viewController.setPlayerSelf(playerSelf: playerSelf)
            viewController.setSelection(selection: selection)
            viewController.setTitleText(titleText: title)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "EditOtherP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditOtherP") as! EditOther
        viewController.setBACK(BACK: BACK)
        viewController.setPlayerOther(playerOther: playerOther)
        viewController.setPlayerSelf(playerSelf: playerSelf)
        viewController.setSelection(selection: selection)
        viewController.setTitleText(titleText: title)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
