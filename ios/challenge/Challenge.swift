//
//  Challenge.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Challenge: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITabBarDelegate, UIGestureRecognizerDelegate {
    
    var BACK: String?
    
    public func setBACK(BACK: String){
        self.BACK = BACK
    }
    
    var activateBackConfig: Int?
    
    public func setActivateBackConfig(activateBackConfig: Int){
        self.activateBackConfig = activateBackConfig
    }
    
    func generateTraditionalMatrix() -> [[Piece]] {
        
        let row0 = [Pawn(), Pawn(), Pawn(), Pawn(), Pawn(), Pawn(), Pawn(), Pawn()]
        let row1 = [Rook(), Knight(), Bishop(), Queen(), King(), Bishop(), Knight(), Rook()]
        return [row0, row1]
    }
    
    @IBOutlet weak var configLabelView: UIView!
    @IBOutlet weak var traditionalLabel: UILabel!
    
    @IBOutlet weak var configCollectionView: BoardView!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var rankDateLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let reuseIdentifier = "square"
    
    @IBOutlet weak var activeConfigNumber: UILabel!
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    @IBOutlet weak var indicatorLabel0: UILabel!
    @IBOutlet weak var indicatorLabel1: UILabel!
    @IBOutlet weak var indicatorLabel2: UILabel!
    @IBOutlet weak var indicatorLabelS: UILabel!
    
    func renderConfig0() {
        self.tschessElementMatrix = self.playerSelf!.getConfig(index: 0)
        
        self.activeConfigNumber.text = "0̸"
        self.configCollectionView.reloadData()
        
        self.configLabelView.isHidden = false
        self.traditionalLabel.isHidden = true
        
        let activeConfigFull = NSMutableAttributedString()
        activeConfigFull.append(self.alphaDotFull!)
        let activeConfigNull = NSMutableAttributedString()
        activeConfigNull.append(self.alphaDotHalf!)
        
        self.indicatorLabelS.attributedText = activeConfigFull
        self.indicatorLabel2.attributedText = activeConfigNull
        self.indicatorLabel1.attributedText = activeConfigNull
        self.indicatorLabel0.attributedText = activeConfigNull
    }
    
    func renderConfig1() {
        self.tschessElementMatrix = self.playerSelf!.getConfig(index: 1)
        
        self.activeConfigNumber.text = "1"
        self.configCollectionView.reloadData()
        
        self.configLabelView.isHidden = false
        self.traditionalLabel.isHidden = true
        
        let activeConfigFull = NSMutableAttributedString()
        activeConfigFull.append(self.alphaDotFull!)
        let activeConfigNull = NSMutableAttributedString()
        activeConfigNull.append(self.alphaDotHalf!)
        
        self.indicatorLabelS.attributedText = activeConfigNull
        self.indicatorLabel2.attributedText = activeConfigFull
        self.indicatorLabel1.attributedText = activeConfigNull
        self.indicatorLabel0.attributedText = activeConfigNull
    }
    
    func renderConfig2() {
        self.tschessElementMatrix = self.playerSelf!.getConfig(index: 2)
        
        self.activeConfigNumber.text = "2"
        self.configCollectionView.reloadData()
        
        self.configLabelView.isHidden = false
        self.traditionalLabel.isHidden = true
        
        let activeConfigFull = NSMutableAttributedString()
        activeConfigFull.append(self.alphaDotFull!)
        let activeConfigNull = NSMutableAttributedString()
        activeConfigNull.append(self.alphaDotHalf!)
        
        self.indicatorLabelS.attributedText = activeConfigNull
        self.indicatorLabel2.attributedText = activeConfigNull
        self.indicatorLabel1.attributedText = activeConfigFull
        self.indicatorLabel0.attributedText = activeConfigNull
    }
    
    func renderConfigS() {
        self.tschessElementMatrix = self.generateTraditionalMatrix()
        self.configCollectionView.reloadData()
        
        self.configLabelView.isHidden = true
        self.traditionalLabel.isHidden = false
        
        let activeConfigFull = NSMutableAttributedString()
        activeConfigFull.append(self.alphaDotFull!)
        let activeConfigNull = NSMutableAttributedString()
        activeConfigNull.append(self.alphaDotHalf!)
        
        self.indicatorLabelS.attributedText = activeConfigNull
        self.indicatorLabel2.attributedText = activeConfigNull
        self.indicatorLabel1.attributedText = activeConfigNull
        self.indicatorLabel0.attributedText = activeConfigFull
    }
    
    var tschessElementMatrix: [[Piece?]]?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.configCollectionView.bounces = false
        self.configCollectionView.alwaysBounceVertical = false
        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
    }
    
    let DATE_TIME: DateTime = DateTime()
    
    //MARK: Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var skinSelectionPicker: UIPickerView!
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
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
    
    var attributeAlphaDotFull: [NSAttributedString.Key: NSObject]?
    var attributeAlphaDotHalf: [NSAttributedString.Key: NSObject]?
    
    var alphaDotFull: NSMutableAttributedString?
    var alphaDotHalf: NSMutableAttributedString?
    
    public func renderHeaderOther() {
        self.avatarImageView.image = self.playerOther!.getImageAvatar()
        self.usernameLabel.text = self.playerOther!.username
        self.eloLabel.text = self.playerOther!.getLabelTextElo()
        self.rankLabel.text = self.playerOther!.getLabelTextRank()
        self.rankDateLabel.text = self.playerOther!.getLabelTextDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarMenu.delegate = self
        
        self.attributeAlphaDotFull = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)]
        self.attributeAlphaDotHalf = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)]
        
        self.alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        self.alphaDotHalf = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotHalf!)
        
        //
        self.renderHeaderOther()
        //
        
        self.configCollectionView.delegate = self
        self.configCollectionView.dataSource = self
        
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = false
        
        
        
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
        
        self.skinList = Array(arrayLiteral: iapetus, calypso, hyperion, neptune)
        
        if(self.activateBackConfig != nil){
            switch self.activateBackConfig! {
            case 1:
                self.renderConfig1()
                return
            case 2:
                self.renderConfig2()
                return
            default:
                self.renderConfig0()
                return
            }
        }
        switch Int.random(in: 0 ... 3) {
        case 0:
            self.renderConfig0()
        case 1:
            self.renderConfig1()
        case 2:
            self.renderConfig2()
        default:
            self.renderConfigS()
        }
    }
    
    var skinList: Array<EntitySkin>?
    
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
    
    func flash() {
        let flashFrame = UIView(frame: self.configCollectionView.bounds)
        flashFrame.backgroundColor = UIColor.white
        flashFrame.alpha = 0.7
        self.configCollectionView.addSubview(flashFrame)
        UIView.animate(withDuration: 0.1, animations: {
            flashFrame.alpha = 0.0
        }, completion: {(finished:Bool) in
            flashFrame.removeFromSuperview()
        })
    }
    
    @objc func renderElementCollectionView() {
        if(self.traditionalLabel.isHidden == false){
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            self.flash()
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "EditOther", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditOther") as! EditOther
        viewController.setTitleText(titleText: "new challenge")
        viewController.setActiveConfigNumber(activeConfigNumber: 0)
        let numberString: String = self.activeConfigNumber.text!
        if(numberString == "1"){
            viewController.setActiveConfigNumber(activeConfigNumber: 1)
        }
        if(numberString == "2") {
            viewController.setActiveConfigNumber(activeConfigNumber: 2)
        }
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
                if(self.traditionalLabel.isHidden == false){
                    self.renderConfig2()
                    return
                }
                if(activeConfigNumber.text == "2"){
                    self.renderConfig1()
                    return
                }
                if(activeConfigNumber.text == "1"){
                    self.renderConfig0()
                    return
                }
                //                if(activeConfigNumber.text == "0̸"){
                //                     self.renderConfigS()
                //                    return
            //                }
            case UISwipeGestureRecognizer.Direction.left:
                if(activeConfigNumber.text == "0̸"){
                    self.renderConfig1()
                    return
                }
                if(activeConfigNumber.text == "1"){
                    self.renderConfig2()
                    return
                }
                if(activeConfigNumber.text == "2"){
                    self.renderConfigS()
                    return
                }
                //                if(self.configLabelView.isHidden == false){
                //                    self.configLabelView.isHidden = true
                //                    self.traditionalLabel.isHidden = false
                //                    self.renderConfig0()
                //                    return
            //                }
            default:
                break
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        if(self.BACK == "HOME"){
            DispatchQueue.main.async {
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
                homeViewController.setPlayer(player: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = homeViewController
            }
            return
        }
        if(self.BACK == "HISTORIC"){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Historic", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Historic") as! Historic
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Other", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Other") as! Other
        viewController.setPlayerSelf(playerSelf: self.playerSelf!)
        viewController.setPlayerOther(playerOther: self.playerOther!)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default: //1
            
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            let requestPayload: [String: Any] = [
                "player_self": self.playerSelf!.id,
                "player_oppo": self.playerOther!.id,
                "skin": "DEFAULT",
                "config": 0]
            
            RequestChallenge().execute(requestPayload: requestPayload) { (result) in
                
                DispatchQueue.main.async {
                    let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
                    homeViewController.setPlayer(player: self.playerSelf!)
                    UIApplication.shared.keyWindow?.rootViewController = homeViewController
                }
            }
        }
    }
}



//MARK: - UICollectionViewDataSource
extension Challenge: UICollectionViewDataSource {
    
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
extension Challenge: UICollectionViewDelegateFlowLayout {
    
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
