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
    
    @IBOutlet weak var componentOpponent: UIView!
    
    @IBOutlet weak var viewHeader: UIView!
    var header: Header?
    
    override func viewWillAppear(_ animated: Bool) {
        
        //self.table!.fetch()
        
        self.table = children.first as? HomeTable
        self.table!.activity = self
        
        self.table!.index = 0
        self.table!.list = [EntityGame]()
        self.table!.fetch()
        
        self.header!.setIndicator(on: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.viewControllers = [self]
        
        //TODO: Header
        self.header = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.viewHeader.addSubview(self.header!)
        self.header!.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: self.header!, attribute: $0, relatedBy: .equal, toItem: self.header!.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        self.header!.set(player: self.player!)
        
        //TODO: Opponent
        let opponent = Bundle.loadView(fromNib: "Opponent", withType: Opponent.self)
        self.componentOpponent.addSubview(opponent)
        opponent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: opponent, attribute: $0, relatedBy: .equal, toItem: opponent.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        opponent.home = self
        opponent.set(player: self.player!)
        
        //TODO: Table
//        self.table = children.first as? HomeTable
//        self.table!.activity = self
//        self.table!.fetch()
        
        self.tabBar.delegate = self
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        self.tabBar.selectedItem = nil
        switch item.tag {
        
        case 0:
            let alert = UIAlertController(title: "⏱️ Hang tight! 🤖", message: "\nSingle-player mode coming soon.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        case 1:
            let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
            viewController.playerSelf = self.player!
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(viewController, animated: false)
        case 2:
            let storyboard: UIStoryboard = UIStoryboard(name: "Leaderboard", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Leaderboard") as! Leaderboard
            viewController.playerSelf = self.player!
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(viewController, animated: false)
        default:
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
    
}



