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
        
        self.activityIndicator.isHidden = true
        
        if(self.skin!.name != "iapetus"){ //IAPETUS
            self.countdownTimerLabel.text = "00:00:00"
            self.countdownTimerLabel.isHidden = false
            self.priceLabel.text = "soldout"
            return
        }
        Product.store.requestProducts{ [weak self] success, products in
            guard let self = self else {
                return
            }
            if success {
                self.products = products!
                let product: SKProduct = self.products[0]
                DispatchQueue.main.async {
                    self.priceLabel.text = "$\(product.price.floatValue)"
                }
            }
        }
        self.startTimers()
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
        
        self.descriptionTextView.isEditable = false
        self.descriptionTextView.backgroundColor = UIColor.white
        self.descriptionTextView.textColor = UIColor.black
        self.descriptionTextView.text = self.skin!.description
        
        self.titleLabel.text = self.skin!.getName().lowercased()
        
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
            "skin": self.player!.skin,
            "note": self.player!.notify,
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
            case "HYPERION":
                SelectorSnapshot().snapshot(skin: "HYPERION", playerSelf: self.player!, game: game, presentor: self)
                return
            case "CALYPSO":
                SelectorSnapshot().snapshot(skin: "CALYPSO", playerSelf: self.player!, game: game, presentor: self)
                return
            case "NEPTUNE":
                SelectorSnapshot().snapshot(skin: "NEPTUNE", playerSelf: self.player!, game: game, presentor: self)
                return
            case "IAPETUS":
                SelectorSnapshot().snapshot(skin: "IAPETUS", playerSelf: self.player!, game: game, presentor: self)
                return
            default:
                return
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "SkinsL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "SkinsL") as! Skins
            viewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            //            if(self.skin!.name != "iapetus"){
            //                return
            //            }
            //            if(self.products.isEmpty){
            //                return
            //            }
            //            let product = self.products[0]
            //            Product.store.buyProduct(product, player: self.player!)
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Out", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Out") as! CompOut
                self.present(viewController, animated: true, completion: nil)
                self.tabBarMenu.selectedItem = nil
            }
        }
    }
}
