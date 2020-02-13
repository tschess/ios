//
//  SelectorTschess.swift
//  ios
//
//  Created by Matthew on 2/13/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectorTschess {
    
    //
    
    private func getSkin(username: String, game: EntityGame) -> String {
        if(game.white.username == username){
            return game.white_skin
        }
        return game.black_skin
    }
    
    public func tschess(playerSelf: EntityPlayer, playerOther: EntityPlayer, game: EntityGame) {
        
        let skin: String = self.getSkin(username: playerSelf.username, game: game)
        
        switch skin {
        case "IAPETUS":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "iTschess", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "iTschess") as! Tschess
                viewController.setPlayerOther(playerOther: game.getPlayerOther(username: playerSelf.username))
                viewController.setPlayerSelf(playerSelf: playerSelf)
                viewController.setGameTschess(gameTschess: game)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        default:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "dTschess", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "dTschess") as! Tschess
                viewController.setPlayerOther(playerOther: game.getPlayerOther(username: playerSelf.username))
                viewController.setPlayerSelf(playerSelf: playerSelf)
                viewController.setGameTschess(gameTschess: game)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
        
        
    }
   
}
