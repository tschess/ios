//
//  Home.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class HomeActivity: UIViewController, UITabBarDelegate {
    
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
        
        case 1:
            let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)
            let fuck = UIAlertAction(title: "Yes 🐕", style: .default, handler: nil)
            fuck.setValue(UIColor.magenta, forKey: "titleTextColor")
            alert.addAction(fuck)
            let shit = UIAlertAction(title: "No 🍕", style: .default, handler: nil)
            shit.setValue(UIColor.green, forKey: "titleTextColor")
            alert.addAction(shit)
            
            alert.view.tintColor = .green
            self.present(alert, animated: true)
        
        case 3:
            var storyboard: UIStoryboard = UIStoryboard(name: "ConfigP", bundle: nil)
            var viewController = storyboard.instantiateViewController(withIdentifier: "ConfigP") as! Config
            if(UIScreen.main.bounds.height.isLess(than: 750)){
                storyboard = UIStoryboard(name: "ConfigL", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
            }
            viewController.playerSelf = self.player!
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(viewController, animated: false)
            
        default:
            print("LEADERBOARD !!!!!!!")
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



