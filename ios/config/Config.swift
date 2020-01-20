//
//  Home.swift
//  ios
//
//  Created by Matthew on 10/23/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Config: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var upperPartitionView: UIView!
    @IBOutlet weak var lowerPartitionView: UIView!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tschxLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var cancelEditImageButton: UIImageView!
    @IBOutlet weak var configPartitionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var configCollectionView: DynamicCollectionView!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tschessElementCollectionView: UICollectionView!
    
    @IBOutlet weak var saveConfigButton: UIButton!
    
    @IBOutlet weak var activeConfigLabel: UILabel!
    @IBOutlet weak var configIndicatorLabel: UILabel!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    let dateTime: DateTime = DateTime()
    var attributeAlphaDotFull: [NSAttributedString.Key: NSObject]?
    var attributeAlphaDotHalf: [NSAttributedString.Key: NSObject]?
    
    var updatePhotoGesture: UITapGestureRecognizer?
    var swipeRightGesture: UISwipeGestureRecognizer?
    var swipeLeftGesture: UISwipeGestureRecognizer?
    
    let reuseIdentifier = "cell"
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    var arrayFirst = [
        "red_pawn",
        "red_knight",
        "red_bishop",
        "red_rook",
        "red_queen",
        "red_amazon",
        "red_landmine_pawn",
        "red_hunter",
        "red_grasshopper",
        "red_arrow"]
    
    var tschessElementMatrix: [[TschessElement?]]?
    var tschessElementMatrix0: [[TschessElement?]]?
    var tschessElementMatrix1: [[TschessElement?]]?
    var tschessElementMatrix2: [[TschessElement?]]?
    
    var selectionElementName: String?
    var cacheCancelMatrix: [[TschessElement?]]?
    var cacheMatrix: [[TschessElement?]]?
    
    var points: Int?
    
    var deviceType: String?
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    @objc func dismissEditUtilities() {
        self.avatarImageView.addGestureRecognizer(self.updatePhotoGesture!)
        self.view.addGestureRecognizer(self.swipeRightGesture!)
        self.view.addGestureRecognizer(self.swipeLeftGesture!)
        
        self.configCollectionView.dragInteractionEnabled = false
        
        self.cancelEditImageButton.isHidden = true
        self.pointsView.isHidden = true
        
        self.tschessElementMatrix = self.cacheCancelMatrix
        
        self.configCollectionView.reloadData()
        
        self.tschessElementCollectionView.isHidden = true
        
        self.saveConfigButton.isHidden = true
        self.activeConfigLabel.isHidden = false
    }
    
    @IBAction func saveConfigButtonClick(_ sender: Any) {
        self.persistCurrentConfig()
        self.avatarImageView!.addGestureRecognizer(self.updatePhotoGesture!)
        self.view.addGestureRecognizer(self.swipeRightGesture!)
        self.view.addGestureRecognizer(self.swipeLeftGesture!)
        
        self.configCollectionView.dragInteractionEnabled = false
        
        self.tschessElementCollectionView.isHidden = true
        self.cancelEditImageButton.isHidden = true
        self.notificationLabel.isHidden = true
        self.saveConfigButton.isHidden = true
        self.pointsView.isHidden = true
        
        self.activeConfigLabel.isHidden = false
    }
    
    func persistCurrentConfig() {
        DispatchQueue.main.async() {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        let id = self.player!.getId()
        let config = ConfigSerializer().serializeConfiguration(savedConfigurationMatrix: self.tschessElementMatrix!)
        var updateConfig = [
            "id": id,
            "config": config,
            "updated": self.dateTime.currentDateString()
            ] as [String: Any]
        
        var name: String = "config0"
        if(activeConfigLabel.text == "config. 1"){
            name = "config1"
        }
        if(activeConfigLabel.text == "config. 2"){
            name = "config2"
        }
        updateConfig["name"] = name
        UpdateConfig().execute(requestPayload: updateConfig, player: self.player!) { (result) in
            if result == nil {
                //print("error!") // print a popup
            }
            //out to assign to user model right here...
            self.player = result!
            DispatchQueue.main.async() {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                if(self.activeConfigLabel.text == "config. 0̸"){
                    self.renderConfig0()
                    self.configCollectionView.reloadData()
                    return
                }
                if(self.activeConfigLabel.text == "config. 1"){
                    self.renderConfig1()
                    self.configCollectionView.reloadData()
                    return
                }
                if(self.activeConfigLabel.text == "config. 2"){
                    self.renderConfig2()
                    self.configCollectionView.reloadData()
                    return
                }
            }
        }
    }
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deviceType = StoryboardSelector().device()
        
        self.configCollectionView.delegate = self
        self.configCollectionView.dataSource = self
        self.configCollectionView.dragDelegate = self
        self.configCollectionView.dropDelegate = self
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = false
        
        self.upperPartitionView.addInteraction(UIDropInteraction(delegate: self))
        self.lowerPartitionView.addInteraction(UIDropInteraction(delegate: self))
        
        self.tschessElementCollectionView.delegate = self
        self.tschessElementCollectionView.dataSource = self
        self.tschessElementCollectionView.dragDelegate = self
        self.tschessElementCollectionView.isUserInteractionEnabled = true
        self.tschessElementCollectionView.dragInteractionEnabled = true
        
        self.notificationLabel.isHidden = true
        self.activityIndicator.isHidden = true
        self.pointsView.isHidden = true
        self.tschessElementCollectionView.isHidden = true
        self.saveConfigButton.isHidden = true
        self.cancelEditImageButton.isHidden = true
        
        self.attributeAlphaDotFull = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)]
        self.attributeAlphaDotHalf = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)]
        let alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        let alphaDotHalf = NSMutableAttributedString(string: " • ", attributes: self.attributeAlphaDotHalf!)
        
        let activeConfigLabeleString = NSMutableAttributedString()
        activeConfigLabeleString.append(alphaDotHalf)
        activeConfigLabeleString.append(alphaDotFull)
        activeConfigLabeleString.append(alphaDotHalf)
        self.configIndicatorLabel.attributedText = activeConfigLabeleString
        
        self.tabBarMenu.delegate = self
        
        self.updateHeader()
        
    }
    
    func renderConfig0() {
        self.tschessElementMatrix = self.player!.getConfig0()
        self.cacheCancelMatrix = self.tschessElementMatrix0
        self.activeConfigLabel.text = "config. 0̸"
        self.configCollectionView.reloadData()
        
        let alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        let alphaDotHalf = NSMutableAttributedString(string: " • •", attributes: self.attributeAlphaDotHalf!)
        let activeConfigLabeleString = NSMutableAttributedString()
        activeConfigLabeleString.append(alphaDotFull)
        activeConfigLabeleString.append(alphaDotHalf)
        self.configIndicatorLabel.attributedText = activeConfigLabeleString
    }
    
    func renderConfig1() {
        self.tschessElementMatrix = self.player!.getConfig1()
        self.cacheCancelMatrix = self.tschessElementMatrix1
        self.activeConfigLabel.text = "config. 1"
        self.configCollectionView.reloadData()
        
        let alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        let alphaDotHalf = NSMutableAttributedString(string: " • ", attributes: self.attributeAlphaDotHalf!)
        let activeConfigLabeleString = NSMutableAttributedString()
        activeConfigLabeleString.append(alphaDotHalf)
        activeConfigLabeleString.append(alphaDotFull)
        activeConfigLabeleString.append(alphaDotHalf)
        self.configIndicatorLabel.attributedText = activeConfigLabeleString
    }
    
    func renderConfig2() {
        self.tschessElementMatrix = self.player!.getConfig2()
        self.cacheCancelMatrix = self.tschessElementMatrix2
        self.activeConfigLabel.text = "config. 2"
        self.configCollectionView.reloadData()
        
        let alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        let alphaDotHalf = NSMutableAttributedString(string: "• • ", attributes: self.attributeAlphaDotHalf!)
        let activeConfigLabeleString = NSMutableAttributedString()
        activeConfigLabeleString.append(alphaDotHalf)
        activeConfigLabeleString.append(alphaDotFull)
        self.configIndicatorLabel.attributedText = activeConfigLabeleString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedImage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedImage
        self.avatarImageView.isUserInteractionEnabled = true
        self.rankLabel.text = self.player!.getRank()
        self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getName()
        
        self.tschessElementMatrix0 = self.player!.getConfig0()
        self.tschessElementMatrix1 = self.player!.getConfig1()
        self.tschessElementMatrix2 = self.player!.getConfig2()
        
        //self.tschessElementMatrix = tschessElementMatrix1 //TODO: RANDOMIZE!!!
        //self.cacheCancelMatrix = tschessElementMatrix1
        //self.activeConfigLabel.text = "config. 1"
        switch Int.random(in: 0 ... 2) {
        case 0:
            self.renderConfig0()
        case 1:
            self.renderConfig1()
        default:
            self.renderConfig2()
        }
        
        let kingNotificationGesture = UITapGestureRecognizer(target: self, action: #selector(self.kingNotificationGesture))
        self.notificationLabel.isUserInteractionEnabled = true
        self.notificationLabel.addGestureRecognizer(kingNotificationGesture)
        
        let cancelEditGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissEditUtilities))
        self.cancelEditImageButton.addGestureRecognizer(cancelEditGesture)
        let elementCollectionViewGesture = UITapGestureRecognizer(target: self, action: #selector(self.renderElementCollectionView))
        self.configCollectionView.addGestureRecognizer(elementCollectionViewGesture)
        
        self.updatePhotoGesture = UITapGestureRecognizer(target: self, action: #selector(self.updatePhoto))
        self.avatarImageView.addGestureRecognizer(self.updatePhotoGesture!)
        self.swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRightGesture!.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(self.swipeRightGesture!)
        self.swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeftGesture!.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(self.swipeLeftGesture!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.configCollectionView.bounces = false
        self.configCollectionView.alwaysBounceVertical = false
        
        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
        self.configPartitionHeightConstraint.constant = configCollectionViewHeight.constant * 2
        
        if let longPressRecognizer = configCollectionView.gestureRecognizers?.compactMap({ $0 as? UILongPressGestureRecognizer}).first {
            longPressRecognizer.minimumPressDuration = 0.01
        }
        if let longPressRecognizer = tschessElementCollectionView.gestureRecognizers?.compactMap({ $0 as? UILongPressGestureRecognizer}).first {
            longPressRecognizer.minimumPressDuration = 0.1
            
        }
    }
    
    @objc func kingNotificationGesture() {
        self.pointsLabel.text = "\(self.generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!))/39"
        self.pointsView.isHidden = false
        self.notificationLabel.isHidden = true
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if(activeConfigLabel.text == "config. 2"){
                    self.renderConfig1()
                    return
                }
                if(activeConfigLabel.text == "config. 1"){
                    self.renderConfig0()
                    return
                }
            case UISwipeGestureRecognizer.Direction.left:
                if(activeConfigLabel.text == "config. 0̸"){
                    self.renderConfig1()
                    return
                }
                if(activeConfigLabel.text == "config. 1"){
                    self.renderConfig2()
                    return
                }
            default:
                break
            }
        }
    }
    
    @objc func renderElementCollectionView() {
        self.avatarImageView.removeGestureRecognizer(self.updatePhotoGesture!)
        self.view.removeGestureRecognizer(self.swipeRightGesture!)
        self.view.removeGestureRecognizer(self.swipeLeftGesture!)
        
        self.configCollectionView.dragInteractionEnabled = true
        
        self.tschessElementCollectionView.reloadData()
        self.tschessElementCollectionView.isHidden = false
        
        self.saveConfigButton.isHidden = false
        self.activeConfigLabel.isHidden = true
        
        self.cancelEditImageButton.isUserInteractionEnabled = true
        self.cancelEditImageButton.isHidden = false
        self.pointsLabel.text = "\(self.generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!))/39"
        self.pointsView.isHidden = false
    }
    
    func okHandler(action: UIAlertAction) {
        StoryboardSelector().home(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            StoryboardSelector().profile(player: self.player!)
        case 1:
            DispatchQueue.main.async() {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
            QuickTaskPlayer().success(id: self.player!.getId()) { (result) in
                if(result == nil) {
                    DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        
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
                    switch error! {
                    case "ongoing":
                        DispatchQueue.main.async() {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            
                            let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                            let myString = "maximum game threshold"
                            var myMutableString = NSMutableAttributedString()
                            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                            alertController.setValue(myMutableString, forKey: "attributedTitle")
                            let message = "\nplease resolve at least one\nongoing game or invitation\nbefore initiating another"
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
                    case "availability":
                        DispatchQueue.main.async() {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            
                            let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                            let myString = "opponent deficit"
                            var myMutableString = NSMutableAttributedString()
                            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                            alertController.setValue(myMutableString, forKey: "attributedTitle")
                            let message = "\nlack of available opponents"
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
                    default:
                        DispatchQueue.main.async() {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            
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
                    }
                    return
                }
                let opponent = result as! Player
                StoryboardSelector().quick(player: self.player!, opponent: opponent)
            }
        case 2:
            StoryboardSelector().actual(player: self.player!)
        default:
            return
            //StoryboardSelector().leader(player: self.player!)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension Config: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.tschessElementCollectionView {
            return arrayFirst.count
        }
        return items.count
    }
    
    func disactivated(tschessElement: TschessElement) -> Bool {
        let pointsCurrent = generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!)
        let pointsNew = pointsCurrent + Int(tschessElement.strength)!
        if(pointsNew > 39){
            return true
        }
        for fairyElement in self.player!.getFairyElementList() {
            if(!tschessElement.standard){
                if(fairyElement.name.lowercased() == tschessElement.name.lowercased()){
                    return false
                }
            } else { //not a fairy element...
                return false
            }
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tschessElementCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TschessElementCell", for: indexPath) as! TschessElementCell
            cell.configureCell(image: UIImage(named: arrayFirst[indexPath.row])!)
            let tschessElement = generateTschessElement(name: arrayFirst[indexPath.row])
            cell.nameLabel.text = tschessElement!.name
            cell.pointsLabel.text = tschessElement!.strength
            cell.imageView.alpha = 1
            cell.nameLabel.alpha = 1
            cell.pointsLabel.alpha = 1
            if(self.disactivated(tschessElement: tschessElement!)){
                cell.imageView.alpha = 0.5
                cell.nameLabel.alpha = 0.5
                cell.pointsLabel.alpha = 0.5
            }
            return cell
        }
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
extension Config: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.tschessElementCollectionView {
            if(self.deviceType! == "XANDROID"){
                return CGSize(width: 100, height: 125)
            }
            return CGSize(width: 100, height: 150)
        }
        let cellsAcross: CGFloat = 8
        let dim = collectionView.frame.width / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.tschessElementCollectionView {
            return 8
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UICollectionViewDragDelegate
extension Config: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?{
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = UIColor.clear
        return previewParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return self.collectionView(collectionView, itemsForBeginning: session, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if(!self.notificationLabel.isHidden){
            self.notificationLabel.isHidden = true
            self.pointsLabel.text = "\(self.generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!))/39"
            self.pointsView.isHidden = false
        }
        self.cacheMatrix = self.tschessElementMatrix!
        
        var generator = UIImpactFeedbackGenerator(style: .light)
        if #available(iOS 13.0, *) {
            generator = UIImpactFeedbackGenerator(style: .rigid)
        }
        generator.impactOccurred()
        
        if collectionView == self.tschessElementCollectionView {
            let tschessElement = generateTschessElement(name: arrayFirst[indexPath.row])
            if(self.disactivated(tschessElement: tschessElement!)){
                return []
            }
            let imageName = imageNameFromElement(tschessElement: tschessElement!)!
            self.selectionElementName = imageName
            let itemProvider = NSItemProvider(object: UIImage(named: imageName)!)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.previewProvider = {
                () -> UIDragPreview? in
                let imageView = UIImageView(image: UIImage(named: imageName)!)
                imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                let previewParameters = UIDragPreviewParameters()
                previewParameters.backgroundColor = UIColor.clear
                return UIDragPreview(view: imageView, parameters: previewParameters)
            }
            return [dragItem]
        }
        /***/
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        let tschessElement = self.tschessElementMatrix![x][y]
        if(tschessElement == nil) {
            return []
        }
        self.tschessElementMatrix![x][y] = nil
        self.configCollectionView.reloadData()
        /***/
        let imageName = imageNameFromElement(tschessElement: tschessElement!)!
        self.selectionElementName = imageName
        let itemProvider = NSItemProvider(object: UIImage(named: imageName)!)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.previewProvider = {
            () -> UIDragPreview? in
            let imageView = UIImageView(image: UIImage(named: imageName)!)
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            let previewParameters = UIDragPreviewParameters()
            previewParameters.backgroundColor = UIColor.clear
            return UIDragPreview(view: imageView, parameters: previewParameters)
        }
        return [dragItem]
    }
    
    internal func collectionView(_: UICollectionView, dragSessionDidEnd: UIDragSession){
        tschessElementCollectionView.reloadData()
        self.pointsLabel.text = "\(self.generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!))/39"
    }
    
}

extension Config: UICollectionViewDropDelegate {
    
    func generatePointsTotal(tschessElementMatrix: [[TschessElement?]]) -> Int {
        var points: Int = 0
        for row in tschessElementMatrix {
            for tschessElement in row {
                if(tschessElement != nil) {
                    let addition = Int(tschessElement!.getStrength())!
                    points += addition
                }
            }
        }
        return points
    }
    
    func collectionView(_ collectionView: UICollectionView,  dropSessionDidEnd session: UIDropSession) {
        var kingAbsent: Bool = true
        for row in self.tschessElementMatrix! {
            for tschessElement in row {
                if(tschessElement != nil){
                    if(tschessElement!.name.lowercased().contains("king")){
                        kingAbsent = false
                    }
                }
            }
        }
        if(kingAbsent){
            self.tschessElementMatrix = self.cacheMatrix
            configCollectionView.reloadData()
        }
        let pointUpdate = generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!)
        if(pointUpdate > 39){
            self.tschessElementMatrix = self.cacheMatrix
            configCollectionView.reloadData()
        } else {
            self.pointsLabel.text = "\(pointUpdate)/39"
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let x = coordinator.destinationIndexPath!.row / 8
        let y = coordinator.destinationIndexPath!.row % 8
        let tschessElement = generateTschessElement(name: self.selectionElementName!)
        self.tschessElementMatrix![x][y] = tschessElement!
        configCollectionView.reloadData()
    }
    
}

extension Config: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //print("You selected cell #\(indexPath.item)!")
    }
    
    func generateTschessElement(name: String) -> TschessElement? {
        if(name.contains("arrow")){
            return ArrowPawn()
        }
        if(name.contains("grasshopper")){
            return Grasshopper()
        }
        if(name.contains("hunter")){
            return Hunter()
        }
        if(name.contains("landmine")){
            return LandminePawn()
        }
        if(name.contains("medusa")){
            return Medusa()
        }
        if(name.contains("spy")){
            return Spy()
        }
        if(name.contains("amazon")){
            return Amazon()
        }
        if(name.contains("pawn")){
            return Pawn()
        }
        if(name.contains("knight")){
            return Knight()
        }
        if(name.contains("bishop")){
            return Bishop()
        }
        if(name.contains("rook")){
            return Rook()
        }
        if(name.contains("queen")){
            return Queen()
        }
        if(name.contains("king")){
            return King()
        }
        return nil
    }
    
    func imageNameFromElement(tschessElement: TschessElement) -> String? {
        if(tschessElement.name == ArrowPawn().name){
            return "red_arrow"
        }
        if(tschessElement.name == Grasshopper().name){
            return "red_grasshopper"
        }
        if(tschessElement.name == Hunter().name){
            return "red_hunter"
        }
        if(tschessElement.name == LandminePawn().name){
            return "red_landmine_pawn"
        }
        if(tschessElement.name == Medusa().name){
            return "red_medusa"
        }
        if(tschessElement.name == Spy().name){
            return "red_spy"
        }
        if(tschessElement.name == Amazon().name){
            return "red_amazon"
        }
        if(tschessElement.name == Pawn().name){
            return "red_pawn"
        }
        if(tschessElement.name == Knight().name){
            return "red_knight"
        }
        if(tschessElement.name == Bishop().name){
            return "red_bishop"
        }
        if(tschessElement.name == Rook().name){
            return "red_rook"
        }
        if(tschessElement.name == Queen().name){
            return "red_queen"
        }
        if(tschessElement.name == King().name){
            return "red_king"
        }
        return nil
    }
    
    func changePhoto() {
        DispatchQueue.main.async() {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.async() {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[.originalImage] as! UIImage
        let imageString = selectedImage.jpegData(compressionQuality: 0.1)!.base64EncodedString()
        
        let updatePhoto = ["id": self.player!.getId(), "avatar": imageString] as [String: Any]
        UpdatePhoto().execute(requestPayload: updatePhoto) { (error) in
            if error != nil {
                print("error: \(error!.localizedDescription)")
            }
        }
        let dataDecoded: Data = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        avatarImageView.image = decodedimage
        self.player!.setAvatar(avatar: imageString)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updatePhoto() {
        self.changePhoto()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view!.isDescendant(of: self.tabBarMenu)){
            return false
        }
        return true
    }
    
    func updateHeader() {
        GetHeaderTask().execute(player: self.player!){ (result, error) in
            if(result == nil){
                return
            }
            self.setPlayer(player: result!)
            DispatchQueue.main.async {
                self.rankLabel.text = self.player!.getRank()
                self.tschxLabel.text = "₮\(self.player!.getTschx())"
                let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
                let decodedimage = UIImage(data: dataDecoded)
                self.avatarImageView.image = decodedimage
            }
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool { // 1
        //print("canHandle session: \(session)")
        return true
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal { // 2
        //print("sessionDidUpdate session: \(session)")
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        //print("performDrop session: \(session)")
        if(self.selectionElementName != nil){
            if(self.selectionElementName!.lowercased().contains("king")){
                
                self.pointsView.isHidden = true
                self.notificationLabel.isHidden = false
                self.notificationLabel.text = "king cannot be removed"
                
                self.tschessElementMatrix = self.cacheMatrix
                configCollectionView.reloadData() //give a warning also... feedback
            }
        }
        self.selectionElementName = nil
        self.configCollectionView.reloadData()
    }
}


