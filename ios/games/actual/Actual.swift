//
//  Actual.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Actual: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate {
    
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
    
    var actualTable: ActualTable?
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarMenu.delegate = self
        actualTable = children.first as? ActualTable
        actualTable!.setPlayerSelf(playerSelf: self.playerSelf!)
        actualTable!.setIndicator(indicator: self.activityIndicator!)
        actualTable!.fetchMenuTableList()
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
        self.rankDirectionImage.image = self.playerSelf!.getImageDisp()!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.isHidden = true
        self.renderHeader()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.setPlayer(player: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        default:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Historic", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Historic") as! Historic
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
            viewController.setPlayer(player: self.playerSelf!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
