//
//  Fairies.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Fairies: UIViewController, UITabBarDelegate {
    
    var fairyElementList: [Fairy] = [Amazon(), Grasshopper(), Hunter(), Poison()]
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicatorLabel: UIActivityIndicatorView!
    
    var playerSelf: EntityPlayer?
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
        self.displacementImage.image = self.playerSelf!.getImageDisp()!
        self.displacementImage.tintColor = self.playerSelf!.tintColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.renderHeader()
        self.activityIndicatorLabel.isHidden = true
    }
    
    var squadUpAdapter: FairiesTable?
    
    func getSquadUpAdapter() -> FairiesTable? {
        return squadUpAdapter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarMenu.delegate = self
        self.squadUpAdapter = children.first as? FairiesTable
        self.squadUpAdapter!.setPlayer(player: self.playerSelf!)
        self.squadUpAdapter!.setFairyElementList(fairyElementList: self.fairyElementList)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "FairiesTableSelection"),
            object: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        //DispatchQueue.main.async {
            //let height: CGFloat = UIScreen.main.bounds.height
            //SelectConfig().execute(player: self.playerSelf!, height: height)
        //}
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let squadUpDetailSelectionIndex = notification.userInfo!["fairies_table_selection"] as! Int
        let fairy: Fairy = squadUpAdapter!.getFairyElementList()![squadUpDetailSelectionIndex]
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectInfo().execute(player: self.playerSelf!, fairy: fairy, height: height)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            //DispatchQueue.main.async {
                //let height: CGFloat = UIScreen.main.bounds.height
                //SelectHome().execute(player: self.player!, height: height)
            //}
            //self.presentingViewController!.dismiss(animated: false, completion: nil)
            
            //let presentingViewController = self.presentingViewController
            //self.dismiss(animated: false, completion: {
                //presentingViewController?.dismiss(animated: false, completion: {})
            //})
            
            //
            //let vc00: UIViewController? = self.presentingViewController
            //vc00!.modalTransitionStyle = .crossDissolve
            //let vc01: UIViewController? = vc00!.presentingViewController
            //vc01!.modalTransitionStyle = .crossDissolve
            //vc01!.dismiss(animated: false, completion: nil)
            //self.presentingViewController!.dismiss(animated: false, completion: nil)
            
            //var viewControllers = navigationController?.viewControllers
            //viewControllers?.removeLast(2) //here 2 views to pop index numbers of views
            //navigationController?.setViewControllers(viewControllers!, animated: false)
            
            //self.presentingViewController!.navigationController!.popToRootViewController(animated: false)
            //popToViewController( self.navigationController!.viewControllers[0], animated: false)
             //_ = navigationController?.popToRootViewController(animated: true)
            
            //self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
            
            //self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
            
//           if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//               appDelegate.window?.rootViewController?.dismiss(animated: false, completion: nil)
//               (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: false)
//            }
        //view.window?.rootViewController?.dismiss(animated: false, completion: nil)
            
            dismissAll(animated: false)
            
        default:
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
}

extension UIViewController {

    func dismissAll(animated: Bool, completion: (() -> Void)? = nil) {
        if let optionalWindow = UIApplication.shared.delegate?.window, let window = optionalWindow, let rootViewController = window.rootViewController, let presentedViewController = rootViewController.presentedViewController  {
            if let snapshotView = window.snapshotView(afterScreenUpdates: false) {
                presentedViewController.view.addSubview(snapshotView)
                presentedViewController.modalTransitionStyle = .coverVertical
            }
            if !isBeingDismissed {
                rootViewController.dismiss(animated: animated, completion: completion)
            }
        }
    }

}
