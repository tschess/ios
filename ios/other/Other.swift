//
//  Other.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Other: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITabBarDelegate {
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let dateTime: DateTime = DateTime()
    
    //MARK: Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var usernameLabel: UILabel!
    //@IBOutlet weak var issueChallengeButton: UIButton!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    //@IBOutlet weak var timeLimitPickerView: UIPickerView!
    //@IBOutlet weak var configurationPickerView: UIPickerView!
    
    var player: Player?
    var gameModel: Game?
    
    var otherMenuTable: OtherMenuTable?
    
    var pickerSelectionTimeLimit: String = "24:00 h"
    var pickerOptionsTimeLimit: [String]  = ["24:00 h", "01:00 h", "00:05 m"]
    
    var pickerSelectionConfiguration: String = "config. 0̸"
    //var pickerOptionsConfiguration: [String] = ["config. 0̸", "config. 1", "config. 2", "standard"]
    var pickerOptionsConfiguration: [String] = ["config. 0̸", "config. 1", "config. 2"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return pickerOptionsTimeLimit.count
        }
        return pickerOptionsConfiguration.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)
        
        if pickerView.tag == 1 {
            label.text = pickerOptionsTimeLimit[row]
        } else {
            label.text = pickerOptionsConfiguration[row]
        }
        
        label.textColor = Colour().getRed()
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            pickerSelectionTimeLimit = pickerOptionsTimeLimit[row]
            return
        }
        pickerSelectionConfiguration = pickerOptionsConfiguration[row]
    }
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    func setGameModel(gameModel: Game){
        self.gameModel = gameModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otherMenuTable = children.first as? OtherMenuTable
        self.otherMenuTable!.setGameModel(gameModel: self.gameModel!)
        self.otherMenuTable!.fetchMenuTableList()
        
        tabBarMenu.delegate = self
        
        //self.activityIndicator.isHidden = true
        
        let dataDecoded: Data = Data(base64Encoded: gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = gameModel!.getOpponentRank()
        self.usernameLabel.text = gameModel!.getOpponentName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //timeLimitPickerView.delegate = self
        //timeLimitPickerView.dataSource = self
        
        //configurationPickerView.delegate = self
        //configurationPickerView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "ChallengeMenuTableView"),
            object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let gameMenuSelectionIndex = notification.userInfo!["challenge_menu_game_selection"] as! Int
        let gameModel = self.otherMenuTable!.getGameMenuTableList()[gameMenuSelectionIndex]
        
        let skin = self.otherMenuTable!.getGameMenuTableList()[gameMenuSelectionIndex].getSkin()
        //print("XXXXX: \(skin)")
        
        gameModel.setSkin(skin: skin)
        DispatchQueue.main.async {
            switch StoryboardSelector().device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotXandroid") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotMagnus") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotXenophon") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotPhaedrus") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotCalhoun") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            default:
                return
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().leader(player: self.player!)
    }
    
