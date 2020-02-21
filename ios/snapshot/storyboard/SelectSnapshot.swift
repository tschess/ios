//
//  SelectSnapshot.swift
//  ios
//
//  Created by Matthew on 2/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectSnapshot {
    
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
                let height: CGFloat = presentor.view.frame.size.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "IapetusL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "IapetusL") as! Snapshot
                    viewController.setGame(game: game)
                    viewController.setPlayer(player: playerSelf)
                    presentor.present(viewController, animated: false, completion: nil)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "IapetusP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "IapetusP") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
                return
            }
        case "CALYPSO":
            DispatchQueue.main.async {
                let height: CGFloat = presentor.view.frame.size.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "CalypsoL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "CalypsoL") as! Snapshot
                    viewController.setGame(game: game)
                    viewController.setPlayer(player: playerSelf)
                    presentor.present(viewController, animated: false, completion: nil)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "CalypsoP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "CalypsoP") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
                return
            }
        case "HYPERION":
            DispatchQueue.main.async {
                let height: CGFloat = presentor.view.frame.size.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "HyperionL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "HyperionL") as! Snapshot
                    viewController.setGame(game: game)
                    viewController.setPlayer(player: playerSelf)
                    presentor.present(viewController, animated: false, completion: nil)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "HyperionP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HyperionP") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
                return
            }
        case "NEPTUNE":
            DispatchQueue.main.async {
                let height: CGFloat = presentor.view.frame.size.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "NeptuneL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "NeptuneL") as! Snapshot
                    viewController.setGame(game: game)
                    viewController.setPlayer(player: playerSelf)
                    presentor.present(viewController, animated: false, completion: nil)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "NeptuneP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "NeptuneP") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
                return
            }
        default:
            DispatchQueue.main.async {
                let height: CGFloat = presentor.view.frame.size.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "DefaultL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "DefaultL") as! Snapshot
                    viewController.setGame(game: game)
                    viewController.setPlayer(player: playerSelf)
                    presentor.present(viewController, animated: false, completion: nil)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "DefaultP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "DefaultP") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
                return
            }
        }
        
    }
    
}
