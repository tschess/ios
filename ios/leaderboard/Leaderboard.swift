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
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var header: Header?
    
    var playerSelf: EntityPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Header
        self.header = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.headerView.addSubview(self.header!)
        self.header!.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: self.header!, attribute: $0, relatedBy: .equal, toItem: self.header!.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        self.header!.set(player: self.playerSelf!)
       
        self.tabBarMenu.delegate = self
        self.homeMenuTable = children.first as? LeaderboardTable
        self.homeMenuTable!.home = self
        self.homeMenuTable!.fetchGameList()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "LeaderboardSelection"),
            object: nil)
    }
    
    // TODO: IF SELF GO TO GAMES!!!!
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let menuSelectionIndex = notification.userInfo!["leaderboard_selection"] as! Int
        
        let opponent: EntityPlayer = self.homeMenuTable!.getOther(index: menuSelectionIndex)
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "PopInvite", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvite") as! PopInvite
            viewController.player = self.playerSelf
            viewController.opponent = opponent
            self.present(viewController, animated: true)
        }
    }
    
    //TODO: ought not be here...
//    func refreshHome() {
//        DispatchQueue.main.async {
//            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
//                let viewControllers = navigationController.viewControllers
//                for vc in viewControllers {
//                    if vc.isKind(of: Home.classForCoder()) {
//                        let home: Home = vc as! Home
//
//                        home.table!.index = 0
//                        home.table!.list = [EntityGame]()
//                        home.table!.fetch(refreshControl: nil, refresh: true)
//                    }
//                }
//
//            }
//        }
//    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //self.refreshHome()
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        _ = self.navigationController?.popViewController(animated: false)
        self.navigationController?.popViewController(animated: false)
    }
}
