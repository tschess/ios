//
//  Quick.swift
//  ios
//
//  Created by Matthew on 12/10/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

//import UIKit
//
//class Quick: UIViewController, UITabBarDelegate, UICollectionViewDelegate {
//
//    let dateTime: DateTime = DateTime()
//
//    @IBOutlet weak var playActivityIndicator: UIActivityIndicatorView!
//
//    @IBOutlet weak var rankLabel: UILabel!
//    @IBOutlet weak var tschxLabel: UILabel!
//    @IBOutlet weak var usernameLabel: UILabel!
//    @IBOutlet weak var avatarImageView: UIImageView!
//
//    @IBOutlet weak var opponentEloLabel: UILabel!
//    @IBOutlet weak var opponentRankLabel: UILabel!
//    @IBOutlet weak var opponentImageView: UIImageView!
//    @IBOutlet weak var opponentNameLabel: UILabel!
//
//    @IBOutlet weak var configCollectionView: DynamicCollectionView!
//    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
//
//    @IBOutlet weak var backButton: UIButton!
//    @IBOutlet weak var tabBarMenu: UITabBar!
//
//    @IBOutlet weak var letsPlayButton: UIButton!
//
//    var gameAcceptTask: GameAcceptTask?
//
//    var tschessElementMatrix: [[TschessElement?]]?
//
//    var player: Player?
//
//    public func setPlayer(player: Player){
//        self.player = player
//    }
//
//    var opponent: Player?
//
//    public func setOpponent(opponent: Player){
//        self.opponent = opponent
//    }
//
//    var config: String?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tabBarMenu.delegate = self
//
//        configCollectionView.dataSource = self
//        configCollectionView.delegate = self
//
//        self.playActivityIndicator.isHidden = true
//
//        switch Int.random(in: 0 ... 2) {
//        case 0:
//            self.config = "config0"
//            self.tschessElementMatrix = self.player!.getConfig0()
//        case 1:
//            self.config = "config1"
//            self.tschessElementMatrix = self.player!.getConfig1()
//        default:
//            self.config = "config2"
//            self.tschessElementMatrix = self.player!.getConfig2()
//        }
//
//        self.opponentEloLabel.text = self.opponent!.getElo()
//        self.opponentRankLabel.text = self.opponent!.getRank()
//        let dataDecoded: Data = Data(base64Encoded: self.opponent!.getAvatar(), options: .ignoreUnknownCharacters)!
//        let decodedimage = UIImage(data: dataDecoded)
//        self.opponentImageView.image = decodedimage
//        self.opponentNameLabel.text = self.opponent!.getName()
//        self.letsPlayButton.isUserInteractionEnabled = true
//        self.letsPlayButton.alpha = 1.0
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
//        let decodedimage = UIImage(data: dataDecoded)
//        self.avatarImageView.image = decodedimage
//        self.rankLabel.text = self.player!.getRank()
//        self.tschxLabel.text = "₮\(self.player!.getTschx())"
//        self.usernameLabel.text = self.player!.getName()
//
//        self.configCollectionView.reloadData()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
//    }
//
//    private func generateWhite(inputRow: [TschessElement?]) -> [TschessElement?] {
//        var outputRow = [TschessElement?](repeating: nil, count: 8)
//        for i in (0 ..< 8) {
//            if(inputRow[i] != nil) {
//                outputRow[i] = self.gameAcceptTask!.generateTschessElementWhite(name: inputRow[i]!.name)
//            }
//        }
//        return outputRow
//    }
//
//    private func generateBlack(inputRow: [TschessElement?]) -> [TschessElement?] {
//        var outputRow = [TschessElement?](repeating: nil, count: 8)
//        for i in (0 ..< 8) {
//            if(inputRow[i] != nil) {
//                outputRow[i] = self.gameAcceptTask!.generateTschessElementBlack(name: inputRow[i]!.name)
//            }
//        }
//        return outputRow
//    }
//
//    @IBAction func letsPlayButtonClick(_ sender: Any) {
//        DispatchQueue.main.async() {
//            self.letsPlayButton.isHidden = true
//            self.playActivityIndicator.isHidden = false
//            self.playActivityIndicator.startAnimating()
//            self.playActivityIndicator.color = Colour().getRed()
//        }
//        let gameModel = Game(opponent: self.opponent!)
//        gameModel.setUsernameWhite(usernameWhite: self.player!.getName())
//        gameModel.setUsernameBlack(usernameBlack: self.opponent!.getName())
//        gameModel.setUsernameTurn(usernameTurn: self.player!.getName())
//        gameModel.setClock(clock: String(24))
//        gameModel.setLastMoveBlack(lastMoveBlack: self.dateTime.currentDateString())
//        gameModel.setLastMoveWhite(lastMoveWhite: "TBD")
//
//        gameModel.setMessageWhite(messageWhite: "NONE")
//        gameModel.setSeenMessageWhite(seenMessageWhite: false)
//        gameModel.setMessageWhitePosted(messageWhitePosted: "TBD")
//        gameModel.setMessageBlack(messageBlack: "NONE")
//        gameModel.setSeenMessageBlack(seenMessageBlack: false)
//        gameModel.setMessageBlackPosted(messageBlackPosted: "TBD")
//
//        var skin: String = "NONE"
//        if(self.player!.getSkin() != "NONE" || self.opponent!.getSkin() != "NONE"){
//            skin = "IAPETUS"
//        }
//        gameModel.setSkin(skin: skin)
//
//        self.gameAcceptTask = GameAcceptTask()
//        self.gameAcceptTask!.setPlayer(player: self.player!)
//        self.gameAcceptTask!.setGameModel(gameModel: gameModel)
//
//        var opponentElementMatrix: [[TschessElement?]]?
//        switch Int.random(in: 0 ... 2) {
//        case 0:
//            opponentElementMatrix = self.opponent!.getConfig0()
//        case 1:
//            opponentElementMatrix = self.opponent!.getConfig1()
//        default:
//            opponentElementMatrix = self.opponent!.getConfig2()
//        }
//        let gameMatrix: [[TschessElement?]] = [
//            self.generateBlack(inputRow: opponentElementMatrix![1]),
//            self.generateBlack(inputRow: opponentElementMatrix![0]),
//            [TschessElement?](repeating: nil, count: 8),
//            [TschessElement?](repeating: nil, count: 8),
//            [TschessElement?](repeating: nil, count: 8),
//            [TschessElement?](repeating: nil, count: 8),
//            self.generateWhite(inputRow: self.tschessElementMatrix![0]),
//            self.generateWhite(inputRow: self.tschessElementMatrix![1])]
//
//        let gamestate = Gamestate(gameModel: gameModel, tschessElementMatrix: gameMatrix)
//        gamestate.setPlayer(player: self.player!)
//
//        let updated = dateTime.currentDateString()
//        let requestPayload: [String: Any] = [
//            "white_uuid": self.player!.getId(),
//            "black_uuid": self.opponent!.getId(),
//            "state": MatrixSerializer().serialize(elementRepresentation: gameMatrix, orientationBlack: false),
//            "skin": skin,
//            "clock": 24,
//            "black_update": gameModel.getLastMoveBlack(),
//            "updated": updated,
//            "created": updated]
//
//        QuickTaskGame().execute(requestPayload: requestPayload) { (result) in
//            if(result == nil){
//                //print("FUCK")
//                return
//            }
//            gameModel.setIdentifier(identifier: result!)
//            gamestate.setGameModel(gameModel: gameModel)
//            gamestate.setPlayer(player: self.player!)
//            StoryboardSelector().chess(gameModel: gamestate.getGameModel(), player: gamestate.getPlayer(), gamestate: gamestate)
//            //            DispatchQueue.main.async() {
//            //                let storyboard: UIStoryboard = UIStoryboard(name: "ChessCalhoun", bundle: nil)
//            //                let viewController = storyboard.instantiateViewController(withIdentifier: "ChessCalhoun") as! Chess
//            //                viewController.setGamestate(gamestate: gamestate)
//            //                viewController.setGameModel(gameModel: gamestate.getGameModel())
//            //                viewController.setPlayer(player: gamestate.getPlayer())
//            //                UIApplication.shared.keyWindow?.rootViewController = viewController
//            //            }
//        }
//    }
//
//    @IBAction func backButtonClick(_ sender: Any) {
//        StoryboardSelector().home(player: self.player!)
//    }
//
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        switch item.tag {
//        default:
//            StoryboardSelector().home(player: self.player!)
//        }
//    }
//
//}
//
////MARK: - UICollectionViewDataSource
//extension Quick: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 16
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
//
//        if (indexPath.row % 2 == 0) {
//            if (indexPath.row / 8 == 0) {
//                cell.backgroundColor = UIColor(red: 220/255.0, green: 0/255.0, blue: 70/255.0, alpha: 0.65)
//            } else {
//                cell.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.88)
//            }
//        } else {
//            if (indexPath.row / 8 == 0) {
//                cell.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.88)
//            } else {
//                cell.backgroundColor = UIColor(red: 220/255.0, green: 0/255.0, blue: 70/255.0, alpha: 0.65)
//            }
//        }
//
//        let x = indexPath.row / 8
//        let y = indexPath.row % 8
//
//        if(self.tschessElementMatrix![x][y] != nil){
//            cell.imageView.image = self.tschessElementMatrix![x][y]!.getImageDefault()
//        } else {
//            cell.imageView.image = nil
//        }
//        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
//        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
//        return cell
//    }
//
//}
//
//
////MARK: - UICollectionViewDelegateFlowLayout
//extension Quick: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellsAcross: CGFloat = 8
//        let dim = collectionView.frame.width / cellsAcross
//        return CGSize(width: dim, height: dim)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}

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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var skinSelectionPicker: UIPickerView!
    
    var player: Player?
    var gameModel: Game?
    
    var pickerSelectionTimeLimit: String = "post"
    var pickerOptionsTimeLimit: [String]  = ["post", "blitz"]
    
    var pickerSelectionConfiguration: String = "default"
    var pickerOptionsSkin: [String] = ["default", "iapetus"]
    
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
        pickerSelectionConfiguration = self.skinList![row].getName()
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
        self.usernameLabel.text = self.opponent!.getName()
        
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
        //
        
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
        print("lolol")
        let storyboard: UIStoryboard = UIStoryboard(name: "Edit", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Edit") as! Edit
        viewController.setPlayer(player: self.player!)
        let gameModel: Game = Game(opponent: self.opponent!)
        viewController.setGameModel(gameModel: gameModel)
        viewController.setTitleText(titleText: "quick play")
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
        homeViewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            print("0")
            //StoryboardSelector().leader(player: self.player!)
        default:
            StoryboardSelector().home(player: self.player!)
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

