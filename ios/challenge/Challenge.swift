//
//  Challenge.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Challenge:
                    UIViewController,
                    UIPickerViewDataSource,
                    UIPickerViewDelegate,
                    UITabBarDelegate,
                    UIGestureRecognizerDelegate {
    
    //@IBOutlet weak var configCollectionView: DynamicCollectionView!
    @IBOutlet weak var configCollectionView: DynamicCollectionView!
    //@IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    
    
    
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
    //@IBOutlet weak var issueChallengeButton: UIButton!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    //@IBOutlet weak var timeLimitPickerView: UIPickerView!
    //@IBOutlet weak var configurationPickerView: UIPickerView!
    
    var player: Player?
    var gameModel: Game?
    
    //var gameMenuAdapter: ChallengeMenuTable?
    
    var pickerSelectionTimeLimit: String = "post"
    var pickerOptionsTimeLimit: [String]  = ["post", "blitz"]
    
    var pickerSelectionConfiguration: String = "config. 0̸" //config. 0̸ will be the standard config... maybe
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
       
        tabBarMenu.delegate = self
        
        let dataDecoded: Data = Data(base64Encoded: gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = gameModel!.getOpponentRank()
        self.usernameLabel.text = gameModel!.getOpponentName()
        
        self.tschessElementMatrix = self.player!.getConfig0()
        
        
        self.configCollectionView.delegate = self
        self.configCollectionView.dataSource = self
        
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = false
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
        //let gameModel = self.gameMenuAdapter!.getGameMenuTableList()[gameMenuSelectionIndex]
        
        //let skin = self.gameMenuAdapter!.getGameMenuTableList()[gameMenuSelectionIndex].getSkin()
        //print("XXXXX: \(skin)")
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        //StoryboardSelector().leader(player: self.player!)
    }
    
    func stayHandler(action: UIAlertAction) {
        //StoryboardSelector().challenge(player: self.player!, gameModel: self.gameModel!)
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
extension Challenge: UICollectionViewDataSource {
    
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



extension Challenge: UICollectionViewDelegate {
    
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
}

