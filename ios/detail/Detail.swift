//
//  Detail.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import StoreKit

class Detail: UIViewController, UITabBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let DURATION_PLACEHOLDER: String = "18.01.2020_15:45:53.2060"
    
    var counter: String?
    var dateTime: DateTime?
    var counterTimer: Timer?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.counter = "24:00:00"
        self.dateTime = DateTime()
    }
    
    func parseDuration(_ timeString:String) -> TimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }
        var interval: Double = 0
        let parts = timeString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        return interval
    }
    
    @objc func updateCounter() {
        if(self.counter == nil){
            return
        }
        var timeInterval_x = self.parseDuration(self.counter!)
        timeInterval_x -= TimeInterval(1.0)
        
        let sec = Int(timeInterval_x.truncatingRemainder(dividingBy: 60))
        let min = Int(timeInterval_x.truncatingRemainder(dividingBy: 3600) / 60)
        let hour = Int(timeInterval_x / 3600)
        
        self.counter = String(format: "%02d:%02d:%02d", hour, min, sec)
        self.countdownTimerLabel.text = self.counter
        self.countdownTimerLabel.isHidden = false
    }
    
    func startTimers() {
        guard counterTimer == nil else {
            return
        }
        self.counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func stopTimers() {
        self.counterTimer?.invalidate()
        self.counterTimer = nil
    }
    
    private func updateCountdownTimer() {
        let countdownTimer_format: Date  = self.dateTime!.toFormatDate(string: self.DURATION_PLACEHOLDER)
        let countdownTimer_format_rn = self.dateTime!.currentDate()
        let secondsBetween: TimeInterval = countdownTimer_format_rn.timeIntervalSince(countdownTimer_format)
        let clock = "24"
        let limit: TimeInterval = Double(clock)! * 60 * 60
        self.counter = String(limit - secondsBetween)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startTimers()
        
        self.activityIndicator.isHidden = true
    }
    
    var skin: EntitySkin?
    
    public func setSkin(skin: EntitySkin){
        self.skin = skin
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var countdownTimerLabel: UILabel!
    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var cellBackgroundImage: UIImageView!
    @IBOutlet weak var cellForegroundView: UIView!
    @IBOutlet weak var cellForegroundImage: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.player!.getImageAvatar()
        self.usernameLabel.text = self.player!.username
        self.eloLabel.text = self.player!.getLabelTextElo()
        self.rankLabel.text = self.player!.getLabelTextRank()
        self.displacementLabel.text = self.player!.getLabelTextDisp()
        self.displacementImage.image = self.player!.getImageDisp()!
        self.displacementImage.tintColor = self.player!.tintColor
    }
    
    var remaining: Int?
    
    public func setRemaining(remaining: Int){
        self.remaining = remaining
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countdownTimerLabel.isHidden = true
        
        self.tabBarMenu.delegate = self
        
        let description = "" +
            "• freshly minted individual edition of the iapetus game skin, one of fifty\r\r" +
            "• visible to oneself and opponent during gameplay\r\r" +
            "• globally visible in leaderboard and on challenge/review endgame snapshot\r\r" +
        "• design inspired by science fantasy novel \"the chessmen of mars\" by edgar rice burroughs\r\r"
        
        self.descriptionTextView.isEditable = false
        self.descriptionTextView.backgroundColor = UIColor.white
        self.descriptionTextView.textColor = UIColor.black
        self.descriptionTextView.text = description
        
        //Product.store.requestProducts{ [weak self] success, products in
        //guard let self = self else {
        //return
        //}
        //if success {
        //self.products = products!
        //let product: SKProduct = self.products[0]
        //DispatchQueue.main.async {
        //self.purchaseButton.setTitle( "$\(product.price.floatValue)" , for: .normal)
        //}
        //}
        //}
        
        
        
        self.titleLabel.text = self.skin!.getName()
        
        self.cellForegroundView.backgroundColor = self.skin!.getForeColor()
        self.cellForegroundView.alpha = self.skin!.getForeAlpha()
        self.cellForegroundImage.image = self.skin!.getForeImage()
        
        self.cellBackgroundView.backgroundColor = self.skin!.getBackColor()
        self.cellBackgroundView.alpha = self.skin!.getBackAlpha()
        self.cellBackgroundImage.image = self.skin!.getBackImage()
        
    }
    
    var products: [SKProduct] = [SKProduct]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        self.renderHeader()
        
        let cellForegroundClick = UITapGestureRecognizer(target: self, action: #selector(self.cellForegroundClick))
        self.cellForegroundView.isUserInteractionEnabled = true
        self.cellForegroundView.addGestureRecognizer(cellForegroundClick)
    }
    
    //    @IBAction func purchaseButtonClick(_ sender: Any) {
    //        if(self.products.isEmpty){
    //            return
    //        }
    //        let product = self.products[0]
    //        Product.store.buyProduct(product, player: self.player!)
    //    }
    
    @objc func cellForegroundClick() {
        
        let player: [String: Any] = [
            "id": self.player!.id,
            "username": self.player!.username,
            "password": self.player!.password,
            "elo": self.player!.elo,
            "rank": self.player!.rank,
            "disp": self.player!.disp,
            "date": self.player!.date,
            "avatar": self.player!.avatar,
            "config0": self.player!.config0,
            "config1": self.player!.config1,
            "config2": self.player!.config2,
            "notify": self.player!.notify,
            "device": self.player!.device,
            "updated": self.player!.updated,
            "created": self.player!.created]
        
        let rowA: [String] = ["RookBlack", "KnightBlack", "BishopBlack", "QueenBlack", "KingBlack", "BishopBlack", "KnightBlack", "RookBlack"]
        let rowB: [String] = ["PawnBlack", "PawnBlack", "PawnBlack", "PawnBlack", "PawnBlack", "PawnBlack", "PawnBlack", "PawnBlack"]
        let rowC: [String] = [String](repeating: "", count: 8)
        let rowD: [String] = [String](repeating: "", count: 8)
        let rowE: [String] = [String](repeating: "", count: 8)
        let rowF: [String] = [String](repeating: "", count: 8)
        let rowG: [String] = ["PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite"]
        let rowH: [String] = ["RookWhite", "KnightWhite", "BishopWhite", "QueenWhite", "KingWhite", "BishopWhite", "KnightWhite", "RookWhite"]
        
        let id_game: String = "id"
        let state: [[String]] = [rowH, rowG, rowF, rowE, rowD, rowC, rowB, rowA]
        let moves: Int = 666
        let status: String = "RESOLVED"
        let outcome: String = "CHECKMATE"
        let white: [String: Any] = player
        let white_elo: Int = 13
        let white_disp: Int = 13
        let white_skin: String = "SKIN"
        let black: [String: Any] = player
        let black_elo: Int = 13
        let black_disp: Int = 13
        let black_skin: String = "SKIN"
        let challenger: String = "WHITE"
        let winner: String = "WHITE"
        let turn: String = "WHITE"
        let on_check: Bool = false
        let highlight: String = "6669"
        let updated_game: String = "17.01.2020_15:45:53.2060"
        let created_game: String = "17.01.2020_15:45:53.2060"
        
        let dict: [String: Any] = [
            "id": id_game,
            "state": state,
            "moves": moves,
            "status": status,
            "outcome": outcome,
            "white": white,
            "white_elo": white_elo,
            "white_disp": white_disp,
            "white_skin": white_skin,
            "black": black,
            "black_elo": black_elo,
            "black_disp": black_disp,
            "black_skin": black_skin,
            "challenger": challenger,
            "winner": winner,
            "turn": turn,
            "on_check": on_check,
            "highlight": highlight,
            "updated": updated_game,
            "created": created_game]
        
        let game: EntityGame = ParseGame().execute(json: dict)
        
        DispatchQueue.main.async {
            switch self.skin!.getName() {
            case "hyperion":
                let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            case "calypso":
                let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            case "neptune":
                let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            case "iapetus":
                let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            default:
                return
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Skins", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Skins") as! Skins
            viewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Skins", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Skins") as! Skins
                viewController.setPlayer(player: self.player!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        default:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.setPlayer(player: self.player!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
    }
}
