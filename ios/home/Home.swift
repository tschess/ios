//
//  Home.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Home: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, UITabBarDelegate {
    
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //@IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var leaderboardTableView: HomeMenuTable?
    
    var tap: UITapGestureRecognizer?
    
    //@IBOutlet weak var discoverySearchBar: UISearchBar!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tschxLabel: UILabel!
    
    var searchTargetUser: String?
    var player: Player?
    
    func setPlayer(player: Player){
        self.player = player
    }
    
//    @IBAction func backButtonClick(_ sender: Any) {
//        StoryboardSelector().home(player: self.player!)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = self.player!.getRank()
        //self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getName()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "DiscoverSelection"),
            object: nil)
        
        //self.activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //discoverySearchBar.delegate = self
        //discoverySearchBar.resignFirstResponder()
        
        tabBarMenu.delegate = self
        
        leaderboardTableView = children.first as? HomeMenuTable
        leaderboardTableView!.setPlayer(player: self.player!)
        //leaderboardTableView!.setIndicator(indicator: self.activityIndicator!)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(tap!)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        searchBar.spellCheckingType = .no
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //discoverySearchTarget(discoverySearchTarget: discoverySearchBar.text!)
        //discoverySearchBar.text = nil
        //discoverySearchBar.resignFirstResponder()
        view.removeGestureRecognizer(tap!)
    }
    
    func updateSearchResults(for searchController: UISearchController) {}
    
    func okHandler(action: UIAlertAction) {
        StoryboardSelector().leader(player: self.player!)
    }
    
    func discoverySearchTarget(discoverySearchTarget: String) {
        DiscoveryTargetTask().execute(name: discoverySearchTarget) { (result) in
            if result == nil {
                DispatchQueue.main.async() {
                    let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                    let myString = "server error"
                    var myMutableString = NSMutableAttributedString()
                    myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                    alertController.setValue(myMutableString, forKey: "attributedTitle")
                    let message = "\nplease try again later"
                    var messageMutableString = NSMutableAttributedString()
                    messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                    messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                    alertController.setValue(messageMutableString, forKey: "attributedMessage")
                    let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                    action.setValue(Colour().getRed(), forKey: "titleTextColor")
                    alertController.addAction(action)
                    alertController.view.backgroundColor = UIColor.black
                    alertController.view.layer.cornerRadius = 40
                    self.present(alertController, animated: true, completion: nil)
                }
                return
            }
            let error = result as? String
            if error != nil {
                DispatchQueue.main.async() {
                    let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                    let myString = "search error"
                    var myMutableString = NSMutableAttributedString()
                    myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                    alertController.setValue(myMutableString, forKey: "attributedTitle")
                    let message = "\nno such player"
                    var messageMutableString = NSMutableAttributedString()
                    messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                    messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                    alertController.setValue(messageMutableString, forKey: "attributedMessage")
                    let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                    action.setValue(Colour().getRed(), forKey: "titleTextColor")
                    alertController.addAction(action)
                    alertController.view.backgroundColor = UIColor.black
                    alertController.view.layer.cornerRadius = 40
                    self.present(alertController, animated: true, completion: nil)
                }
                return
            }
            let gameModel = result as! Game
            StoryboardSelector().challenge(player: self.player!, gameModel: gameModel)
        }
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let discoverSelectionIndex = notification.userInfo!["discover_selection"] as! Int
        let gameModel = leaderboardTableView!.getLeaderboardTableList()[discoverSelectionIndex]
        StoryboardSelector().challenge(player: self.player!, gameModel: gameModel)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
}


