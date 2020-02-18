//
//  SelectorSnapshot.swift
//  ios
//
//  Created by Matthew on 2/13/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectorSnapshot {
    
    //
    
    
    //todo - move to game entity itself...
    func getSkinGame(username: String, game: EntityGame) -> String {
        if(game.white.username == username){
            return game.white_skin
        }
        return game.black_skin
    }
    
    public func snapshot(skin: String, playerSelf: EntityPlayer, game: EntityGame, presentor: UIViewController) {
        
        switch skin {
        case "IAPETUS":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Iapetus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Iapetus") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
            }
            return
        case "CALYPSO":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Calypso", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Calypso") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
            }
            return
        case "HYPERION":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Hyperion", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Hyperion") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
            }
            return
        case "NEPTUNE":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Neptune", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Neptune") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
            }
            return
        default:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Default", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Default") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
            }
        }
        
    }
    
}
