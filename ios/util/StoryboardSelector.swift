//
//  LayoutSelector.swift
//  ios
//
//  Created by Matthew on 11/12/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class StoryboardSelector {
    
    public func device() -> String {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                //print("iPhone 5 or 5S or 5C")
                return "XANDROID" //???
            case 1334:
                //print("iPhone 6/6S/7/8") //xandroid
                return "XANDROID"
            case 1920, 2208:
                //print("iPhone 6+/6S+/7+/8+") //magnus
                return "MAGNUS"
            case 2436:
                //print("iPhone X/XS/11 Pro")
                return "XENOPHON"
            case 2688:
                //print("iPhone XS Max/11 Pro Max") //calhoun
                return "CALHOUN"
            case 1792:
                //print("iPhone XR/ 11 ") //phaedrus
                return "PHAEDRUS"
            default:
                //print("Unknown")
                return "XANDROID" //???
            }
        }
        return "XANDROID" //???
    }
    
    public func chess(gameModel: Game, player: Player, gamestate: Gamestate) {
        DispatchQueue.main.async {
            switch self.device() {
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                viewController.setGamestate(gamestate: gamestate)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setPlayer(player: gamestate.getPlayer())
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                viewController.setGamestate(gamestate: gamestate)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setPlayer(player: gamestate.getPlayer())
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func chess(gamestate: Gamestate) {
        self.chess(gameModel: gamestate.getGameModel(), player: gamestate.getPlayer(), gamestate: gamestate)
    }
    
    public func start() {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "StartXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "StartXandroid") as! Start
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "StartMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "StartMagnus") as! Start
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "StartXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "StartXenophon") as! Start
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "StartCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "StartCalhoun") as! Start
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "StartCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "StartCalhoun") as! Start
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func home(player: Player) {
        DispatchQueue.main.async {
            switch self.device() {
            case "PHAEDRUS":
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
                homeViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = homeViewController
                return
            case "CALHOUN":
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
                homeViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = homeViewController
                return
            default:
                return
            }
        }
    }
    
    public func profile(player: Player) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileXandroid", bundle: nil)
                let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileXandroid") as! Profile
                profileViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = profileViewController
                return
            case "MAGNUS":
                let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileMagnus", bundle: nil)
                let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileMagnus") as! Profile
                profileViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = profileViewController
                return
            case "XENOPHON":
                let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileXenophon", bundle: nil)
                let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileXenophon") as! Profile
                profileViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = profileViewController
                return
            case "PHAEDRUS":
                let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileCalhoun", bundle: nil)
                let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileCalhoun") as! Profile
                profileViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = profileViewController
                return
            case "CALHOUN":
                let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileCalhoun", bundle: nil)
                let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileCalhoun") as! Profile
                profileViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = profileViewController
                return
            default:
                return
            }
        }
    }
    
    public func purchase(player: Player, remaining: Int) { //PurchaseIapetus
        DispatchQueue.main.async {
            switch self.device() {
                //case "CALHOUN":
                //let storyboard: UIStoryboard = UIStoryboard(name: "PurchaseIapetusCalhoun", bundle: nil)
                //let viewController = storyboard.instantiateViewController(withIdentifier: "PurchaseIapetusCalhoun") as! PurchaseIapetus
                //viewController.setPlayer(player: player)
                //viewController.setRemaining(remaining: remaining)
                //UIApplication.shared.keyWindow?.rootViewController = viewController
            //return
            //case "CALHOUN":
                //let storyboard: UIStoryboard = UIStoryboard(name: "PurchaseHyperionCalhoun", bundle: nil)
                //let viewController = storyboard.instantiateViewController(withIdentifier: "PurchaseHyperionCalhoun") as! PurchaseHyperion
                //viewController.setPlayer(player: player)
                //viewController.setRemaining(remaining: remaining)
                //UIApplication.shared.keyWindow?.rootViewController = viewController
                //return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "Skin", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Skin") as! ShowMeSkins
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "Skin", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Skin") as! ShowMeSkins
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func other(player: Player, gameModel: Game) {
        DispatchQueue.main.async {
            switch self.device() {
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "Other", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Other") as! Other
                viewController.setPlayer(player: player)
                viewController.setGameModel(gameModel: gameModel)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "Other", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Other") as! Other
                viewController.setPlayer(player: player)
                viewController.setGameModel(gameModel: gameModel)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func fairy(player: Player) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "FairyXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FairyXandroid") as! Fairy
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "FairyMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FairyMagnus") as! Fairy
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "FairyXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FairyXenophon") as! Fairy
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "FairyPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FairyPhaedrus") as! Fairy
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "FairyCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FairyCalhoun") as! Fairy
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func scanner(player: Player) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "ScannerXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ScannerXandroid") as! Scanner
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ScannerMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ScannerMagnus") as! Scanner
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "ScannerXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ScannerXenophon") as! Scanner
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ScannerCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ScannerCalhoun") as! Scanner
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "ScannerCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ScannerCalhoun") as! Scanner
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func actual(player: Player) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "ActualXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ActualXandroid") as! Actual
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ActualMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ActualMagnus") as! Actual
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "ActualXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ActualXenophon") as! Actual
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ActualCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ActualCalhoun") as! Actual
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "ActualCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ActualCalhoun") as! Actual
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func historic(player: Player) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "HistoricXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HistoricXandroid") as! Historic
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "HistoricMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HistoricMagnus") as! Historic
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "HistoricXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HistoricXenophon") as! Historic
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "HistoricCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HistoricCalhoun") as! Historic
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "HistoricCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HistoricCalhoun") as! Historic
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func quick(player: Player, opponent: Player) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickXandroid") as! Quick
                viewController.setPlayer(player: player)
                //viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickMagnus") as! Quick
                viewController.setPlayer(player: player)
                //viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickXenophon") as! Quick
                viewController.setPlayer(player: player)
                //viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickPhaedrus") as! Quick
                viewController.setPlayer(player: player)
                //viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickCalhoun") as! Quick
                viewController.setPlayer(player: player)
                //viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
}
