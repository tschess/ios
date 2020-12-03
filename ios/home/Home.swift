//
//  Home.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Home: UIViewController, UITabBarDelegate {
    
    var player: EntityPlayer?
    var table: HomeTable?
    
    //MARK: OUTLET
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var componentHeader: Header!
    @IBOutlet weak var componentOpponent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.viewControllers = [self]
        
        //TODO: Header
        let viewHeaderDynamic = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.componentHeader.addSubview(viewHeaderDynamic)
        viewHeaderDynamic.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: viewHeaderDynamic, attribute: $0, relatedBy: .equal, toItem: viewHeaderDynamic.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        viewHeaderDynamic.set(player: self.player!)
        
        //TODO: Opponent
        let opponent = Bundle.loadView(fromNib: "Opponent", withType: Opponent.self)
        self.componentOpponent.addSubview(opponent)
        opponent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: opponent, attribute: $0, relatedBy: .equal, toItem: opponent.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        opponent.set(playerSelf: self.player!)
        //opponent.table = self.table
        
        //TODO: Table
        self.table = children.first as? HomeTable
        self.table!.activity = self
        self.table!.fetch()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "HomeMenuSelection"),
            object: nil)
        
        self.tabBar.delegate = self
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        self.tabBar.selectedItem = nil
        switch item.tag {
        
        case 0:
            let alert = UIAlertController(title: "⏱️ hang tight 🤖", message: "\nSingle-player mode coming soon!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        case 1:
            let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
            //if(UIScreen.main.bounds.height.isLess(than: 750)){
                //storyboard = UIStoryboard(name: "ConfigL", bundle: nil)
                //viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
            //}
            viewController.playerSelf = self.player!
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(viewController, animated: false)
        case 2:
            print("LEADERBOARD !!!!!!!")
        default:
            print("PROFILE !!!!!!!")
            let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Profile") as! Profile
            viewController.player = self.player!
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    // TODO:
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let index: Int = notification.userInfo!["home_menu_selection"] as! Int
        let game: EntityGame = self.table!.list[index]
        
        
    }
    
    func setIndicator(on: Bool) {
        //if(on) {
        //    DispatchQueue.main.async() {
        //        if(self.headerView.indicatorActivity!.isHidden){
        //            self.headerView.indicatorActivity!.isHidden = false
        //        }
        //        if(!self.headerView.indicatorActivity!.isAnimating){
        //            self.headerView.indicatorActivity!.startAnimating()
        //        }
        //    }
        //    return
        //}
        //DispatchQueue.main.async() {
        //    self.headerView.indicatorActivity!.isHidden = true
        //    self.headerView.indicatorActivity!.stopAnimating()
        //    self.homeMenuTable!.tableView.reloadData()
        //}
    }
}



