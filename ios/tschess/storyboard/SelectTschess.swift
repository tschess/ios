//
//  SelectTschess.swift
//  ios
//
//  Created by Matthew on 2/21/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectTschess {
    
    private func getSkin(username: String, game: EntityGame) -> String {
        if(game.white.username == username){
            return game.white_skin
        }
        return game.black_skin
    }
    
    public func tschess(playerSelf: EntityPlayer, playerOther: EntityPlayer, game: EntityGame, height: CGFloat) {
        
        let skin: String = self.getSkin(username: playerSelf.username, game: game)
        
        switch skin {
//        case "IAPETUS":
//            DispatchQueue.main.async {
//                let storyboard: UIStoryboard = UIStoryboard(name: "iTschess", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "iTschess") as! Tschess
//                viewController.setPlayerOther(playerOther: game.getPlayerOther(username: playerSelf.username))
//                viewController.setPlayerSelf(playerSelf: playerSelf)
//                viewController.setGameTschess(gameTschess: game)
//                UIApplication.shared.keyWindow?.rootViewController = viewController
//            }
//            return
        default:
            if(height.isLess(than: 750)){
                let storyboard: UIStoryboard = UIStoryboard(name: "dTschessL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessL") as! Tschess
                viewController.setPlayerOther(playerOther: game.getPlayerOther(username: playerSelf.username))
                viewController.setPlayerSelf(playerSelf: playerSelf)
                viewController.setGameTschess(gameTschess: game)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
            viewController.setPlayerOther(playerOther: game.getPlayerOther(username: playerSelf.username))
            viewController.setPlayerSelf(playerSelf: playerSelf)
            viewController.setGameTschess(gameTschess: game)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
        
        
    }
   
}
