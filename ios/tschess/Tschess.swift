//
//  Tschess.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Tschess: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    // MARK: MEMBER VARIABLE
    
    var playerSelf: EntityPlayer?
    
    func setSelf(player: EntityPlayer){
        self.playerSelf = player
    }
    
    var playerOther: EntityPlayer?
    
    func setOther(player: EntityPlayer){
        self.playerOther = player
    }
    
    var game: EntityGame?
    
    func setGame(game: EntityGame) {
        self.game = game
    }
    
    // MARK: PRIVATE FUNC
    
    private func updateCountdown() {
        let dateUpdate: Date = self.dateTime.toFormatDate(string: self.game!.updated)
        let dateActual: Date = self.dateTime.currentDate()
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
    
    // MARK: @OBJC FUNC
    
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
    @IBOutlet weak var titleViewLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankLabelDate: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView! //strong
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var collectionView: BoardView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var turnaryLabel: UILabel!
    
    @IBOutlet var tabBarMenu: UITabBar!
    
    var pollingTimer: Timer?
    var counterTimer: Timer?
    
    var counter: String?
    
     let dateTime: DateTime = DateTime()
    
    var transitioner: Transitioner?
    
    var passant: Passant?
    var castling: Castle?
    var pawnPromotion: Promotion?
    var pawnPromotionStoryboard: UIStoryboard?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.counter = "00:00:00" //
        
        self.pawnPromotionStoryboard = UIStoryboard(name: "Promotion", bundle: nil)
        self.pawnPromotion = pawnPromotionStoryboard!.instantiateViewController(withIdentifier: "Promotion") as? Promotion
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
        self.collectionView.isHidden = false
        self.activityIndicator.isHidden = true
        
        self.evalCheckMate() //draw/resign also?
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
        self.notificationLabel.isHidden = true
        
        self.renderHeader()
        self.startTimers()
        
        self.transitioner = Transitioner(white: self.game!.getWhite(username: self.playerSelf!.username), collectionView: collectionView)
        
        self.pawnPromotion!.setTransitioner(transitioner: transitioner!)
        self.pawnPromotion!.setChess(chess: self)
        
        self.tschessElementMatrix = self.game!.getStateClient(username: self.playerSelf!.username)
    }
    
    var tschessElementMatrix: [[Piece?]]?
    
    var turn: Bool = false
    
    private func setTurn() {
        if(self.turnaryLabel.isHidden){
            self.turnaryLabel.isHidden = false
        }
        if(self.game!.getTurn(username: self.playerSelf!.username)){
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
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectActual().execute(player: self.playerSelf!, height: height)
        }
    }
    
    private func highlightLastMoveCoords(indexPath: IndexPath, cell: SquareCell) -> SquareCell {
        if(self.game!.outcome == "LANDMINE"){
            DispatchQueue.main.async {
                self.notificationLabel.isHidden = false
                self.notificationLabel.text = ".:*~ poison pawn ~*:."
            }
            
            let white: Bool = self.game!.getWhite(username: self.playerSelf!.username)
            
            let x: Int = white ? indexPath.item / 8 : 7 - (indexPath.item / 8)
            let y: Int = white ? indexPath.item % 8 : 7 - (indexPath.item % 8)
            let sq: [Int] = [x,y]
            
            let highlight: String = self.game!.highlight
            if(highlight == "TBD"){
                cell.layer.borderWidth = 0
                return cell
            }
            let coords = Array(highlight)
            
            let h0a: Int = Int(String(coords[0]))!
            let h0b: Int = Int(String(coords[1]))!
            let h0: [Int] = [h0a,h0b]
            if(sq == h0){
                
                if(!self.turn){
                    if(white){
                        cell.backgroundColor = UIColor.black
                    } else {
                        cell.backgroundColor = UIColor.white
                    }
                    //cell.layer.borderColor = UIColor.black.cgColor
                } else {
                    cell.layer.borderWidth = 1.5
                   cell.layer.borderColor = UIColor.magenta.cgColor
                }
                return cell
            }
            let h1a: Int = Int(String(coords[2]))!
            let h1b: Int = Int(String(coords[3]))!
            let h1: [Int] = [h1a,h1b]
            if(sq == h1){
                
                if(!self.turn){
                    if(white){
                        cell.backgroundColor = UIColor.black
                    } else {
                        cell.backgroundColor = UIColor.white
                    }
                    //cell.layer.borderColor = UIColor.black.cgColor
                } else {
                    cell.layer.borderWidth = 1.5
                   cell.layer.borderColor = UIColor.magenta.cgColor
                }
                return cell
            }
            cell.layer.borderWidth = 0
            return cell
        }
        if(!self.turn){
            cell.layer.borderWidth = 0
            return cell
        }
        let white: Bool = self.game!.getWhite(username: self.playerSelf!.username)
        
        let x: Int = white ? indexPath.item / 8 : 7 - (indexPath.item / 8)
        let y: Int = white ? indexPath.item % 8 : 7 - (indexPath.item % 8)
        let sq: [Int] = [x,y]
        
        let highlight: String = self.game!.highlight
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
        if(self.game!.status == "RESOLVED"){
            DispatchQueue.main.async {
                self.titleViewLabel.text = "game over"
                self.notificationLabel.isHidden = false
                self.turnaryLabel.isHidden = true
                self.timerLabel.isHidden = true
            }
            self.stopTimers()
            if(self.game!.outcome == "DRAW"){
                DispatchQueue.main.async {
                    self.notificationLabel.text = "draw"
                    self.titleViewLabel.text = "game over"
                }
                return
            }
            if(self.game!.winner == "WHITE"){
                if(self.game!.getWhite(username: self.playerSelf!.username)){
                    DispatchQueue.main.async {
                        self.notificationLabel.text = "winner"
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.notificationLabel.text = "you lose"
                }
                return
            }
            if(self.game!.getWhite(username: self.playerSelf!.username)){
                DispatchQueue.main.async {
                    self.notificationLabel.text = "you lose"
                }
                return
            }
            DispatchQueue.main.async {
                self.notificationLabel.text = "winner"
            }
        }
    }
    
    private func processDrawProposal() {
        if(self.game!.outcome == "TBD"){
            self.notificationLabel.isHidden = true
            return
        }
        if(self.game!.outcome == "PENDING"){
            if(!self.turn){
                self.notificationLabel.isHidden = false
                self.timerLabel.isHidden = false
                self.notificationLabel.text = "proposal pending"
                self.turnaryLabel.text = "\(self.playerOther!.username) to respond"
                return
            }
            self.notificationLabel.isHidden = false
            self.timerLabel.isHidden = false
            self.notificationLabel.text = "proposal pending"
            self.turnaryLabel.text = "\(self.playerSelf!.username) to respond"
            
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Evaluate", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Evaluate") as! Evaluate
                viewController.modalTransitionStyle = .crossDissolve
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.game!.getPlayerOther(username: self.playerSelf!.username))
                viewController.setGameTschess(gameTschess: self.game!)
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    private func evalCheckMate() {
        let kingCoord: [Int] = CheckCheck().kingCoordinate(affiliation: self.game!.turn, state: self.tschessElementMatrix!)
        let mate: Bool = CheckCheck().mate(king: kingCoord, state: self.tschessElementMatrix!)
        if(mate){
            //print("FUCK x FUCK x FUCK")
            UpdateMate().execute(id: self.game!.id) { (success) in
                if(!success){
                    //error
                }
                self.resolveGameTimeout()
            }
        }
        else if(self.game!.outcome != "CHECK"){
            /* ~ */
            if(CheckCheck().on(affiliation: self.game!.turn, state: self.tschessElementMatrix!)){
                UpdateCheck().execute(id: self.game!.id) { (success) in
                    if(!success){
                        //error
                    }
                }
            }
            /* ~ */
            return
        }
        if(!turnaryLabel.text!.contains("check")){
            self.turnaryLabel.text = "\(self.turnaryLabel.text!) (check)"
        }
    }
    
    // MARK: polling task
    
    @objc func pollingTask() {
        GameRequest().execute(id: self.game!.id) { (game) in
            //print("            game!.updated: \(game!.updated)")
            //print("self.gameTschess!.updated: \(self.gameTschess!.updated)")
            let dateSEV: Date = self.dateTime.toFormatDate(string: game!.updated)              //A
            let dateLOC: Date = self.dateTime.toFormatDate(string: self.game!.updated)  //B
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
                    self.setGame(game: game!)
                    self.setTurn()
                    self.tschessElementMatrix = game!.getStateClient(username: self.playerSelf!.username)
                    self.collectionView.reloadData()
                    self.processDrawProposal()
                    self.resolveGameTimeout()
                    self.evalCheckMate()
                }
                //print("Date A is later than date B")
            }
        }
    }
    
    func pawnPromotion(proposed: [Int]) {
        DispatchQueue.main.async {
            self.pawnPromotion!.setProposed(proposed: proposed)
            self.present(self.pawnPromotion!, animated: false, completion: nil)
        }
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
        self.updateCountdown()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "DrawResign", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "DrawResign") as! DrawResign
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.game!.getPlayerOther(username: self.playerSelf!.username))
                viewController.setGameTschess(gameTschess: self.game!)
                self.tabBarMenu.selectedItem = nil
                self.present(viewController, animated: true, completion: nil)
            }
        default: //0
            self.stopTimers()
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                SelectActual().execute(player: self.playerSelf!, height: height)
            }
        }
    }
    
    var landmine: Landmine?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.tabBarMenu.delegate = self
        
        let white: Bool = self.game!.getWhite(username: self.playerSelf!.username)
        
        self.processDrawProposal()
        self.castling = Castle(white: white)
        self.castling!.setChess(chess: self)
        self.castling!.setTransitioner(transitioner: self.transitioner!)
        
        self.passant = Passant(white: white)
        self.passant!.setChess(chess: self)
        self.passant!.setTransitioner(transitioner: self.transitioner!)
        
        self.landmine = Landmine(
            game_id: self.game!.id,
            white: white,
            transitioner: self.transitioner!,
            activityIndicator: self.activityIndicator)
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
        
        let coordinate = self.transitioner!.getCoordinate()
        if(coordinate != nil){
            let pawnPromotion = self.pawnPromotion!.evaluate(coordinate: coordinate!, proposed: [x,y])
            if(pawnPromotion){
                self.pawnPromotion(proposed: [x,y])
                return
            }
            let castling = self.castling!.execute(coordinate: coordinate!, proposed: [x,y], state0: self.tschessElementMatrix!)
            if(castling){
                return
            }
            let enPassant = self.passant!.evaluate(coordinate: coordinate!, proposed: [x,y], state0: self.tschessElementMatrix!)
            if(enPassant){
                return
            }
            
            
            let landmine = self.landmine!.evaluate(coordinate: coordinate!, proposed: [x,y], state0: self.tschessElementMatrix!)
            if(landmine){
                return
            }
            
            
            if(self.transitioner!.validMove(propose: [x,y], state0: self.tschessElementMatrix!)){
                self.tschessElementMatrix = self.transitioner!.deselectHighlight(state0: self.tschessElementMatrix!)
                let stateX: [[Piece?]] = self.transitioner!.executeMove(propose: [x,y], state0: self.tschessElementMatrix!)
                let stateUpdate = SerializerState(white: self.game!.getWhite(username: self.playerSelf!.username)).renderServer(state: stateX)
                
                let white: Bool = self.game!.getWhite(username: self.playerSelf!.username)
                
                let hx: Int = white ? x : 7 - x
                let hy: Int = white ? y : 7 - y
                let h0: Int = white ? coordinate![0] : 7 - coordinate![0]
                let h1: Int = white ? coordinate![1] : 7 - coordinate![1]
                let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
                
                let requestPayload: [String: Any] = ["id_game": self.game!.id, "state": stateUpdate, "highlight": highlight, "condition": "TBD"]
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
            //otherwise invalid --> deselect...
            self.tschessElementMatrix = self.transitioner!.deselectHighlight(state0: self.tschessElementMatrix!)
            self.collectionView.reloadData()
            self.transitioner!.clearCoordinate()
            return
        }
        let state0 = self.game!.getStateClient(username: self.playerSelf!.username)
        self.tschessElementMatrix = self.transitioner!.evaluateHighlightSelection(coordinate: [x,y], state0: state0)
        self.collectionView.reloadData()
    }
    
}
