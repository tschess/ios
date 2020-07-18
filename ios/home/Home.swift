//
//  Home.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Home: UIViewController, UITabBarDelegate {
    
    var menu: Menu?
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
    
    var playerSelf: EntityPlayer?
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.dispLabel.text = self.playerSelf!.getLabelTextDisp()
        self.dispImageView.image = self.playerSelf!.getImageDisp()!
        self.dispImageView.tintColor = self.playerSelf!.tintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.viewControllers = [self]
       
        self.tabBarMenu.delegate = self
        self.homeMenuTable = children.first as? HomeMenuTable
        self.homeMenuTable!.home = self
        self.homeMenuTable!.fetchGameList()
        
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
        self.renderHeader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.notificationTimerStart()
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
        GetNotify().execute(id: self.playerSelf!.id) { (notify) in
            if(!notify){
                return
            }
            DispatchQueue.main.async() {
                let notify = self.tabBarMenu.items![1]
                notify.image = UIImage(named: "note")!.withRenderingMode(.alwaysOriginal)
                if(self.menu != nil){
                    self.menu!.menuTable!.refresh(refreshControl: nil)
                }
            }
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.tabBarMenu.selectedItem = nil
        DispatchQueue.main.async() {
            let notify = self.tabBarMenu.items![1]
            notify.image = UIImage(named: "game.grey")!
        }
        switch item.tag {
        case 1:
            //self.setIndicator(on: true)
            let height: CGFloat = UIScreen.main.bounds.height
            if(height.isLess(than: 750)){
                DispatchQueue.main.async() {
                    let storyboard: UIStoryboard = UIStoryboard(name: "ProfileL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileL") as! Profile
                    viewController.setPlayer(player: self.playerSelf!)
                    let transition = CATransition()
                    transition.duration = 0.3
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                    transition.type = CATransitionType.fade
                    self.navigationController?.view.layer.add(transition, forKey: nil)
                    _ = self.navigationController?.popViewController(animated: false)
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
                return
            }
            DispatchQueue.main.async() {
                let storyboard: UIStoryboard = UIStoryboard(name: "ProfileP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileP") as! Profile
                viewController.setPlayer(player: self.playerSelf!)
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.fade
                self.navigationController?.view.layer.add(transition, forKey: nil)
                _ = self.navigationController?.popViewController(animated: false)
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        case 3:
            if(self.menu != nil){
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.fade
                self.navigationController?.view.layer.add(transition, forKey: nil)
                _ = self.navigationController?.popViewController(animated: false)
                self.navigationController?.pushViewController(menu!, animated: false)
                return
            }
            let height: CGFloat = UIScreen.main.bounds.height
            if(height.isLess(than: 750)){
                let storyboard: UIStoryboard = UIStoryboard(name: "MenuL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "MenuL") as! Menu
                viewController.playerSelf = self.playerSelf!
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "MenuP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "MenuP") as! Menu
            viewController.playerSelf = self.playerSelf!
            self.navigationController?.pushViewController(viewController, animated: false)
        case 4:
            let height: CGFloat = UIScreen.main.bounds.height
            if(height.isLess(than: 750)){
                let storyboard: UIStoryboard = UIStoryboard(name: "ConfigL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.fade
                self.navigationController?.view.layer.add(transition, forKey: nil)
                _ = self.navigationController?.popViewController(animated: false)
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "ConfigP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigP") as! Config
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(viewController, animated: false)
        default:
            print("fuck")
        }
    }
    
    // TODO: IF SELF GO TO GAMES!!!!
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let menuSelectionIndex = notification.userInfo!["home_menu_selection"] as! Int
        
        let playerOther: EntityPlayer = self.homeMenuTable!.getOther(index: menuSelectionIndex)
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            if(height.isLess(than: 750)){
                let storyboard: UIStoryboard = UIStoryboard(name: "OtherL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "OtherL") as! Other
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: playerOther)
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "OtherP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "OtherP") as! Other
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            viewController.setPlayerOther(playerOther: playerOther)
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    func setIndicator(on: Bool) {
        if(on) {
            DispatchQueue.main.async() {
                if(self.activityIndicator!.isHidden){
                    self.activityIndicator!.isHidden = false
                }
                if(!self.activityIndicator!.isAnimating){
                    self.activityIndicator!.startAnimating()
                }
            }
            return
        }
        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = true
            self.activityIndicator!.stopAnimating()
            self.homeMenuTable!.tableView.reloadData()
        }
    }
}


