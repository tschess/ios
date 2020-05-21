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
        //self.presentingViewController!.dismiss(animated: false, completion: nil)
        //self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let squadUpDetailSelectionIndex = notification.userInfo!["fairies_table_selection"] as! Int
        let fairy: Fairy = squadUpAdapter!.getFairyElementList()![squadUpDetailSelectionIndex]
        //DispatchQueue.main.async {
            //let height: CGFloat = UIScreen.main.bounds.height
            //SelectInfo().execute(player: self.playerSelf!, fairy: fairy, height: height)
        //}
        
        let height: CGFloat = UIScreen.main.bounds.height
        if(height.isLess(than: 750)){
            //let root = UIApplication.shared.delegate! as! AppDelegate
            let storyboard: UIStoryboard = UIStoryboard(name: "InfoL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "InfoL") as! Info
            viewController.setPlayer(player: self.playerSelf!)
            viewController.setFairyElement(fairyElement: fairy)
            viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            //root.window?.rootViewController?.present(viewController, animated: false , completion: nil)
            self.present(viewController, animated: false , completion: nil)
            return
        }
        //let root = UIApplication.shared.delegate! as! AppDelegate
        let storyboard: UIStoryboard = UIStoryboard(name: "InfoP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "InfoP") as! Info
        viewController.setPlayer(player: self.playerSelf!)
        viewController.setFairyElement(fairyElement: fairy)
        viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(viewController, animated: false , completion: nil)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            //dismissAll(animated: false)
            dismissAll(animated: true)
        default:
            //self.presentingViewController!.dismiss(animated: false, completion: nil)
            //self.modalTransitionStyle = .crossDissolve
            self.dismiss(animated: false, completion: nil)
        }
    }
}

extension UIViewController {

    func dismissAll(animated: Bool, completion: (() -> Void)? = nil) {
        if let optionalWindow = UIApplication.shared.delegate?.window, let window = optionalWindow, let rootViewController = window.rootViewController, let presentedViewController = rootViewController.presentedViewController  {
            if let snapshotView = window.snapshotView(afterScreenUpdates: false) {
                presentedViewController.view.addSubview(snapshotView)
                //presentedViewController.modalTransitionStyle = .coverVertical
                //self.modalTransitionStyle = .crossDissolve
                presentedViewController.modalTransitionStyle = .crossDissolve
            }
            if !isBeingDismissed {
                rootViewController.dismiss(animated: animated, completion: completion)
            }
        }
    }

}
