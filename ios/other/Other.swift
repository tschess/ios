//
//  Other.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Other: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    
    var otherMenuTable: OtherMenuTable?
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerOther!.getImageAvatar()
        self.usernameLabel.text = self.playerOther!.username
        self.eloLabel.text = self.playerOther!.getLabelTextElo()
        self.rankLabel.text = self.playerOther!.getLabelTextRank()
        self.dateLabel.text = self.playerOther!.getLabelTextDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otherMenuTable = children.first as? OtherMenuTable
        self.otherMenuTable!.setActivityIndicator(activityIndicator: self.activityIndicator!)
        self.otherMenuTable!.setPlayer(player: self.playerOther!)
        self.otherMenuTable!.fetchMenuTableList()
        
        
        
        self.tabBarMenu.delegate = self
        
        self.activityIndicator.isHidden = true
        
        self.renderHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "OtherMenuTable"),
            object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let gameMenuSelectionIndex = notification.userInfo!["other_menu_selection"] as! Int
        let game = self.otherMenuTable!.getGameMenuTableList()[gameMenuSelectionIndex]
        
        
        SelectSnapshot().snapshot(playerSelf: self.playerSelf!, game: game, presentor: self)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        _ = self.navigationController?.popToRootViewController(animated: false)
        self.navigationController?.popViewController(animated: false)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.tabBarMenu.selectedItem = nil
        switch item.tag {
        case 0:
            self.backButtonClick("")
        default:
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeL") as! Challenge
                    viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                    viewController.setPlayerOther(playerOther: self.playerOther!)
                    viewController.setSelection(selection: Int.random(in: 0...3))
                    viewController.BACK = "OTHER"
                    self.navigationController?.pushViewController(viewController, animated: false)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeP") as! Challenge
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.playerOther!)
                viewController.setSelection(selection: Int.random(in: 0...3))
                viewController.BACK = "OTHER"
                self.navigationController?.pushViewController(viewController, animated: false)
            }
            
        }
    }
}
