//
//  Ack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Ack:
    UIViewController,
    UIPickerViewDataSource,
    UIPickerViewDelegate,
UITabBarDelegate, UIGestureRecognizerDelegate {
    
    var player: EntityPlayer?
    
    public func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var gameTschess: EntityGame?
    
    public func setGameTschess(gameTschess: EntityGame) {
        self.gameTschess = gameTschess
    }
    
    @IBOutlet weak var configCollectionView: BoardView!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var rankDateLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var activeConfigNumber: UILabel!
    
    let reuseIdentifier = "square"
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var splitViewHeight0: NSLayoutConstraint!
    @IBOutlet var splitViewHeight1: NSLayoutConstraint! //strong
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    @IBOutlet weak var indicatorLabel0: UILabel!
    @IBOutlet weak var indicatorLabel1: UILabel!
    @IBOutlet weak var indicatorLabel2: UILabel!
    @IBOutlet weak var indicatorLabelS: UILabel!
    
    func renderConfig0() {
        self.tschessElementMatrix = self.player!.getConfig(index: 0)
        self.configActive = 0
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
        self.tschessElementMatrix = self.player!.getConfig(index: 1)
        self.configActive = 1
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
        self.tschessElementMatrix = self.player!.getConfig(index: 2)
        self.configActive = 2
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
    
    
    var tschessElementMatrix: [[Piece?]]?
    
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
    
    @IBOutlet weak var skinSelectionPicker: UIPickerView!
    
    var skinSelectionPick: String = "iapetus"
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.skinList!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let skinAsset = self.skinList![row]
        
        let sampleView = Skin.instanceFromNib()
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
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerOther!.getImageAvatar()
        self.usernameLabel.text = self.playerOther!.username
        self.eloLabel.text = self.playerOther!.getLabelTextElo()
        self.rankLabel.text = self.playerOther!.getLabelTextRank()
        self.rankDateLabel.text = self.playerOther!.getLabelTextDate()
    }
    
    var attributeAlphaDotFull: [NSAttributedString.Key: NSObject]?
    var attributeAlphaDotHalf: [NSAttributedString.Key: NSObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarMenu.delegate = self
        
        self.renderHeader()
        
        
        
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
        
        let hyperion: EntitySkin = EntitySkin(name: "hyperion", foreColor: purple, backColor: blue)
        let calypso: EntitySkin = EntitySkin(name: "calypso", foreColor: pink, backColor: UIColor.black)
        let neptune: EntitySkin = EntitySkin(name: "neptune", foreColor: green, backColor: orange, backAlpha: 0.85)
        
        let iapetus: EntitySkin = EntitySkin(
            name: "iapetus",
            foreColor: UIColor.white,
            foreImage: UIImage(named: "iapetus"),
            backColor: UIColor.black,
            backImage: UIImage(named: "iapetus"),
            backAlpha: 0.85)
        
        self.skinList = Array(arrayLiteral: iapetus, calypso, hyperion, neptune) //in actual fact default will come first...
        
        
        if(self.configActive == 0){
            self.tschessElementMatrix = self.player!.getConfig(index: 0)
        }
        if(self.configActive == 1){
            self.tschessElementMatrix = self.player!.getConfig(index: 1)
        }
        if(self.configActive == 2){
            self.tschessElementMatrix = self.player!.getConfig(index: 2)
        }
    }
    
    var skinList: Array<EntitySkin>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let totalContentHeight = self.contentView.frame.size.height
        
        self.splitViewHeight0.isActive = false
        self.splitViewHeight1.isActive = false
        self.splitViewHeight0.constant = totalContentHeight/2
        self.splitViewHeight1.constant = totalContentHeight/2
        self.splitViewHeight0.isActive = true
        self.splitViewHeight1.isActive = true
        
        
        
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
    
    var configActive: Int = 0
    
    @objc func renderElementCollectionView() {
        
        if(activeConfigNumber.text == "0̸"){
            self.configActive = 0
        }
        if(activeConfigNumber.text == "1"){
            self.configActive = 1
        }
        if(activeConfigNumber.text == "2"){
            self.configActive = 2
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "EditOther", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditOther") as! EditOther
        viewController.setTitleText(titleText: "let's play!")
        viewController.setActiveConfigNumber(activeConfigNumber: configActive)
        viewController.setPlayerOther(playerOther: self.playerOther!)
        viewController.setPlayerSelf(playerSelf: self.playerSelf!)
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
    
    @IBAction func backButtonClick(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
        homeViewController.setPlayer(player: self.playerSelf!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
}



//MARK: - UICollectionViewDataSource
extension Ack: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! SquareCell
        cell.backgroundColor = .black
        if (indexPath.row / 8 == 0) {
            cell.backgroundColor = .white
        }
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = .white
            if (indexPath.row / 8 == 0) {
                cell.backgroundColor = .black
            }
        }
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        cell.imageView.image = nil
        if(self.tschessElementMatrix![x][y] != nil){
            cell.imageView.image = self.tschessElementMatrix![x][y]!.getImageDefault()
        }
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension Ack: UICollectionViewDelegateFlowLayout {
    
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
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            print("let's play")
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            let id_game = self.gameTschess!.id
            let id_player = self.playerSelf!.id
            let skin = "DEFAULT"
            let CONFIG = 3 //!!!
            
            let requestPayload: [String: Any] = [
                "id_game": id_game,
                "id_player": id_player,
                "skin": skin,
                "config": CONFIG]
            
            RequestAck().execute(requestPayload: requestPayload) { (game) in
                print("result: \(game)")
                /**
                 * ERROR HANDLING!!!
                 */
                if(game == nil){
                    return
                }
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                    viewController.setGameTschess(gameTschess: game!)
                    viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                    viewController.setPlayerOther(playerOther: game!.getPlayerOther(username: self.playerSelf!.username))
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
        }
    }
}
