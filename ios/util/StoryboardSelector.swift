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
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChessXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChessXandroid") as! Chess
                viewController.setGamestate(gamestate: gamestate)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setPlayer(player: gamestate.getPlayer())
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChessMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChessMagnus") as! Chess
                viewController.setGamestate(gamestate: gamestate)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setPlayer(player: gamestate.getPlayer())
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChessXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChessXenophon") as! Chess
                viewController.setGamestate(gamestate: gamestate)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setPlayer(player: gamestate.getPlayer())
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChessPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChessPhaedrus") as! Chess
                viewController.setGamestate(gamestate: gamestate)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setPlayer(player: gamestate.getPlayer())
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChessCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChessCalhoun") as! Chess
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
                let storyboard: UIStoryboard = UIStoryboard(name: "StartPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "StartPhaedrus") as! Start
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
            case "XANDROID":
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "HomeXandroid", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomeXandroid") as! Config
                homeViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = homeViewController
                return
            case "MAGNUS":
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "HomeMagnus", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomeMagnus") as! Config
                homeViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = homeViewController
                return
            case "XENOPHON":
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "HomeXenophon", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomeXenophon") as! Config
                homeViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = homeViewController
                return
            case "PHAEDRUS":
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "HomePhaedrus", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomePhaedrus") as! Config
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
    
    public func leader(player: Player) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "LeaderXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "LeaderXandroid") as! Leader
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "LeaderMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "LeaderMagnus") as! Leader
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "LeaderXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "LeaderXenophon") as! Leader
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "LeaderPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "LeaderPhaedrus") as! Leader
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "LeaderCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "LeaderCalhoun") as! Leader
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
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
                let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfilePhaedrus", bundle: nil)
                let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfilePhaedrus") as! Profile
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
    
    public func manage(player: Player, defaultSkin: Bool) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let skinsStoryboard: UIStoryboard = UIStoryboard(name: "ManageXandroid", bundle: nil)
                let skinsViewController = skinsStoryboard.instantiateViewController(withIdentifier: "ManageXandroid") as! Manage
                skinsViewController.setPlayer(player: player)
                skinsViewController.setDefaultSkin(defaultSkin: defaultSkin)
                UIApplication.shared.keyWindow?.rootViewController = skinsViewController
                return
            case "MAGNUS":
                let skinsStoryboard: UIStoryboard = UIStoryboard(name: "ManageMagnus", bundle: nil)
                let skinsViewController = skinsStoryboard.instantiateViewController(withIdentifier: "ManageMagnus") as! Manage
                skinsViewController.setPlayer(player: player)
                skinsViewController.setDefaultSkin(defaultSkin: defaultSkin)
                UIApplication.shared.keyWindow?.rootViewController = skinsViewController
                return
            case "XENOPHON":
                let skinsStoryboard: UIStoryboard = UIStoryboard(name: "ManageXenophon", bundle: nil)
                let skinsViewController = skinsStoryboard.instantiateViewController(withIdentifier: "ManageXenophon") as! Manage
                skinsViewController.setPlayer(player: player)
                skinsViewController.setDefaultSkin(defaultSkin: defaultSkin)
                UIApplication.shared.keyWindow?.rootViewController = skinsViewController
                return
            case "PHAEDRUS":
                let skinsStoryboard: UIStoryboard = UIStoryboard(name: "ManagePhaedrus", bundle: nil)
                let skinsViewController = skinsStoryboard.instantiateViewController(withIdentifier: "ManagePhaedrus") as! Manage
                skinsViewController.setPlayer(player: player)
                skinsViewController.setDefaultSkin(defaultSkin: defaultSkin)
                UIApplication.shared.keyWindow?.rootViewController = skinsViewController
                return
            case "CALHOUN":
                let skinsStoryboard: UIStoryboard = UIStoryboard(name: "ManageCalhoun", bundle: nil)
                let skinsViewController = skinsStoryboard.instantiateViewController(withIdentifier: "ManageCalhoun") as! Manage
                skinsViewController.setPlayer(player: player)
                skinsViewController.setDefaultSkin(defaultSkin: defaultSkin)
                UIApplication.shared.keyWindow?.rootViewController = skinsViewController
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
            //case "CALHOUN":
                //let storyboard: UIStoryboard = UIStoryboard(name: "PurchaseCalypsoCalhoun", bundle: nil)
                //let viewController = storyboard.instantiateViewController(withIdentifier: "PurchaseCalypsoCalhoun") as! PurchaseCalypso
                //viewController.setPlayer(player: player)
                //viewController.setRemaining(remaining: remaining)
                //UIApplication.shared.keyWindow?.rootViewController = viewController
                //return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "ShowMeSkins", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ShowMeSkins") as! ShowMeSkins
                viewController.setPlayer(player: player)
                //viewController.setRemaining(remaining: remaining)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func challenge(player: Player, gameModel: Game) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeXandroid") as! Challenge
                viewController.setPlayer(player: player)
                viewController.setGameModel(gameModel: gameModel)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeMagnus") as! Challenge
                viewController.setPlayer(player: player)
                viewController.setGameModel(gameModel: gameModel)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeXenophon") as! Challenge
                viewController.setPlayer(player: player)
                viewController.setGameModel(gameModel: gameModel)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ChallengePhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengePhaedrus") as! Challenge
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
    
    public func cancel(player: Player, gameModel: Game, gameList: [Game]) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "CancelXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "CancelXandroid") as! Cancel
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "CancelMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "CancelMagnus") as! Cancel
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "CancelXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "CancelXenophon") as! Cancel
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "CancelPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "CancelPhaedrus") as! Cancel
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "CancelCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "CancelCalhoun") as! Cancel
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func review(player: Player, gameModel: Game, gameList: [Game]) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "ReviewXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ReviewXandroid") as! Review
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ReviewMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ReviewMagnus") as! Review
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "ReviewXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ReviewXenophon") as! Review
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "ReviewPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ReviewPhaedrus") as! Review
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "ReviewCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ReviewCalhoun") as! Review
                viewController.setGameList(gameList: gameList)
                viewController.setGameModel(gameModel: gameModel)
                viewController.setPlayer(player: player)
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
    
    public func acquisition(player: Player, fairyElement: FairyElement) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "AcquisitionXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "AcquisitionXandroid") as! Acquisition
                viewController.setPlayer(player: player)
                viewController.setFairyElement(fairyElement: fairyElement)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "AcquisitionMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "AcquisitionMagnus") as! Acquisition
                viewController.setPlayer(player: player)
                viewController.setFairyElement(fairyElement: fairyElement)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "AcquisitionXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "AcquisitionXenophon") as! Acquisition
                viewController.setPlayer(player: player)
                viewController.setFairyElement(fairyElement: fairyElement)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "AcquisitionPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "AcquisitionPhaedrus") as! Acquisition
                viewController.setPlayer(player: player)
                viewController.setFairyElement(fairyElement: fairyElement)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "AcquisitionCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "AcquisitionCalhoun") as! Acquisition
                viewController.setPlayer(player: player)
                viewController.setFairyElement(fairyElement: fairyElement)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func eth(player: Player, scan: Bool = false) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "EthXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "EthXandroid") as! Eth
                viewController.setPlayer(player: player)
                viewController.setScan(scan: scan)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "EthMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "EthMagnus") as! Eth
                viewController.setPlayer(player: player)
                viewController.setScan(scan: scan)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "EthXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "EthXenophon") as! Eth
                viewController.setPlayer(player: player)
                viewController.setScan(scan: scan)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "EthPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "EthPhaedrus") as! Eth
                viewController.setPlayer(player: player)
                viewController.setScan(scan: scan)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "EthCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "EthCalhoun") as! Eth
                viewController.setPlayer(player: player)
                viewController.setScan(scan: scan)
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
                let storyboard: UIStoryboard = UIStoryboard(name: "ScannerPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ScannerPhaedrus") as! Scanner
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
                let storyboard: UIStoryboard = UIStoryboard(name: "ActualPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ActualPhaedrus") as! Actual
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
                let storyboard: UIStoryboard = UIStoryboard(name: "HistoricPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HistoricPhaedrus") as! Historic
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
                viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickMagnus") as! Quick
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickXenophon") as! Quick
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickPhaedrus") as! Quick
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "QuickCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "QuickCalhoun") as! Quick
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
    
    public func talk(player: Player, opponent: PlayerCore, gamestate: Gamestate) {
        DispatchQueue.main.async {
            switch self.device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "TalkXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TalkXandroid") as! Talk
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setGamestate(gamestate: gamestate)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "TalkMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TalkMagnus") as! Talk
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setGamestate(gamestate: gamestate)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "TalkXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TalkXenophon") as! Talk
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setGamestate(gamestate: gamestate)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "TalkPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TalkPhaedrus") as! Talk
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setGamestate(gamestate: gamestate)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "TalkCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TalkCalhoun") as! Talk
                viewController.setPlayer(player: player)
                viewController.setOpponent(opponent: opponent)
                viewController.setGameModel(gameModel: gamestate.getGameModel())
                viewController.setGamestate(gamestate: gamestate)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
    }
}
