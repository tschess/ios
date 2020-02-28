//
//  Tschess.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Tschess: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    // MARK: OUTLETS
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewCountdown: UIView!
    @IBOutlet weak var viewBoardHeight: NSLayoutConstraint!
    @IBOutlet weak var viewBoard: BoardView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelRankDate: UILabel!
    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var labelElo: UILabel!
    
    @IBOutlet weak var labelNotification: UILabel!
    @IBOutlet weak var labelCountdown: UILabel!
    @IBOutlet weak var labelTurnary: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    // STRONG
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tabBarMenu: UITabBar!
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.endTimer()
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectActual().execute(player: self.playerSelf!, height: height)
        }
    }
    
    // MARK: MEMBER VARIABLES
    var playerSelf: EntityPlayer?
    var playerOther: EntityPlayer?
    var game: EntityGame?
    
    func setSelf(player: EntityPlayer){
        self.playerSelf = player
    }
    func setOther(player: EntityPlayer){
        self.playerOther = player
    }
    func setGame(game: EntityGame) {
        self.game = game
    }
    
    // MARK: LABEL UPDATE FUNCTIONS
    private func setTurn() {
        if(self.labelTurnary.isHidden){
            self.labelTurnary.isHidden = false
        }
        let username: String = self.playerSelf!.username
        let (turn, player) = self.game!.getTurn(username: username)
        self.turn = turn
        self.labelTurnary.text = "\(player) to move"
    }
    
    private func setCountdown() {
        let dateUpdate: Date = self.dateTime.toFormatDate(string: self.game!.updated)
        let dateActual: Date = self.dateTime.currentDate()
        let intervalDifference: TimeInterval = dateActual.timeIntervalSince(dateUpdate)
        let intervalStandard: TimeInterval = Double(24) * 60 * 60
        let timeRemaining = intervalStandard - intervalDifference
        self.labelCountdown.text = String(timeRemaining)
    }
    
    @objc func decCountdown() {
        var interval0: Double = 0
        let componentValueSet = self.labelCountdown.text!.components(separatedBy: ":")
        for (index, component) in componentValueSet.reversed().enumerated() {
            interval0 += (Double(component) ?? 0) * pow(Double(60), Double(index))
        }
        let interval1: TimeInterval = interval0 - TimeInterval(1.0)
        let sec = Int(interval1.truncatingRemainder(dividingBy: 60))
        let min = Int(interval1.truncatingRemainder(dividingBy: 3600) / 60)
        let hour = Int(interval1 / 3600)
        if(self.labelCountdown.isHidden){
            self.labelCountdown.isHidden = false
        }
        self.labelCountdown.text = String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    // MARK: TIMER
    var timerPolling: Timer?
    var timerCountdown: Timer?
    
    func setTimer() {
        guard self.timerPolling == nil else {
            return
        }
        self.timerPolling = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pollingTask), userInfo: nil, repeats: true)
        guard self.timerCountdown == nil else {
            return
        }
        self.timerCountdown = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decCountdown), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        self.timerPolling?.invalidate()
        self.timerPolling = nil
        self.timerCountdown?.invalidate()
        self.timerCountdown = nil
    }
    
    // MARK: CONSTRUCTOR
    let dateTime: DateTime
    let promotion: Promotion
    
    required init?(coder aDecoder: NSCoder) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Promotion", bundle: nil)
        self.promotion = storyboard.instantiateViewController(withIdentifier: "Promotion") as! Promotion
        self.dateTime = DateTime()
        super.init(coder: aDecoder)
    }
    
    // MARK: LIFEECYCLE
    var transitioner: Transitioner?
    var passant: Passant?
    var castle: Castle?
    
    // MARK: TSCHESS VARIABLES
    var matrix: [[Piece?]]?
    var turn: Bool?
    
    
    private func processDrawProposal() {
           if(self.game!.outcome == "TBD"){
               self.labelNotification.isHidden = true
               return
           }
           if(self.game!.outcome == "PENDING"){
               if(!self.turn!){
                   self.labelNotification.isHidden = false
                   self.labelCountdown.isHidden = false
                   self.labelNotification.text = "proposal pending"
                   self.labelTurnary.text = "\(self.playerOther!.username) to respond"
                   return
               }
               self.labelNotification.isHidden = false
               self.labelCountdown.isHidden = false
               self.labelNotification.text = "proposal pending"
               self.labelTurnary.text = "\(self.playerSelf!.username) to respond"
               
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewBoard.dataSource = self
        self.viewBoard.delegate = self
        self.tabBarMenu.delegate = self
        
        self.setTimer()
        
        self.setCountdown()
        self.setTurn()
        
        let username: String = self.playerSelf!.username
        let matrix: [[Piece?]] = self.game!.getStateClient(username: username)
        self.matrix = matrix
        
        let white: Bool = self.game!.getWhite(username: username)
        let transitioner = Transitioner(white: white, collectionView: self.viewBoard)
        self.promotion.setTransitioner(transitioner: transitioner)
        self.promotion.setTschess(tschess: self)
        
        let game_id: String = self.game!.id
        self.landmine = Landmine(game_id: game_id, white: white, transitioner: transitioner, activityIndicator: self.activityIndicator)
        self.passant = Passant(white: white, transitioner: transitioner, tschess: self)
        self.castle = Castle(white: white, transitioner: transitioner, tschess: self)
        self.transitioner = transitioner
        
        self.processDrawProposal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewBoard.isHidden = true
        self.labelTurnary.isHidden = true
        self.labelCountdown.isHidden = true
        self.labelNotification.isHidden = true
        
        self.renderHeader()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewBoard.reloadData()
        self.viewBoard.isHidden = false
        self.activityIndicator.isHidden = true
        
        self.evalCheckMate() //draw/resign also?
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           self.viewBoardHeight.constant = viewBoard.contentSize.height
       }
    
    
    public func renderHeader() {
        self.imageViewAvatar.image = self.playerOther!.getImageAvatar()
        self.labelUsername.text = self.playerOther!.username
        self.labelElo.text = self.playerOther!.getLabelTextElo()
        self.labelRank.text = self.playerOther!.getLabelTextRank()
        self.labelRankDate.text = self.playerOther!.getLabelTextDate()
    }
    
    
    
    
    
    
    
    func flash() {
        let flashFrame = UIView(frame: viewBoard.bounds)
        flashFrame.backgroundColor = UIColor.white
        flashFrame.alpha = 0.7
        self.viewBoard.addSubview(flashFrame)
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
    
    
    
    
    
    private func highlightLastMoveCoords(indexPath: IndexPath, cell: SquareCell) -> SquareCell {
        if(self.game!.outcome == "LANDMINE"){
            DispatchQueue.main.async {
                self.labelNotification.isHidden = false
                self.labelNotification.text = ".:*~ poison pawn ~*:."
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
                
                if(!self.turn!){
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
                
                if(!self.turn!){
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
        if(!self.turn!){
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
                self.labelTitle.text = "game over"
                self.labelNotification.isHidden = false
                self.labelTurnary.isHidden = true
                self.labelCountdown.isHidden = true
            }
            self.endTimer()
            if(self.game!.outcome == "DRAW"){
                DispatchQueue.main.async {
                    self.labelNotification.text = "draw"
                    self.labelTitle.text = "game over"
                }
                return
            }
            if(self.game!.winner == "WHITE"){
                if(self.game!.getWhite(username: self.playerSelf!.username)){
                    DispatchQueue.main.async {
                        self.labelNotification.text = "winner"
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.labelNotification.text = "you lose"
                }
                return
            }
            if(self.game!.getWhite(username: self.playerSelf!.username)){
                DispatchQueue.main.async {
                    self.labelNotification.text = "you lose"
                }
                return
            }
            DispatchQueue.main.async {
                self.labelNotification.text = "winner"
            }
        }
    }
    
   
    
    private func evalCheckMate() {
        let kingCoord: [Int] = CheckCheck().kingCoordinate(affiliation: self.game!.turn, state: self.matrix!)
        let mate: Bool = CheckCheck().mate(king: kingCoord, state: self.matrix!)
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
            if(CheckCheck().on(affiliation: self.game!.turn, state: self.matrix!)){
                UpdateCheck().execute(id: self.game!.id) { (success) in
                    if(!success){
                        //error
                    }
                }
            }
            /* ~ */
            return
        }
        if(!labelTurnary.text!.contains("check")){
            self.labelTurnary.text = "\(self.labelTurnary.text!) (check)"
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
                    self.matrix = game!.getStateClient(username: self.playerSelf!.username)
                    self.viewBoard.reloadData()
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
            self.promotion.setProposed(proposed: proposed)
            self.present(self.promotion, animated: false, completion: nil)
        }
    }
    
    private func assignCellTschessElement(indexPath: IndexPath) -> UIImage? {
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        if(self.matrix![x][y] != nil){
            return self.matrix![x][y]!.getImageVisible()
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
    
   
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "DrawResign", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "DrawResign") as! DrawResign
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.game!.getPlayerOther(username: self.playerSelf!.username))
                viewController.setGame(game: self.game!)
                self.tabBarMenu.selectedItem = nil
                self.present(viewController, animated: true, completion: nil)
            }
        default: //0
            self.endTimer()
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                SelectActual().execute(player: self.playerSelf!, height: height)
            }
        }
    }
    
    var landmine: Landmine?
    
    
    
    
    // MARK: prime mover
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(!self.turn!){
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
            let pawnPromotion = self.promotion.evaluate(coordinate: coordinate!, proposed: [x,y])
            if(pawnPromotion){
                self.pawnPromotion(proposed: [x,y])
                return
            }
            let castling = self.castle!.execute(coordinate: coordinate!, proposed: [x,y], state0: self.matrix!)
            if(castling){
                return
            }
            let enPassant = self.passant!.evaluate(coordinate: coordinate!, proposed: [x,y], state0: self.matrix!)
            if(enPassant){
                return
            }
            
            
            let landmine = self.landmine!.evaluate(coordinate: coordinate!, proposed: [x,y], state0: self.matrix!)
            if(landmine){
                return
            }
            
            
            if(self.transitioner!.validMove(propose: [x,y], state0: self.matrix!)){
                self.matrix = self.transitioner!.deselectHighlight(state0: self.matrix!)
                let stateX: [[Piece?]] = self.transitioner!.executeMove(propose: [x,y], state0: self.matrix!)
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
            self.matrix = self.transitioner!.deselectHighlight(state0: self.matrix!)
            self.viewBoard.reloadData()
            self.transitioner!.clearCoordinate()
            return
        }
        let state0 = self.game!.getStateClient(username: self.playerSelf!.username)
        self.matrix = self.transitioner!.evaluateHighlightSelection(coordinate: [x,y], state0: state0)
        self.viewBoard.reloadData()
    }
    
}
