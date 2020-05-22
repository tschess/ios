//
//  Actual.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Menu: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate {
    //@IBOutlet var containerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Properties
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var rankDirectionImage: UIImageView!
    
    var menuTable: MenuTable?
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarMenu.delegate = self
        self.menuTable = children.first as? MenuTable
        self.menuTable!.setSelf(menu: self)
        self.menuTable!.fetchMenuTableList()
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
        self.rankDirectionImage.image = self.playerSelf!.getImageDisp()!
        self.rankDirectionImage.tintColor = self.playerSelf!.tintColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.activityIndicator.isHidden = true
        self.renderHeader()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            self.backButtonClick("")
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        //DispatchQueue.main.async {
            //let height: CGFloat = UIScreen.main.bounds.height
            //SelectHome().execute(player: self.playerSelf!, height: height)
        //}
        //self.modalTransitionStyle = .crossDissolve
        //self.dismiss(animated: true, completion: nil)
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        _ = self.navigationController?.popToRootViewController(animated: false)
        self.navigationController?.popViewController(animated: false)
    }
    
    let enter: Enter = Enter.instanceFromNib()

    
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
            self.menuTable!.tableView.reloadData()
        }
    }
}
