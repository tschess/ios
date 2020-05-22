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
        self.renderHeader()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.tabBarMenu.selectedItem = nil
        if let viewControllers = self.navigationController?.viewControllers {
            for vc in viewControllers {
                let ty = String(describing: type(of: vc))
                if(ty == "Home"){
                    let home: Home = vc as! Home
                    home.menu = self
                }
            }
        }
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
                        self.navigationController?.pushViewController(viewController, animated: false)
                        guard let navigationController = self.navigationController else { return }
                        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
                        navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
                        self.navigationController?.viewControllers = navigationArray
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
                    guard let navigationController = self.navigationController else { return }
                    var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
                    navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
                    self.navigationController?.viewControllers = navigationArray
                }}
        default:
            self.backButtonClick("")
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        _ = self.navigationController?.popViewController(animated: false)
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
