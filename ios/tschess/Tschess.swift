//
//  Tschess.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Tschess: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    var gameTschess: EntityGame?
    
    public func setGameTschess(gameTschess: EntityGame) {
        self.gameTschess = gameTschess
    }
    
    let DATE_TIME: DateTime = DateTime()
    
    private func updateCountdownTimer() {
        let dateUpdate: Date = self.DATE_TIME.toFormatDate(string: self.gameTschess!.updated)
        let dateActual: Date = self.DATE_TIME.currentDate()
        let intervalDifference: TimeInterval = dateActual.timeIntervalSince(dateUpdate)
        let intervalStandard: TimeInterval = Double(24) * 60 * 60
        let timeRemaining = intervalStandard - intervalDifference
        self.counter = String(timeRemaining)
    }
    
    func renderCountdownFormat(_ countdownFormat: String) -> TimeInterval {
        var interval: Double = 0
        let componentValueSet = countdownFormat.components(separatedBy: ":")
        for (index, component) in componentValueSet.reversed().enumerated() {
            interval += (Double(component) ?? 0) * pow(Double(60), Double(index))
        }
        return interval
    }
    
    @objc func updateCounter() {
        let countActual = self.renderCountdownFormat(self.counter!) - TimeInterval(1.0)
        
        let sec = Int(countActual.truncatingRemainder(dividingBy: 60))
        let min = Int(countActual.truncatingRemainder(dividingBy: 3600) / 60)
        let hour = Int(countActual / 3600)
        
        if(self.timerLabel.isHidden){
            self.timerLabel.isHidden = false
        }
        self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleViewImage: UIImageView!
    @IBOutlet weak var titleViewLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewImage: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankLabelDate: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewImage: UIImageView!
    @IBOutlet weak var contentViewLabel: UILabel!
    
    @IBOutlet weak var collectionView: BoardView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerImage: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var turnaryLabel: UILabel!
    
    @IBOutlet var tabBarMenu: UITabBar!
    
    var pollingTimer: Timer?
    var counterTimer: Timer?
    
    var counter: String?
    
    var transitioner: Transitioner?
    
    var castling: Castle?
    var pawnPromotion: Promotion?
    var pawnPromotionStoryboard: UIStoryboard?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.counter = "00:00:00" //
        
        self.castling = Castle()
        
        self.pawnPromotionStoryboard = UIStoryboard(name: "Promotion", bundle: nil)
        self.pawnPromotion = pawnPromotionStoryboard!.instantiateViewController(withIdentifier: "Promotion") as? Promotion
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
        self.collectionView.isHidden = false
        self.activityIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.tabBarMenu.delegate = self
        
        self.processDrawProposal()
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerOther!.getImageAvatar()
        self.usernameLabel.text = self.playerOther!.username
        self.eloLabel.text = self.playerOther!.getLabelTextElo()
        self.rankLabel.text = self.playerOther!.getLabelTextRank()
        self.rankLabelDate.text = self.playerOther!.getLabelTextDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isHidden = true
        
        self.turnaryLabel.isHidden = true
        self.setTurn()
        
        self.timerLabel.isHidden = true
        self.contentViewLabel.isHidden = true
        
        self.renderHeader()
        self.startTimers()
        
        self.transitioner = Transitioner(white: self.gameTschess!.getWhite(username: self.playerSelf!.username), collectionView: collectionView)
        self.castling!.setTransitioner(transitioner: transitioner!)
        self.pawnPromotion!.setTransitioner(transitioner: transitioner!)
        self.pawnPromotion!.setChess(chess: self)
        
        self.tschessElementMatrix = self.gameTschess!.getStateClient(username: self.playerSelf!.username)
    }
    
    var tschessElementMatrix: [[Piece?]]?
    
    var turn: Bool = false
    
    private func setTurn() {
        if(self.turnaryLabel.isHidden){
           self.turnaryLabel.isHidden = false
        }
        if(self.gameTschess!.getTurn(username: self.playerSelf!.username)){
            self.turn = true
            self.turnaryLabel.text = "\(self.playerSelf!.username) to move"
            return
        }
        self.turn = false
        self.turnaryLabel.text = "\(self.playerOther!.username) to move"
    }
    
    func flash() {
        let flashFrame = UIView(frame: collectionView.bounds)
        flashFrame.backgroundColor = UIColor.white
        flashFrame.alpha = 0.7
        self.collectionView.addSubview(flashFrame)
        UIView.animate(withDuration: 0.1, animations: {
            flashFrame.alpha = 0.0
        }, completion: {(finished:Bool) in
            flashFrame.removeFromSuperview()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    private func assignCellBackgroundColor(index: Int) -> UIColor {
        if (index % 2 == 0) {
            if ((index / 8) % 2 == 0) {
                return UIColor.purple
            }
            return UIColor.brown
        }
        if ((index / 8) % 2 == 0) {
            return UIColor.brown
        }
        return UIColor.purple
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 8
        let dim = collectionView.frame.width / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
    
    func startTimers() {
        guard self.pollingTimer == nil else {
            return
        }
        self.pollingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pollingTask), userInfo: nil, repeats: true)
        guard self.counterTimer == nil else {
            return
        }
        self.counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func stopTimers() {
        self.pollingTimer?.invalidate()
        self.pollingTimer = nil
        self.counterTimer?.invalidate()
        self.counterTimer = nil
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.stopTimers()
        DispatchQueue.main.async() {
            let storyboard: UIStoryboard = UIStoryboard(name: "Actual", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Actual") as! Actual
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    func pawnPromotion(proposed: [Int]) {
        DispatchQueue.main.async {
            self.pawnPromotion!.setProposed(proposed: proposed)
            self.present(self.pawnPromotion!, animated: false, completion: nil)
        }
    }
    
    private func highlightLastMoveCoords(indexPath: IndexPath, cell: SquareCell) -> SquareCell {
        if(!self.turn){
            cell.layer.borderWidth = 0
            return cell
        }
        let white: Bool = self.gameTschess!.getWhite(username: self.playerSelf!.username)
        
        let x: Int = white ? indexPath.item / 8 : 7 - (indexPath.item / 8)
        let y: Int = white ? indexPath.item % 8 : 7 - (indexPath.item % 8)
        let sq: [Int] = [x,y]
        
        let highlight: String = self.gameTschess!.highlight
        if(highlight == "TBD"){
            cell.layer.borderWidth = 0
            return cell
        }
        let coords = Array(highlight)
        
        let h0a: Int = Int(String(coords[0]))!
        let h0b: Int = Int(String(coords[1]))!
        let h0: [Int] = [h0a,h0b]
        if(sq == h0){
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = UIColor.magenta.cgColor
            return cell
        }
        let h1a: Int = Int(String(coords[2]))!
        let h1b: Int = Int(String(coords[3]))!
        let h1: [Int] = [h1a,h1b]
        if(sq == h1){
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = UIColor.magenta.cgColor
            return cell
        }
        cell.layer.borderWidth = 0
        return cell
    }
    
    func resolveGameTimeout() {
        if(self.gameTschess!.status == "RESOLVED"){
            self.titleViewLabel.text = "game over"
            self.contentViewLabel.isHidden = false
            self.turnaryLabel.isHidden = true
            self.timerLabel.isHidden = true
            self.stopTimers()
            
            if(self.gameTschess!.winner == "WHITE"){
                if(self.gameTschess!.getWhite(username: self.playerSelf!.username)){
                    self.contentViewLabel.text = "you win"
                    return
                }
                self.contentViewLabel.text = "you lose"
                return
            }
            if(self.gameTschess!.getWhite(username: self.playerSelf!.username)){
                self.contentViewLabel.text = "you lose"
                return
            }
            self.contentViewLabel.text = "you win"
        }
    }
    
    private func processDrawProposal() {
        if(self.gameTschess!.outcome == "TBD"){
            self.contentViewLabel.isHidden = true
            return
        }
        if(self.gameTschess!.outcome == "PENDING"){
            if(!self.turn){
                self.contentViewLabel.isHidden = false
                self.timerLabel.isHidden = false
                self.contentViewLabel.text = "proposal pending"
                self.turnaryLabel.text = "\(self.playerOther!.username) to respond"
                return
            }
            self.contentViewLabel.isHidden = false
            self.timerLabel.isHidden = false
            self.contentViewLabel.text = "proposal pending"
            self.turnaryLabel.text = "\(self.playerSelf!.username) to respond"
            
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Evaluate", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Evaluate") as! Evaluate
                viewController.modalTransitionStyle = .crossDissolve
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.gameTschess!.getPlayerOther(username: self.playerSelf!.username))
                viewController.setGameTschess(gameTschess: self.gameTschess!)
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: polling task
    
    @objc func pollingTask() {
        GameRequest().execute(id: self.gameTschess!.id) { (game) in
            //print("            game!.updated: \(game!.updated)")
            //print("self.gameTschess!.updated: \(self.gameTschess!.updated)")
            let dateSEV: Date = self.DATE_TIME.toFormatDate(string: game!.updated)              //A
            let dateLOC: Date = self.DATE_TIME.toFormatDate(string: self.gameTschess!.updated)  //B
            switch dateSEV.compare(dateLOC) {
            case .orderedAscending:
                //print("Date A is earlier than date B")
                return
            case .orderedSame:
                //print("The two dates are the same")
                return
            case .orderedDescending:
                //print("Date A is later than date B")
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.setGameTschess(gameTschess: game!)
                    self.setTurn()
                    self.tschessElementMatrix = game!.getStateClient(username: self.playerSelf!.username)
                    self.collectionView.reloadData()
                    self.processDrawProposal()
                    self.resolveGameTimeout()
                }
            }
        }
    }
    
    // MARK: prime mover
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(!self.turn){
            self.flash()
            return
        }
        let x = indexPath.item / 8
        let y = indexPath.item % 8
        print("x: \(x), y: \(y)")
        
        //let coordinate = self.transitioner!.getCoordinate()
        //        if(coordinate != nil){
        //            let pawnPromotion = self.pawnPromotion!.evaluate(coordinate: coordinate!, proposed: [x,y])
        //            if(pawnPromotion){
        //                self.transitioner!.clearCoordinate()
        //                //self.gamestate!.setHighlight(coords: [x,y,coordinate![0],coordinate![1]])
        //                self.pawnPromotion(proposed: [x,y])
        //                return
        //            }
        //            let castling = self.castling!.execute(coordinate: coordinate!, proposed: [x,y], gamestate: self.gamestate!)
        //            if(castling){
        //                self.renderEffect()
        //                return
        //            }
        //            let enPassant = EnPassant().evaluate(coordinate: coordinate!, proposed: [x,y], gamestate: Gamestate())
        //            if(enPassant){
        //                self.renderEffect()
        //                return
        //            }
        //            let landmine = Landmine().detonate(coordinate: coordinate!, proposed: [x,y], gamestate: Gamestate())
        //            if(landmine){
        //                self.renderEffect()
        //                return
        //            }
        //            let hopped = Hopped().evaluate(coordinate: coordinate!, proposed: [x,y], gamestate: Gamestate())
        //            if(hopped){
        //                self.renderEffect()
        //                return
        //            }
        //        }
        //        self.transitioner!.evaluateInput(coordinate: [x,y], gamestate: Gamestate())
        //        self.indicatorLabelUpdate()
        //        self.collectionView.reloadData()
        let coordinate = self.transitioner!.getCoordinate()
        if(coordinate != nil){
            if(self.transitioner!.validMove(propose: [x,y], state0: self.tschessElementMatrix!)){
                self.tschessElementMatrix = self.transitioner!.deselectHighlight(state0: self.tschessElementMatrix!)
                let stateX: [[Piece?]] = self.transitioner!.executeMove(propose: [x,y], state0: self.tschessElementMatrix!)
                let stateUpdate = SerializerState(white: self.gameTschess!.getWhite(username: self.playerSelf!.username)).renderServer(state: stateX)
                
                let white: Bool = self.gameTschess!.getWhite(username: self.playerSelf!.username)
                
                let hx: Int = white ? x : 7 - x
                let hy: Int = white ? y : 7 - y
                let h0: Int = white ? coordinate![0] : 7 - coordinate![0]
                let h1: Int = white ? coordinate![1] : 7 - coordinate![1]
                let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
                
                let requestPayload: [String: Any] = ["id_game": self.gameTschess!.id, "state": stateUpdate, "highlight": highlight]
                DispatchQueue.main.async() {
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                }
                GameUpdate().success(requestPayload: requestPayload) { (success) in
                    if(!success){
                        //error
                    }
                    self.transitioner!.clearCoordinate()
                }
                return
            }
        }
        let state0 = self.gameTschess!.getStateClient(username: self.playerSelf!.username)
        self.tschessElementMatrix = self.transitioner!.evaluateHighlightSelection(coordinate: [x,y], state0: state0)
        self.collectionView.reloadData()
    }
    
    private func assignCellTschessElement(indexPath: IndexPath) -> UIImage? {
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        if(self.tschessElementMatrix![x][y] != nil){
            return self.tschessElementMatrix![x][y]!.getImageVisible()
        }
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! SquareCell
        cell.backgroundColor = assignCellBackgroundColor(index: indexPath.row)
        cell.imageView.image = self.assignCellTschessElement(indexPath: indexPath)
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return self.highlightLastMoveCoords(indexPath: indexPath, cell: cell)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionViewHeight.constant = collectionView.contentSize.height
        self.updateCountdownTimer()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "DrawResign", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "DrawResign") as! DrawResign
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.gameTschess!.getPlayerOther(username: self.playerSelf!.username))
                viewController.setGameTschess(gameTschess: self.gameTschess!)
                self.tabBarMenu.selectedItem = nil
                self.present(viewController, animated: true, completion: nil)
            }
        default: //0
            self.stopTimers()
            DispatchQueue.main.async() {
                let storyboard: UIStoryboard = UIStoryboard(name: "Actual", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Actual") as! Actual
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
    }
    
}
