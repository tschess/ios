//
//  Home.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Home: UIViewController, UITabBarDelegate {
    
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
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.player!.getImageAvatar()
        self.usernameLabel.text = self.player!.username
        self.eloLabel.text = self.player!.getLabelTextElo()
        self.rankLabel.text = self.player!.getLabelTextRank()
        self.dispLabel.text = self.player!.getLabelTextDisp()
        self.dispImageView.image = self.player!.getImageDisp()!
        self.dispImageView.tintColor = self.player!.tintColor
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "HomeMenuSelection"),
            object: nil)
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
        DispatchQueue.main.async() {
            let height: CGFloat = self.view.frame.size.height
            SelectProfile().execute(player: self.player!, height: height)
        }
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
        GetNotify().execute(id: self.player!.id) { (notify) in
            if(!notify){
                return
            }
            DispatchQueue.main.async() {
                self.tabBarMenu.selectedImageTintColor = UIColor.magenta
                let notify = self.tabBarMenu.items![1]
                notify.selectedImage = UIImage(named: "game.magenta")!
                self.tabBarMenu.selectedItem = notify
            }
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.tabBarMenu.selectedImageTintColor = UIColor.white
        switch item.tag {
        case 1:
            self.notificationTimerStop()
            DispatchQueue.main.async() {
                let notify = self.tabBarMenu.items![1]
                notify.selectedImage = UIImage(named: "game.white")!
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
            RequestQuick().success(id: self.player!.id) { (opponent) in
                DispatchQueue.main.async() {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    let height: CGFloat = self.view.frame.size.height
                    SelectPlay().execute(selection: Int.random(in: 0...3), playerSelf: self.player!, playerOther: opponent!, height: height)
                }
            }
        case 3:
            self.notificationTimerStop()
            DispatchQueue.main.async {
                let height: CGFloat = self.view.frame.size.height
                SelectActual().execute(player: self.player!, height: height)
            }
        case 4:
            self.notificationTimerStop()
            DispatchQueue.main.async {
                let height: CGFloat = self.view.frame.size.height
                SelectConfig().execute(player: self.player!, height: height)
            }
        default:
            self.notificationTimerStop()
        }
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let menuSelectionIndex = notification.userInfo!["home_menu_selection"] as! Int
        
        let playerOther: EntityPlayer = self.homeMenuTable!.getOther(index: menuSelectionIndex)
        DispatchQueue.main.async {
            let height: CGFloat = self.view.superview!.frame.size.height
            SelectOther().execute(playerSelf: self.player!, playerOther: playerOther, height: height)
        }
    }
}


