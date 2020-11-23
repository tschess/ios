//
//  Home.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Home: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var containerOpponent: UIView!
    
    var menu: Menu?
    var homeMenuTable: HomeMenuTable?
    
    //MARK: Header
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    
    var playerSelf: EntityPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let viewHeaderDynamic = Bundle.loadView(fromNib: "Header", withType: Header.self)
        DispatchQueue.main.async() {
            self.headerView.addSubview(viewHeaderDynamic)
            viewHeaderDynamic.translatesAutoresizingMaskIntoConstraints = false
            let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
            NSLayoutConstraint.activate(attributes.map {
                NSLayoutConstraint(item: viewHeaderDynamic, attribute: $0, relatedBy: .equal, toItem: viewHeaderDynamic.superview, attribute: $0, multiplier: 1, constant: 0)
            })
            viewHeaderDynamic.set(player: self.playerSelf!)
        }
        
        let opponent = Bundle.loadView(fromNib: "Opponent", withType: Opponent.self)
        self.containerOpponent.addSubview(opponent)
        opponent.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: opponent, attribute: $0, relatedBy: .equal, toItem: opponent.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        opponent.set()
        
        
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
        //self.renderHeader()
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
            self.notificationTimerStop()
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
            DispatchQueue.main.async() {
                var storyboard: UIStoryboard = UIStoryboard(name: "ProfileP", bundle: nil)
                var viewController = storyboard.instantiateViewController(withIdentifier: "ProfileP") as! Profile
                if(UIScreen.main.bounds.height.isLess(than: 750)){
                    storyboard = UIStoryboard(name: "ProfileL", bundle: nil)
                    viewController = storyboard.instantiateViewController(withIdentifier: "ProfileL") as! Profile
                }
                viewController.player = self.playerSelf!
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
            var storyboard: UIStoryboard = UIStoryboard(name: "MenuP", bundle: nil)
            var viewController = storyboard.instantiateViewController(withIdentifier: "MenuP") as! Menu
            if(UIScreen.main.bounds.height.isLess(than: 750)){
                storyboard = UIStoryboard(name: "MenuL", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "MenuL") as! Menu
            }
            viewController.playerSelf = self.playerSelf!
            self.navigationController?.pushViewController(viewController, animated: false)
        default: //case 4:
            var storyboard: UIStoryboard = UIStoryboard(name: "ConfigP", bundle: nil)
            var viewController = storyboard.instantiateViewController(withIdentifier: "ConfigP") as! Config
            if(UIScreen.main.bounds.height.isLess(than: 750)){
                storyboard = UIStoryboard(name: "ConfigL", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
            }
            viewController.playerSelf = self.playerSelf!
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(viewController, animated: false)
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
        //        if(on) {
        //            DispatchQueue.main.async() {
        //                if(self.activityIndicator!.isHidden){
        //                    self.activityIndicator!.isHidden = false
        //                }
        //                if(!self.activityIndicator!.isAnimating){
        //                    self.activityIndicator!.startAnimating()
        //                }
        //            }
        //            return
        //        }
        //        DispatchQueue.main.async() {
        //            self.activityIndicator!.isHidden = true
        //            self.activityIndicator!.stopAnimating()
        //            self.homeMenuTable!.tableView.reloadData()
        //        }
    }
}


