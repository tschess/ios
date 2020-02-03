//
//  Home.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Home: UIViewController, UITabBarDelegate {
    
//    @objc func onDidReceiveData(_ notification: NSNotification) {
//        let discoverSelectionIndex = notification.userInfo!["leaderboard_index"] as! Int
//        let gameModel = self.leaderboardTableView!.getLeaderboardTableList()[discoverSelectionIndex]
//        StoryboardSelector().other(player: self.player!, gameModel: gameModel)
//    }
    
    var homeMenuTable: HomeMenuTable?
    
    //MARK: Header
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var dispImageView: UIImageView!
    @IBOutlet weak var dispLabel: UILabel!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var activateProfileGestureRecognizer: UITapGestureRecognizer?
    
    var player: Player?
    
    func setPlayer(player: Player){
        self.player = player
    }
    
    public func renderHeader() {
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.usernameLabel.text = self.player!.getUsername()
        self.eloLabel.text = self.player!.getElo()
        self.rankLabel.text = self.player!.getRank()
        self.dispLabel.text = String(abs(Int(self.player!.getDisp())!))
        
        let disp: Int = Int(self.player!.getDisp())!
        
        if(disp >= 0){
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.up")!
                self.dispImageView.image = image
                self.dispImageView.tintColor = .green
            }
        }
        else {
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.down")!
                self.dispImageView.image = image
                self.dispImageView.tintColor = .red
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarMenu.delegate = self
        self.homeMenuTable = children.first as? HomeMenuTable
        
        self.homeMenuTable!.setPlayer(player: self.player!)
        self.homeMenuTable!.setHeaderView(
            eloLabel: self.eloLabel,
            rankLabel: self.rankLabel,
            dispLabel: self.dispLabel,
            dispImageView: self.dispImageView,
            activityIndicator: self.activityIndicator)
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.onDidReceiveData(_:)),
//            name: NSNotification.Name(rawValue: "HomeMenuTable"),
//            object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
        self.notificationTimerStop()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activateProfileGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.activateProfile))
        self.headerView.addGestureRecognizer(self.activateProfileGestureRecognizer!)
        
        self.renderHeader()
        
        self.notificationTimerStart() //gotta stop it too...
    }
    
    @objc func activateProfile() {
        StoryboardSelector().profile(player: self.player!)
    }
    
    // MARK: NOTIFICATION TIMER
    
    var notificationTimer: Timer?
    
    func notificationTimerStart() {
        guard self.notificationTimer == nil else {
            return
        }
        self.notificationTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.notificationTimerTask), userInfo: nil, repeats: true)
    }
    
    func notificationTimerStop() {
        self.notificationTimer?.invalidate()
        self.notificationTimer = nil
    }
    
    @objc func notificationTimerTask() {
        GetNotify().execute(id: self.player!.getId()) { (notify) in
            if(!notify){
                return
            }
            DispatchQueue.main.async() {
                self.tabBarMenu.selectedImageTintColor = UIColor.magenta
                if #available(iOS 13.0, *) {
                    let notify = self.tabBarMenu.items![1]
                    notify.selectedImage = UIImage(systemName: "gamecontroller")!
                    self.tabBarMenu.selectedItem = notify
                }
            }
        }
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.tabBarMenu.selectedImageTintColor = UIColor.white
        if #available(iOS 13.0, *) {
            let notify = self.tabBarMenu.items![1]
            notify.selectedImage = UIImage(systemName: "gamecontroller.fill")!
        }
        switch item.tag {
        case 0:
            print("skin")
            self.notificationTimerStop()
            StoryboardSelector().purchase(player: self.player!, remaining: 13)
        case 1:
            print("quick")
            self.notificationTimerStop()
            DispatchQueue.main.async() {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
            RequestQuick().success(id: self.player!.getId()) { (result) in
                
                DispatchQueue.main.async() {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    
                    let opponent = result as! PlayerCore
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Quick", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Quick") as! Quick
                    viewController.setPlayer(player: self.player!)
                    viewController.setOpponent(opponent: opponent)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
        case 3:
            print("game")
            self.notificationTimerStop()
            StoryboardSelector().actual(player: self.player!)
        case 4:
            self.notificationTimerStop()
            print("overview") //OVERVIEW
            let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
            viewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        default:
            print("error")
        }
    }
}


