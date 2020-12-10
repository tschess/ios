//
//  Other.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Other: UIViewController, UITabBarDelegate {
    
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewHeader: UIView!
    var header: Header?
    
    //MARK: Properties
    @IBOutlet weak var tabBar: UITabBar!
    
    var otherMenuTable: OtherTable?
    
    var opponent: EntityPlayer?
    
    var player: EntityPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otherMenuTable = children.first as? OtherTable
        self.otherMenuTable!.player = self.opponent!
        self.otherMenuTable!.fetchMenuTableList()
        self.otherMenuTable!.other = self
        
        self.tabBar.delegate = self
        
        
        //TODO: Header
        self.header = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.viewHeader.addSubview(self.header!)
        self.header!.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: self.header!, attribute: $0, relatedBy: .equal, toItem: self.header!.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        self.header!.set(player: self.opponent!)
        self.header!.setIndicator(on: true)
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
        
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
            viewController.game = game
            viewController.player = self.opponent!
            self.present(viewController, animated: false, completion: nil)
        }
    }
    

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        self.tabBar.selectedItem = nil
        switch item.tag {
        
        case 1:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "PopInvite", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvite") as! PopInvite
                viewController.player = self.player
                viewController.opponent = self.opponent
                self.present(viewController, animated: true)
            }
        default:
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.popViewController(animated: false)
        }
    }
}
