//
//  Quick.swift
//  ios
//
//  Created by Matthew on 12/10/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Quick:
                    UIViewController,
                    UIPickerViewDataSource,
                    UIPickerViewDelegate,
                    UITabBarDelegate,
                    UIGestureRecognizerDelegate {
    
    var opponent: PlayerCore?
    
    public func setOpponent(opponent: PlayerCore){
        self.opponent = opponent
    }
    
    @IBOutlet weak var configCollectionView: DynamicCollectionView!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var rankDateLabel: UILabel!
    //    @IBOutlet weak var rankDateLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    //       @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    //       @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    //       @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    //       @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //       @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    let reuseIdentifier = "cell"
    
    @IBOutlet weak var activeConfigNumber: UILabel!
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    @IBOutlet weak var indicatorLabel0: UILabel!
    @IBOutlet weak var indicatorLabel1: UILabel!
    @IBOutlet weak var indicatorLabel2: UILabel!
    @IBOutlet weak var indicatorLabelS: UILabel!
    
    func renderConfig0() {
        self.tschessElementMatrix = self.player!.getConfig0()
        
        self.activeConfigNumber.text = "0̸"
        self.configCollectionView.reloadData()
        
        let alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        let alphaDotHalf = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotHalf!)
        let activeConfigFull = NSMutableAttributedString()
        activeConfigFull.append(alphaDotFull)
        let activeConfigNull = NSMutableAttributedString()
        activeConfigNull.append(alphaDotHalf)
        
        self.indicatorLabel0.attributedText = activeConfigFull
        self.indicatorLabel1.attributedText = activeConfigNull
        self.indicatorLabel2.attributedText = activeConfigNull
        self.indicatorLabelS.attributedText = activeConfigNull
    }
    
    func renderConfig1() {
        self.tschessElementMatrix = self.player!.getConfig1()
     
        self.activeConfigNumber.text = "1"
        self.configCollectionView.reloadData()
        
        let alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        let alphaDotHalf = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotHalf!)
        let activeConfigFull = NSMutableAttributedString()
        activeConfigFull.append(alphaDotFull)
        let activeConfigNull = NSMutableAttributedString()
        activeConfigNull.append(alphaDotHalf)
        
        self.indicatorLabel0.attributedText = activeConfigNull
        self.indicatorLabel1.attributedText = activeConfigFull
        self.indicatorLabel2.attributedText = activeConfigNull
        self.indicatorLabelS.attributedText = activeConfigNull
    }
    
    func renderConfig2() {
        self.tschessElementMatrix = self.player!.getConfig2()
       
        self.activeConfigNumber.text = "2"
        self.configCollectionView.reloadData()
        
        let alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        let alphaDotHalf = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotHalf!)
        let activeConfigFull = NSMutableAttributedString()
        activeConfigFull.append(alphaDotFull)
        let activeConfigNull = NSMutableAttributedString()
        activeConfigNull.append(alphaDotHalf)
        
        self.indicatorLabel0.attributedText = activeConfigNull
        self.indicatorLabel1.attributedText = activeConfigNull
        self.indicatorLabel2.attributedText = activeConfigFull
        self.indicatorLabelS.attributedText = activeConfigNull
    }
    
    
    var tschessElementMatrix: [[TschessElement?]]?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.configCollectionView.bounces = false
        self.configCollectionView.alwaysBounceVertical = false
        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
    }
    
    let dateTime: DateTime = DateTime()
    
    //MARK: Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    //@IBOutlet weak var usernameLabel: UILabel!
    
    //@IBOutlet weak var rankLabel: UILabel!
    //@IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var skinSelectionPicker: UIPickerView!
    
    var player: Player?
    var gameModel: Game?
    
    var skinSelectionPick: String = "calypso"
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.skinList!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let skinAsset = self.skinList![row]
        
        let sampleView = SampleSkin.instanceFromNib()
        sampleView.nameLabel.text = skinAsset.getName()

        sampleView.backgroundView.backgroundColor = skinAsset.getBackColor()
        sampleView.backgroundView.alpha = skinAsset.getBackAlpha()
        sampleView.backgroundImage.image = skinAsset.getBackImage()
        
        sampleView.foregroundView.backgroundColor = skinAsset.getForeColor()
        sampleView.foregroundView.alpha = skinAsset.getForeAlpha()
        sampleView.foregroundImage.image = skinAsset.getForeImage()
        
        return sampleView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 69
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        skinSelectionPick = self.skinList![row].getName()
    }
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    func setGameModel(gameModel: Game){
        self.gameModel = gameModel
    }
    
    var attributeAlphaDotFull: [NSAttributedString.Key: NSObject]?
    var attributeAlphaDotHalf: [NSAttributedString.Key: NSObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tabBarMenu.delegate = self
        
        //opponent
        let dataDecoded: Data = Data(base64Encoded: self.opponent!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = self.opponent!.getRank()
        self.usernameLabel.text = self.opponent!.getUsername()
        
        self.tschessElementMatrix = self.player!.getConfig0()
        
        
        self.configCollectionView.delegate = self
        self.configCollectionView.dataSource = self
        
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = false
        
        self.attributeAlphaDotFull = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)]
        self.attributeAlphaDotHalf = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)]
        let alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        let alphaDotHalf = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotHalf!)
        let activeConfigFull = NSMutableAttributedString()
        activeConfigFull.append(alphaDotFull)
        let activeConfigNull = NSMutableAttributedString()
        activeConfigNull.append(alphaDotHalf)
        
        self.indicatorLabel0.attributedText = activeConfigFull
        self.indicatorLabel1.attributedText = activeConfigNull
        self.indicatorLabel2.attributedText = activeConfigNull
        self.indicatorLabelS.attributedText = activeConfigNull
        
        self.activityIndicator.isHidden = true
        
        let orange: UIColor = UIColor(red: 255/255.0, green: 105/255.0, blue: 104/255.0, alpha: 1) //FF6968
        let pink: UIColor = UIColor(red: 255/255.0, green: 105/255.0, blue: 180/255.0, alpha: 1)
        let purple: UIColor = UIColor(red: 140/255.0, green: 0/255.0, blue: 192/255.0, alpha: 1)
        let blue: UIColor = UIColor(red: 84/255.0, green: 140/255.0, blue: 240/255.0, alpha: 1)
        let green: UIColor = UIColor(red: 0/255.0, green: 255/255.0, blue: 88/255.0, alpha: 1)
        
        let hyperion: Skin = Skin(name: "hyperion", foreColor: purple, backColor: blue)
        let calypso: Skin = Skin(name: "calypso", foreColor: pink, backColor: UIColor.black)
        let neptune: Skin = Skin(name: "neptune", foreColor: green, backColor: orange, backAlpha: 0.85)
        
        let iapetus: Skin = Skin(
            name: "iapetus",
            foreColor: UIColor.white,
            foreImage: UIImage(named: "iapetus"),
            backColor: UIColor.black,
            backImage: UIImage(named: "iapetus"),
            backAlpha: 0.85)
        
        self.skinList = Array(arrayLiteral: calypso, hyperion, neptune, iapetus)
    }
    
    var skinList: Array<Skin>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.skinSelectionPicker.delegate = self
        self.skinSelectionPicker.dataSource = self
        
        self.swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRightGesture!.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(self.swipeRightGesture!)
        self.swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeftGesture!.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(self.swipeLeftGesture!)
        
        let elementCollectionViewGesture = UITapGestureRecognizer(target: self, action: #selector(self.renderElementCollectionView))
        self.configCollectionView.addGestureRecognizer(elementCollectionViewGesture)
    }
    
    @objc func renderElementCollectionView() {
        let storyboard: UIStoryboard = UIStoryboard(name: "EditOther", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditOther") as! EditOther
        viewController.setTitleText(titleText: "quick play")
        viewController.setActiveConfigNumber(activeConfigNumber: Int(self.activeConfigNumber.text!)!)
        viewController.setPlayerOther(playerOther: self.gameModel!.getOpponent())
        viewController.setPlayerSelf(playerSelf: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    var swipeRightGesture: UISwipeGestureRecognizer?
    var swipeLeftGesture: UISwipeGestureRecognizer?
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if(activeConfigNumber.text == "2"){
                    self.renderConfig1()
                    return
                }
                if(activeConfigNumber.text == "1"){
                    self.renderConfig0()
                    return
                }
            case UISwipeGestureRecognizer.Direction.left:
                if(activeConfigNumber.text == "0̸"){
                    self.renderConfig1()
                    return
                }
                if(activeConfigNumber.text == "1"){
                    self.renderConfig2()
                    return
                }
            default:
                break
            }
        }
    }
    
    func stayHandler(action: UIAlertAction) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
        homeViewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }

    @IBAction func backButtonClick(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
        homeViewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
        func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            switch item.tag {
            default: //1
                //self.issueChallengeButton.isHidden = true
                
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                
                var clock = "24"
    //            if(pickerSelectionTimeLimit == "01:00 h"){
    //                clock = "1"
    //            }
    //            if(pickerSelectionTimeLimit == "00:05 m"){
    //                clock = "5"
    //            }
                var config = "config0"
    //            if(pickerSelectionConfiguration == "config. 1"){
    //                config = "config1"
    //            }
    //            if(pickerSelectionConfiguration == "config. 2"){
    //                config = "config2"
    //            }
                let white_name = gameModel!.getUsernameOpponent()
                let white_uuid = gameModel!.getOpponentId()
                let black_name = player!.getUsername()
                let black_uuid = player!.getId()
                let updated = dateTime.currentDateString()
                let requestPayload = [
                    "white_name": white_name,
                    "white_uuid": white_uuid,
                    "black_name": black_name,
                    "black_uuid": black_uuid,
                    "clock": clock,
                    "config": config,
                    "updated": updated,
                    "created": updated
                    ] as [String : Any]
                GameCreate().success(requestPayload: requestPayload){ (result) in
                    if(result == nil){
                        DispatchQueue.main.async() {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            //self.issueChallengeButton.isHidden = false
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
                            let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.stayHandler)
                            action.setValue(Colour().getRed(), forKey: "titleTextColor")
                            alertController.addAction(action)
                            alertController.view.backgroundColor = UIColor.black
                            alertController.view.layer.cornerRadius = 40
                            self.present(alertController, animated: true, completion: nil)
                        }
                        return
                    }
                    
                    let responseDict = result as! [String: Any]
                    
                    let success = responseDict["success"] as? String
                    if(success != nil){
                        DispatchQueue.main.async() {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            //self.issueChallengeButton.isHidden = false
                            let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                            let myString = "success"
                            var myMutableString = NSMutableAttributedString()
                            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                            alertController.setValue(myMutableString, forKey: "attributedTitle")
                            let message = "\nchallenge has been issued"
                            var messageMutableString = NSMutableAttributedString()
                            messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                            messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                            alertController.setValue(messageMutableString, forKey: "attributedMessage")
                            let action = UIAlertAction(title: "ACK", style: UIAlertAction.Style.default, handler: self.stayHandler)
                            action.setValue(Colour().getRed(), forKey: "titleTextColor")
                            alertController.addAction(action)
                            alertController.view.backgroundColor = UIColor.black
                            alertController.view.layer.cornerRadius = 40
                            self.present(alertController, animated: true, completion: nil)
                        }
                        return
                    }
                    let catalyst = responseDict["catalyst"] as? String
                    let error = responseDict["error"] as? String
                    
                    if(catalyst == nil){
                        if(error == "auto"){
                            DispatchQueue.main.async() {
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.isHidden = true
                                //self.issueChallengeButton.isHidden = false
                                let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                                let myString = "reflexive prohibition"
                                var myMutableString = NSMutableAttributedString()
                                myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                                alertController.setValue(myMutableString, forKey: "attributedTitle")
                                let message = "\ncannot play against oneself"
                                var messageMutableString = NSMutableAttributedString()
                                messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                                messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                                alertController.setValue(messageMutableString, forKey: "attributedMessage")
                                let action = UIAlertAction(title: "ACK", style: UIAlertAction.Style.default, handler: self.stayHandler)
                                action.setValue(Colour().getRed(), forKey: "titleTextColor")
                                alertController.addAction(action)
                                alertController.view.backgroundColor = UIColor.black
                                alertController.view.layer.cornerRadius = 40
                                self.present(alertController, animated: true, completion: nil)
                            }
                            return
                        }
                        if(error == "prior"){
                            DispatchQueue.main.async() {
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.isHidden = true
                                //self.issueChallengeButton.isHidden = false
                                let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                                let myString = "resolve ongoing interaction"
                                var myMutableString = NSMutableAttributedString()
                                myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                                alertController.setValue(myMutableString, forKey: "attributedTitle")
                                let message = "\nlimited to one mutual ongoing\ngame or invitation at a time\nbetween any two players"
                                var messageMutableString = NSMutableAttributedString()
                                messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                                messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                                alertController.setValue(messageMutableString, forKey: "attributedMessage")
                                let action = UIAlertAction(title: "ACK", style: UIAlertAction.Style.default, handler: self.stayHandler)
                                action.setValue(Colour().getRed(), forKey: "titleTextColor")
                                alertController.addAction(action)
                                alertController.view.backgroundColor = UIColor.black
                                alertController.view.layer.cornerRadius = 40
                                self.present(alertController, animated: true, completion: nil)
                            }
                            return
                        }
                    }
                    switch error {
                    case "proposed":
                        if(catalyst == "opponent"){
                            DispatchQueue.main.async() {
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.isHidden = true
                                //self.issueChallengeButton.isHidden = false
                                let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                                let myString = "maximum invite threshold"
                                var myMutableString = NSMutableAttributedString()
                                myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                                alertController.setValue(myMutableString, forKey: "attributedTitle")
                                let message = "\nthis player has no capacity\nto accept new challenges\nat this time\nplease try again later"
                                var messageMutableString = NSMutableAttributedString()
                                messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                                messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                                alertController.setValue(messageMutableString, forKey: "attributedMessage")
                                let action = UIAlertAction(title: "ACK", style: UIAlertAction.Style.default, handler: self.stayHandler)
                                action.setValue(Colour().getRed(), forKey: "titleTextColor")
                                alertController.addAction(action)
                                alertController.view.backgroundColor = UIColor.black
                                alertController.view.layer.cornerRadius = 40
                                self.present(alertController, animated: true, completion: nil)
                            }
                            break
                        }
                        DispatchQueue.main.async() {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            //self.issueChallengeButton.isHidden = false
                            let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                            let myString = "maximum invite threshold"
                            var myMutableString = NSMutableAttributedString()
                            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                            alertController.setValue(myMutableString, forKey: "attributedTitle")
                            let message = "\nplease resolve at least one\nexisting invitation\nprior to issuing new challenge"
                            var messageMutableString = NSMutableAttributedString()
                            messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                            messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                            alertController.setValue(messageMutableString, forKey: "attributedMessage")
                            let action = UIAlertAction(title: "ACK", style: UIAlertAction.Style.default, handler: self.stayHandler)
                            action.setValue(Colour().getRed(), forKey: "titleTextColor")
                            alertController.addAction(action)
                            alertController.view.backgroundColor = UIColor.black
                            alertController.view.layer.cornerRadius = 40
                            self.present(alertController, animated: true, completion: nil)
                        }
                    default:
                        DispatchQueue.main.async() {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            //self.issueChallengeButton.isHidden = false
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
                            let action = UIAlertAction(title: "ACK", style: UIAlertAction.Style.default, handler: self.stayHandler)
                            action.setValue(Colour().getRed(), forKey: "titleTextColor")
                            alertController.addAction(action)
                            alertController.view.backgroundColor = UIColor.black
                            alertController.view.layer.cornerRadius = 40
                            self.present(alertController, animated: true, completion: nil)
                        }
                        return
                    }
                }
            }
        }
    }



//MARK: - UICollectionViewDataSource
extension Quick: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ConfigCollectionViewCell
        
        if (indexPath.row % 2 == 0) {
            if (indexPath.row / 8 == 0) {
                cell.backgroundColor = UIColor(red: 220/255.0, green: 0/255.0, blue: 70/255.0, alpha: 0.65)
            } else {
                cell.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.88)
            }
        } else {
            if (indexPath.row / 8 == 0) {
                cell.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.88)
            } else {
                cell.backgroundColor = UIColor(red: 220/255.0, green: 0/255.0, blue: 70/255.0, alpha: 0.65)
            }
        }
        
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        
        if(self.tschessElementMatrix![x][y] != nil){
            cell.imageView.image = self.tschessElementMatrix![x][y]!.getImageDefault()
        } else {
            cell.imageView.image = nil
        }
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension Quick: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 8
        let dim = collectionView.frame.width / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

