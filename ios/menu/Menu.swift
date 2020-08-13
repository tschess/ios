//
//  Actual.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Menu: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate {
    
    //MARK: Properties - Strong
    @IBOutlet var indicatorActivity: UIActivityIndicatorView!
    
    //MARK: Properties - Header
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var labelDisp: UILabel!
    @IBOutlet weak var imageViewDisp: UIImageView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
    //MARK: Properties - UI
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    //MARK: Variables - Member
    var playerSelf: EntityPlayer?
    
    //MARK: Variables - Component
    var menuTable: MenuTable?
    
    func renderHeader() {
        self.imageViewAvatar.image = self.playerSelf!.getImageAvatar()
        self.labelName.text = self.playerSelf!.username
        self.labelRate.text = self.playerSelf!.getLabelTextElo()
        self.labelRank.text = self.playerSelf!.getLabelTextRank()
        self.labelDisp.text = self.playerSelf!.getLabelTextDisp()
        self.imageViewDisp.image = self.playerSelf!.getImageDisp()!
        self.imageViewDisp.tintColor = self.playerSelf!.tintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarMenu.delegate = self
        self.menuTable = children.first as? MenuTable
        self.menuTable!.menu = self
        self.menuTable!.fetchList()
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
                    }
                    return
                }
                DispatchQueue.main.async() {
                    let storyboard: UIStoryboard = UIStoryboard(name: "PlayP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "PlayP") as! Play
                    viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                    viewController.setPlayerOther(playerOther: opponent)
                    viewController.setSelection(selection: Int.random(in: 0...3))
                    self.navigationController?.pushViewController(viewController, animated: false)
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
    
    func setIndicator(on: Bool = true) {
        if(on) {
            if(self.indicatorActivity!.isHidden){
                
            }
            self.indicatorActivity!.isHidden = false
            DispatchQueue.main.async() {
                self.indicatorActivity!.startAnimating()
            }
            return
        }
        DispatchQueue.main.async() {
            self.indicatorActivity!.isHidden = true
            self.indicatorActivity!.stopAnimating()
            self.menuTable!.tableView.reloadData()
        }
    }
}
