//
//  Leaderboard.swift
//  ios
//
//  Created by S. Matthew English on 12/3/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Leaderboard: UIViewController, UITabBarDelegate {
    
    var menu: Home?
    var homeMenuTable: LeaderboardTable?
    
    //MARK: Header
    @IBOutlet weak var headerView: UIView!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //@IBOutlet weak var avatarImageView: UIImageView!
    //@IBOutlet weak var usernameLabel: UILabel!
    //@IBOutlet weak var eloLabel: UILabel!
    //@IBOutlet weak var rankLabel: UILabel!
    //@IBOutlet weak var dispImageView: UIImageView!
    //@IBOutlet weak var dispLabel: UILabel!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var playerSelf: EntityPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Header
        let viewHeaderDynamic = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.headerView.addSubview(viewHeaderDynamic)
        viewHeaderDynamic.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: viewHeaderDynamic, attribute: $0, relatedBy: .equal, toItem: viewHeaderDynamic.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        viewHeaderDynamic.set(player: self.playerSelf!)
       
        self.tabBarMenu.delegate = self
        self.homeMenuTable = children.first as? LeaderboardTable
        self.homeMenuTable!.home = self
        self.homeMenuTable!.fetchGameList()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "HomeMenuSelection"),
            object: nil)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        _ = self.navigationController?.popViewController(animated: false)
        self.navigationController?.popViewController(animated: false)
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