//    @IBAction func issueChallengeButtonClick(_ sender: Any) {
//        self.issueChallengeButton.isHidden = true
//
//        self.activityIndicator.isHidden = false
//        self.activityIndicator.startAnimating()
//
//        var clock = "24"
//        if(pickerSelectionTimeLimit == "01:00 h"){
//            clock = "1"
//        }
//        if(pickerSelectionTimeLimit == "00:05 m"){
//            clock = "5"
//        }
//        var config = "config0"
//        if(pickerSelectionConfiguration == "config. 1"){
//            config = "config1"
//        }
//        if(pickerSelectionConfiguration == "config. 2"){
//            config = "config2"
//        }
//        let white_name = gameModel!.getOpponentName()
//        let white_uuid = gameModel!.getOpponentId()
//        let black_name = player!.getName()
//        let black_uuid = player!.getId()
//        let updated = dateTime.currentDateString()
//        let requestPayload = [
//            "white_name": white_name,
//            "white_uuid": white_uuid,
//            "black_name": black_name,
//            "black_uuid": black_uuid,
//            "clock": clock,
//            "config": config,
//            "updated": updated,
//            "created": updated
//            ] as [String : Any]
//        GameCreate().success(requestPayload: requestPayload){ (result) in
//            if(result == nil){
//                DispatchQueue.main.async() {
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.isHidden = true
//                    self.issueChallengeButton.isHidden = false
//                    let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
//                    let myString = "server error"
//                    var myMutableString = NSMutableAttributedString()
//                    myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
//                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
//                    alertController.setValue(myMutableString, forKey: "attributedTitle")
//                    let message = "\nplease try again later"
//                    var messageMutableString = NSMutableAttributedString()
//                    messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
//                    messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
//                    alertController.setValue(messageMutableString, forKey: "attributedMessage")
//                    let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.stayHandler)
//                    action.setValue(Colour().getRed(), forKey: "titleTextColor")
//                    alertController.addAction(action)
//                    alertController.view.backgroundColor = UIColor.black
//                    alertController.view.layer.cornerRadius = 40
//                    self.present(alertController, animated: true, completion: nil)
//                }
//                return
//            }
//
//            let responseDict = result as! [String: Any]
//
//            let success = responseDict["success"] as? String
//            if(success != nil){
//                DispatchQueue.main.async() {
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.isHidden = true
//                    self.issueChallengeButton.isHidden = false
//                    let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
//                    let myString = "success"
//                    var myMutableString = NSMutableAttributedString()
//                    myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
//                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
//                    alertController.setValue(myMutableString, forKey: "attributedTitle")
//                    let message = "\nchallenge has been issued"
//                    var messageMutableString = NSMutableAttributedString()
//                    messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
//                    messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
//                    alertController.setValue(messageMutableString, forKey: "attributedMessage")
//                    let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.stayHandler)
//                    action.setValue(Colour().getRed(), forKey: "titleTextColor")
//                    alertController.addAction(action)
//                    alertController.view.backgroundColor = UIColor.black
//                    alertController.view.layer.cornerRadius = 40
//                    self.present(alertController, animated: true, completion: nil)
//                }
//                return
//            }
//            let catalyst = responseDict["catalyst"] as? String
//            let error = responseDict["error"] as? String
//
//            if(catalyst == nil){
//                if(error == "auto"){
//                    DispatchQueue.main.async() {
//                        self.activityIndicator.stopAnimating()
//                        self.activityIndicator.isHidden = true
//                        self.issueChallengeButton.isHidden = false
//                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
//                        let myString = "reflexive prohibition"
//                        var myMutableString = NSMutableAttributedString()
//                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
//                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
//                        alertController.setValue(myMutableString, forKey: "attributedTitle")
//                        let message = "\ncannot play against oneself"
//                        var messageMutableString = NSMutableAttributedString()
//                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
//                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
//                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
//                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.stayHandler)
//                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
//                        alertController.addAction(action)
//                        alertController.view.backgroundColor = UIColor.black
//                        alertController.view.layer.cornerRadius = 40
//                        self.present(alertController, animated: true, completion: nil)
//                    }
//                    return
//                }
//                if(error == "prior"){
//                    DispatchQueue.main.async() {
//                        self.activityIndicator.stopAnimating()
//                        self.activityIndicator.isHidden = true
//                        self.issueChallengeButton.isHidden = false
//                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
//                        let myString = "resolve ongoing interaction"
//                        var myMutableString = NSMutableAttributedString()
//                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
//                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
//                        alertController.setValue(myMutableString, forKey: "attributedTitle")
//                        let message = "\nlimited to one mutual ongoing\ngame or invitation at a time\nbetween any two players"
//                        var messageMutableString = NSMutableAttributedString()
//                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
//                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
//                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
//                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.stayHandler)
//                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
//                        alertController.addAction(action)
//                        alertController.view.backgroundColor = UIColor.black
//                        alertController.view.layer.cornerRadius = 40
//                        self.present(alertController, animated: true, completion: nil)
//                    }
//                    return
//                }
//            }
//            switch error {
//            case "proposed":
//                if(catalyst == "opponent"){
//                    DispatchQueue.main.async() {
//                        self.activityIndicator.stopAnimating()
//                        self.activityIndicator.isHidden = true
//                        self.issueChallengeButton.isHidden = false
//                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
//                        let myString = "maximum invite threshold"
//                        var myMutableString = NSMutableAttributedString()
//                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
//                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
//                        alertController.setValue(myMutableString, forKey: "attributedTitle")
//                        let message = "\nthis player has no capacity\nto accept new challenges\nat this time\nplease try again later"
//                        var messageMutableString = NSMutableAttributedString()
//                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
//                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
//                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
//                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.stayHandler)
//                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
//                        alertController.addAction(action)
//                        alertController.view.backgroundColor = UIColor.black
//                        alertController.view.layer.cornerRadius = 40
//                        self.present(alertController, animated: true, completion: nil)
//                    }
//                    break
//                }
//                DispatchQueue.main.async() {
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.isHidden = true
//                    self.issueChallengeButton.isHidden = false
//                    let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
//                    let myString = "maximum invite threshold"
//                    var myMutableString = NSMutableAttributedString()
//                    myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
//                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
//                    alertController.setValue(myMutableString, forKey: "attributedTitle")
//                    let message = "\nplease resolve at least one\nexisting invitation\nprior to issuing new challenge"
//                    var messageMutableString = NSMutableAttributedString()
//                    messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
//                    messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
//                    alertController.setValue(messageMutableString, forKey: "attributedMessage")
//                    let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.stayHandler)
//                    action.setValue(Colour().getRed(), forKey: "titleTextColor")
//                    alertController.addAction(action)
//                    alertController.view.backgroundColor = UIColor.black
//                    alertController.view.layer.cornerRadius = 40
//                    self.present(alertController, animated: true, completion: nil)
//                }
//            default:
//                DispatchQueue.main.async() {
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.isHidden = true
//                    self.issueChallengeButton.isHidden = false
//                    let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
//                    let myString = "server error"
//                    var myMutableString = NSMutableAttributedString()
//                    myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
//                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
//                    alertController.setValue(myMutableString, forKey: "attributedTitle")
//                    let message = "\nplease try again later"
//                    var messageMutableString = NSMutableAttributedString()
//                    messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
//                    messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
//                    alertController.setValue(messageMutableString, forKey: "attributedMessage")
//                    let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.stayHandler)
//                    action.setValue(Colour().getRed(), forKey: "titleTextColor")
//                    alertController.addAction(action)
//                    alertController.view.backgroundColor = UIColor.black
//                    alertController.view.layer.cornerRadius = 40
//                    self.present(alertController, animated: true, completion: nil)
//                }
//                return
//            }
//        }
//    }
    
    func stayHandler(action: UIAlertAction) {
        StoryboardSelector().challenge(player: self.player!, gameModel: self.gameModel!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            StoryboardSelector().leader(player: self.player!)
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
}
