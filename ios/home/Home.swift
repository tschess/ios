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
        //self.navigationController!.viewControllers.first = self
        //self.navigationController!.popToRootViewController(animated: false)
        
        //guard let navigationController = self.navigationController else { return }
        //var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        //navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
        //self.navigationController?.viewControllers = navigationArray
        if let viewControllers = self.navigationController?.viewControllers {
            for vc in viewControllers {
                //if vc.isKind(of: YourViewController.classForCoder()) {
                print("---")
                print("It is in stack \(String(describing: type(of: vc)))")
                print("---")
                //Your Process
                //}
            }
        }
        
        
        
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
        
        self.activateProfileGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.activateProfile))
        self.headerView.addGestureRecognizer(self.activateProfileGestureRecognizer!)
        
        self.renderHeader()
        
        self.notificationTimerStart()
    }
    
    @objc func activateProfile() {
        let height: CGFloat = UIScreen.main.bounds.height
        if(height.isLess(than: 750)){
            DispatchQueue.main.async() {
                
                let storyboard: UIStoryboard = UIStoryboard(name: "ProfileL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileL") as! Profile
                viewController.setPlayer(player: self.playerSelf!)
                self.navigationController?.pushViewController(viewController, animated: false)
            }
            return
        }
        DispatchQueue.main.async() {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "ProfileP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileP") as! Profile
            viewController.setPlayer(player: self.playerSelf!)
            self.navigationController?.pushViewController(viewController, animated: false)
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
        GetNotify().execute(id: self.playerSelf!.id) { (notify) in
            if(!notify){
                return
            }
            self.notificationTimerStop()
            DispatchQueue.main.async() {
                let notify = self.tabBarMenu.items![1]
                notify.image = UIImage(named: "note")!.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.tabBarMenu.selectedItem = nil
        
        switch item.tag {
        case 1:
            self.setIndicator(on: true)
            DispatchQueue.main.async() {
                let notify = self.tabBarMenu.items![1]
                notify.selectedImage = UIImage(named: "game.grey")!
            }
            RequestQuick().success(id: self.playerSelf!.id) { (json) in
                self.setIndicator(on: false)
                let opponent: EntityPlayer = ParsePlayer().execute(json: json)
                let height: CGFloat = UIScreen.main.bounds.height
                if(height.isLess(than: 750)){
                    DispatchQueue.main.async() {
                        let storyboard: UIStoryboard = UIStoryboard(name: "PlayL", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayL") as! Play
                        viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                        viewController.setPlayerOther(playerOther: opponent)
                        viewController.setSelection(selection: Int.random(in: 0...3))
                        //viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        //self.navigationController?.pushViewController(viewController, animated: false)
                        self.navigationController?.pushViewController(viewController, animated: false)
                    }
                    return
                }
                DispatchQueue.main.async() {
                    let storyboard: UIStoryboard = UIStoryboard(name: "PlayP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "PlayP") as! Play
                    viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                    viewController.setPlayerOther(playerOther: opponent)
                    viewController.setSelection(selection: Int.random(in: 0...3))
                    //self.navigationController?.pushViewController(viewController, animated: false)
                    self.navigationController?.pushViewController(viewController, animated: false)
                }}
        case 3:
            self.tabBarMenu.selectedItem = nil
            let height: CGFloat = UIScreen.main.bounds.height
            if(height.isLess(than: 750)){
                let storyboard: UIStoryboard = UIStoryboard(name: "MenuL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "MenuL") as! Menu
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                //viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                //self.present(viewController, animated: false , completion: nil)
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "MenuP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "MenuP") as! Menu
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            //viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            //self.present(viewController, animated: false , completion: nil)
            self.navigationController?.pushViewController(viewController, animated: false)
        case 4:
            self.tabBarMenu.selectedItem = nil
            
            let height: CGFloat = UIScreen.main.bounds.height
            if(height.isLess(than: 750)){
                let storyboard: UIStoryboard = UIStoryboard(name: "ConfigL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                //viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                //self.present(viewController, animated: false , completion: nil)
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "ConfigP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigP") as! Config
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            //viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            //self.present(viewController, animated: false , completion: nil)
            self.navigationController?.pushViewController(viewController, animated: false)
            
        default:
            self.notificationTimerStop()
        }
    }
    
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
                viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                self.present(viewController, animated: false , completion: nil)
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "OtherP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "OtherP") as! Other
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            viewController.setPlayerOther(playerOther: playerOther)
            viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(viewController, animated: false , completion: nil)
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


