//
//  Ack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Ack: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate {
    
    var menuList: [EntityGame]?
    var homeList: [EntityPlayer]?
    
    @IBOutlet weak var traditionalLabel: UILabel!
    @IBOutlet weak var configLabelView: UIView!
    
    /* - * - */
    
    var selection: Int? = nil  //var configActive: Int = 0
    
    public func setSelection(selection: Int){
        self.selection = selection
    }
    
    var BACK: String?
    
    public func setBACK(BACK: String){
        self.BACK = BACK
    }
    
    /* - * - */
    
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
    
    @IBOutlet weak var contentView: UIView!
    
    //@IBOutlet var splitViewHeight0: NSLayoutConstraint!
    //@IBOutlet var splitViewHeight1: NSLayoutConstraint! //strong
    
   
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    @IBOutlet weak var indicatorLabel0: UILabel!
    @IBOutlet weak var indicatorLabel1: UILabel!
    @IBOutlet weak var indicatorLabel2: UILabel!
    @IBOutlet weak var indicatorLabelS: UILabel!
    
    func renderConfig0() {
        self.selection = 0
        
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
        self.selection = 1
        
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
        self.selection = 2
        
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
        self.selection = 3
        
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
    
    func generateTraditionalMatrix() -> [[Piece]] {
        let row0 = [Pawn(), Pawn(), Pawn(), Pawn(), Pawn(), Pawn(), Pawn(), Pawn()]
        let row1 = [Rook(), Knight(), Bishop(), Queen(), King(), Bishop(), Knight(), Rook()]
        return [row0, row1]
    }
    
    var tschessElementMatrix: [[Piece?]]?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.configCollectionView.bounces = false
        self.configCollectionView.alwaysBounceVertical = false
        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.configCollectionView.reloadData()
        //self.configCollectionView.isHidden = false
        self.configCollectionView.layoutSubviews()
        self.configCollectionView.isHidden = false
    }
    
    //MARK: Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
 
    

    

    
 
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerOther!.getImageAvatar()
        self.usernameLabel.text = self.playerOther!.username
        self.eloLabel.text = self.playerOther!.getLabelTextElo()
        self.rankLabel.text = self.playerOther!.getLabelTextRank()
        self.rankDateLabel.text = self.playerOther!.getLabelTextDate()
    }
    
    var attributeAlphaDotFull: [NSAttributedString.Key: NSObject]?
    var attributeAlphaDotHalf: [NSAttributedString.Key: NSObject]?
    
    var alphaDotFull: NSMutableAttributedString?
    var alphaDotHalf: NSMutableAttributedString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarMenu.delegate = self
        
        self.renderHeader()
        
        self.configCollectionView.isHidden = true
        
        self.configCollectionView.delegate = self
        self.configCollectionView.dataSource = self
        
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = false
        
        self.attributeAlphaDotFull = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)]
        self.attributeAlphaDotHalf = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)]
        
        self.alphaDotFull = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotFull!)
        self.alphaDotHalf = NSMutableAttributedString(string: "•", attributes: self.attributeAlphaDotHalf!)
        
        self.activityIndicator.isHidden = true
        
     
     
        
        if(self.selection == nil){
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
            return // !!! //
        }
        switch self.selection! {
        case 1:
            self.renderConfig1()
        case 2:
            self.renderConfig2()
        default:
            self.renderConfig0()
        }
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
        
        
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
        if(self.selection! == 0){

            DispatchQueue.main.async() {
                self.navigationController?.pushViewController(EditOther.create(
                playerSelf: self.playerSelf!,
                playerOther: self.playerOther!,
                select: 0,
                back: "ACK",
                height: UIScreen.main.bounds.height,
                game: self.gameTschess!), animated: false)
            }
            
            return
        }
        if(self.selection! == 1){
            DispatchQueue.main.async() {
            self.navigationController?.pushViewController(EditOther.create(
                playerSelf: self.playerSelf!,
                 playerOther: self.playerOther!,
                select: 1,
                back: "ACK",
                height: UIScreen.main.bounds.height,
                game: self.gameTschess!), animated: false)
            }
            return
        }
        DispatchQueue.main.async() {
            self.navigationController?.pushViewController(EditOther.create(
            playerSelf: self.playerSelf!,
             playerOther: self.playerOther!,
            select: 2,
            back: "ACK",
            height: UIScreen.main.bounds.height,
            game: self.gameTschess!), animated: false)
        }
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
            default:
                break
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
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
        let dim = UIScreen.main.bounds.width / cellsAcross
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
            case 0:
            self.backButtonClick("")
        default:
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            let id_game = self.gameTschess!.id
            let id_player = self.playerSelf!.id
       
            
            let requestPayload: [String: Any] = [
                "id_game": id_game,
                "id_self": id_player,
                "config": self.selection!]
            
            RequestAck().execute(requestPayload: requestPayload) { (result) in
                let game: EntityGame = ParseGame().execute(json: result)
                DispatchQueue.main.async {
                    let height: CGFloat = UIScreen.main.bounds.height
                    let playerOther: EntityPlayer = game.getPlayerOther(username: self.playerSelf!.username)
                    if(height.isLess(than: 750)){
                        let storyboard: UIStoryboard = UIStoryboard(name: "dTschessL", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessL") as! Tschess
                        viewController.setOther(player: playerOther)
                        viewController.setSelf(player: self.playerSelf!)
                        viewController.setGame(game: game)
                        self.navigationController?.pushViewController(viewController, animated: false)
                        guard let navigationController = self.navigationController else { return }
                        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
                        navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
                        self.navigationController?.viewControllers = navigationArray
                        return
                    }
                    let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
                    viewController.setOther(player: playerOther)
                    viewController.setSelf(player: self.playerSelf!)
                    viewController.setGame(game: game)
                    self.navigationController?.pushViewController(viewController, animated: false)
                    guard let navigationController = self.navigationController else { return }
                    var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
                    navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
                    self.navigationController?.viewControllers = navigationArray
                }
            }
        }
    }
}
