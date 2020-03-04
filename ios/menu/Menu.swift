//
//  Actual.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Menu: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: Properties
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var rankDirectionImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    
    var playerSelf: EntityPlayer?
    func setSelf(player: EntityPlayer){
        self.playerSelf = player
    }
    
    var menuTable: MenuTable?
    var menuTableList: [EntityGame]?
    func setMenuTableList(list: [EntityGame]){
        self.menuTableList = list
    }
    
    let enter: Enter = Enter.instanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarMenu.delegate = self
        self.menuTable = children.first as? MenuTable
        self.menuTable!.setSelf(menu: self)
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
        self.activityIndicator.isHidden = true
        self.renderHeader()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            self.backButtonClick("~")
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectHome().execute(player: self.playerSelf!, height: height)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.menuTableList!.count > 0){
            return
        }
        DispatchQueue.main.async {
            self.enter.enterWidthConstraint.constant = self.view.frame.width
            self.containerView!.addSubview(self.enter)
            self.enter.translatesAutoresizingMaskIntoConstraints = false
            let top = NSLayoutConstraint(item: self.enter, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.containerView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint(item: self.enter, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.containerView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint(item: self.enter, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.containerView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            let leading = NSLayoutConstraint(item: self.enter, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.containerView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            self.view.addConstraints([top, bottom, trailing, leading])
            
            let quick = UITapGestureRecognizer(target: self, action: #selector(self.quick))
            self.enter.addGestureRecognizer(quick)
            self.enter.isUserInteractionEnabled = true
        }
    }
    
    @objc func quick(gesture: UIGestureRecognizer) {
        self.setIndicator(on: true)
        RequestQuick().success(id: self.playerSelf!.id) { (opponent) in
            self.setIndicator(on: false)
            DispatchQueue.main.async() {
                let height: CGFloat = UIScreen.main.bounds.height
                SelectPlay().execute(selection: Int.random(in: 0...3), playerSelf: self.playerSelf!, playerOther: opponent!, height: height)
            }
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
            self.menuTable!.tableView.reloadData()
        }
    }
}
