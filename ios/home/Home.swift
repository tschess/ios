//
//  Home.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Home: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, UITabBarDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchPlaceholderLabel: UILabel!
    @IBOutlet weak var searchHeaderAlignmentConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var leaderboardTableView: HomeMenuTable?
    
    var tap: UITapGestureRecognizer?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tschxLabel: UILabel!
    
    var searchTargetUser: String?
    var player: Player?
    
    func setPlayer(player: Player){
        self.player = player
    }
    
    @objc func activateProfile() {
           StoryboardSelector().profile(player: self.player!)
       }
    
    var activateProfileGestureRecognizer: UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activateProfileGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.activateProfile))
        self.headerView.addGestureRecognizer(self.activateProfileGestureRecognizer!)
        
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
        self.activityIndicator.isHidden = true
        
        self.searchTextField.delegate = self
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.addGestureRecognizer(self.dismissKeyboardGesture!)
        self.searchPlaceholderLabel.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.dismissKeyboard()
        searchPlaceholderLabel.resignFirstResponder()
        view.removeGestureRecognizer(self.dismissKeyboardGesture!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //discoverySearchBar.delegate = self
        //discoverySearchBar.resignFirstResponder()
        
        tabBarMenu.delegate = self
        
        leaderboardTableView = children.first as? HomeMenuTable
        leaderboardTableView!.setPlayer(player: self.player!)
        leaderboardTableView!.setSearchHeaderAlignmentConstraint(searchHeaderAlignmentConstraint: self.searchHeaderAlignmentConstraint)
        //leaderboardTableView!.setIndicator(indicator: self.activityIndicator!)
        
        self.dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    }
    
    var dismissKeyboardGesture: UITapGestureRecognizer?
    
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
        //StoryboardSelector().leader(player: self.player!)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let discoverSelectionIndex = notification.userInfo!["discover_selection"] as! Int
        let gameModel = leaderboardTableView!.getLeaderboardTableList()[discoverSelectionIndex]
        StoryboardSelector().other(player: self.player!, gameModel: gameModel)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            print("skin")
            StoryboardSelector().purchase(player: self.player!, remaining: 13)
        case 1:
            print("quick")
            DispatchQueue.main.async() {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
            QuickTaskPlayer().success(id: self.player!.getId()) { (result) in
                
                
                DispatchQueue.main.async() {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    
                    let opponent = result as! Player
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Quick", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Quick") as! Quick
                    viewController.setPlayer(player: self.player!)
                    viewController.setOpponent(opponent: opponent)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            
//        case 2:
//            print("search")
//            //profile(player: Player)
//            //StoryboardSelector().profile(player: self.player!)
//            let storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "Search") as! Search
//            viewController.setPlayer(player: self.player!)
//            UIApplication.shared.keyWindow?.rootViewController = viewController
        case 3:
            print("game")
            StoryboardSelector().actual(player: self.player!)
        case 4:
            print("overview") //OVERVIEW
            let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
            viewController.setPlayer(player: self.player!)
            //viewController.setOpponent(opponent: opponent)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        default:
            print("error")
        }
    }
}


