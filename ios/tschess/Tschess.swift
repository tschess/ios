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
    
    // MARK: LABEL RENDER FUNC
    private func setLabelTurnary() {
        if(self.labelTurnary.isHidden){
            self.labelTurnary.isHidden = false
        }
        let turn = self.game!.getTurn()
        self.labelTurnary.text = "\(turn) to move"
    }
    
    private func setLabelNotification() {
        if(self.game!.outcome == "TBD"){
            self.labelNotification.isHidden = true
        }
        if(self.game!.outcome == "PENDING"){
            self.drawProposal()
        }
    }
    
    private func drawProposal() {
        self.labelNotification.isHidden = false
        self.labelNotification.text = "proposal pending"
        let turn = self.game!.getTurn()
        self.labelTurnary.text = "\(turn) to respond"
        
        let username: String = self.playerSelf!.username
        if(self.game!.getTurn(username: username)){
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
    
    private func timeout() { //what if these both go simultaneously...
        let id_game: String = self.game!.id
        let resigner: String = self.game!.getTurn()
        let winner: String = self.game!.getPlayerOther(username: resigner).username
        let white: Bool = self.game!.getWhite(username: resigner)
        let update: [String: Any] = ["id_game": id_game, "id_self": resigner, "id_oppo": winner, "white": white]
        UpdateResign().execute(requestPayload: update) { (result) in
            if(!result){
                //error
            }
        }
    }
    
    private func setLabelCountdown(update: String) {
        let dateUpdate: Date = self.dateTime.toFormatDate(string: update)
        let dateActual: Date = self.dateTime.currentDate()
        let intervalDifference: TimeInterval = dateActual.timeIntervalSince(dateUpdate)
        let intervalStandard: TimeInterval = Double(24) * 60 * 60
        let timeRemaining: TimeInterval = intervalStandard - intervalDifference
        self.labelCountdown.text = self.formatString(interval: timeRemaining)
    }
    
    private func formatString(interval: TimeInterval) -> String {
        let sec = Int(interval.truncatingRemainder(dividingBy: 60))
        let min = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let hour = Int(interval / 3600)
        let timeout: Bool = hour < 1 && min < 1 && sec < 1
        if (timeout) {
            self.timeout()
            return "00:00:00"
        }
        if(self.labelCountdown.isHidden){
            self.labelCountdown.isHidden = false
        }
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    @objc func decCountdown() {
        var interval0: Double = 0
        let componentValueSet = self.labelCountdown.text!.components(separatedBy: ":")
        for (index, component) in componentValueSet.reversed().enumerated() {
            interval0 += (Double(component) ?? 0) * pow(Double(60), Double(index))
        }
        let interval1: TimeInterval = interval0 - TimeInterval(1.0)
        self.labelCountdown.text = self.formatString(interval: interval1)
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
    let promotion: Promotion
    let dateTime: DateTime
    
    required init?(coder aDecoder: NSCoder) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Promotion", bundle: nil)
        self.promotion = storyboard.instantiateViewController(withIdentifier: "Promotion") as! Promotion
        self.dateTime = DateTime()
        super.init(coder: aDecoder)
    }
    
    // MARK: LIFEECYCLE
    var transitioner: Transitioner?
    var landmine: Landmine?
    var passant: Passant?
    var castle: Castle?
    
    // MARK: TSCHESS VARIABLES
    var matrix: [[Piece?]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewBoard.dataSource = self
        self.viewBoard.delegate = self
        self.tabBarMenu.delegate = self
        
        let username: String = self.playerSelf!.username
        let matrix: [[Piece?]] = self.game!.getStateClient(username: username)
        self.matrix = matrix
        self.viewBoard.isHidden = true
        
        let white: Bool = self.game!.getWhite(username: username)
        let transitioner = Transitioner(white: white, collectionView: self.viewBoard)
        self.promotion.setTransitioner(transitioner: transitioner)
        self.promotion.setTschess(tschess: self)
        
        let game_id: String = self.game!.id
        self.landmine = Landmine(game_id: game_id, white: white, transitioner: transitioner, activityIndicator: self.activityIndicator)
        self.passant = Passant(white: white, transitioner: transitioner, tschess: self)
        self.castle = Castle(white: white, transitioner: transitioner, tschess: self)
        self.transitioner = transitioner
        
        self.labelCountdown.isHidden = true
        self.setLabelCountdown(update: self.game!.updated)
        self.labelTurnary.isHidden = true
        self.setLabelTurnary()
        self.labelNotification.isHidden = true
        self.setLabelNotification()
        
        self.activityIndicator.isHidden = true
        self.setTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelElo.text = self.playerOther!.getLabelTextElo()
        self.labelRank.text = self.playerOther!.getLabelTextRank()
        self.labelRankDate.text = self.playerOther!.getLabelTextDate()
        self.labelUsername.text = self.playerOther!.username
        self.imageViewAvatar.image = self.playerOther!.getImageAvatar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewBoard.reloadData()
        self.viewBoard.isHidden = false
        
        self.setLabelCheck()
        self.setLabelEndgame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.viewBoardHeight.constant = viewBoard.contentSize.height
    }
    
    private func setLabelCheck() {
        let state: [[Piece?]] = self.matrix!
        let color: String =  self.game!.turn //i.e. "WHITE" or "BLACK"
        let checker: Checker = Checker()
        
        let king: [Int] = checker.kingCoordinate(affiliation: color, state: state)
        let mate: Bool = checker.mate(king: king, state: state)
        if(mate){
            UpdateMate().execute(id: self.game!.id) { (success) in
                if(!success){
                    //error
                }
            }
            return
        }
        let check0: Bool = self.game!.outcome == "CHECK"
        let check1: Bool = checker.on(affiliation: color, state: state)
        if(!check0 && !check1){
            return
        }
        if(!check0 && check1){
            UpdateCheck().execute(id: self.game!.id) { (success) in
                if(!success){
                    //error
                }
            }
            return
        }
        let indication: Bool = self.labelTurnary.text!.contains("check")
        if(!indication){
            self.labelTurnary.text = "\(self.labelTurnary.text!) (check)"
        }
    }
    
    func setLabelEndgame() {
        let resolved: Bool = self.game!.status == "RESOLVED"
        if(!resolved){
            return
        }
        self.labelTitle.text = "game over"
        self.endTimer()
        self.labelNotification.isHidden = false
        self.labelCountdown.isHidden = true
        self.labelTurnary.isHidden = true
        if(self.game!.outcome == "DRAW"){
            self.labelNotification.text = "draw"
            return
        }
        let username: String = self.playerSelf!.username
        if(self.game!.getWinner(username: username)){
            self.labelNotification.text = "winner"
            return
        }
        self.labelNotification.text = "you lose"
    }
    
    func pawnPromotion(proposed: [Int]) {
        DispatchQueue.main.async {
            self.promotion.setProposed(proposed: proposed)
            self.present(self.promotion, animated: false, completion: nil)
        }
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
    
    
    
    // MARK: POLLING GAME
    
    @objc func pollingTask() {
        let id_game: String = self.game!.id
        GameRequest().execute(id: id_game) { (game0) in
            let updatedSv0: String = game0!.updated
            let updatedSv1: Date = self.dateTime.toFormatDate(string: updatedSv0)
            let updatedLc0: String = self.game!.updated
            let updatedLc1: Date = self.dateTime.toFormatDate(string: updatedLc0)
            switch updatedSv1.compare(updatedLc1) {
            case .orderedAscending:
                return
            case .orderedSame:
                return
            case .orderedDescending:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    let game1 = game0!
                    self.setGame(game: game1)
                    let username: String = self.playerSelf!.username
                    let matrix1: [[Piece?]] = game1.getStateClient(username: username)
                    self.matrix = matrix1
                    
                    self.viewBoard.reloadData()
                    self.setLabelCountdown(update: game1.updated)
                    self.setLabelTurnary()
                    self.setLabelNotification()
                    self.setLabelCheck()
                    self.setLabelEndgame()
                }
            }
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
    
    private func getHighlight(highlight: String) -> [[Int]] {
        let coords = Array(highlight)
        let h0a: Int = Int(String(coords[0]))!
        let h0b: Int = Int(String(coords[1]))!
        let h0: [Int] = [h0a,h0b]
        let h1a: Int = Int(String(coords[2]))!
        let h1b: Int = Int(String(coords[3]))!
        let h1: [Int] = [h1a,h1b]
        return [h0, h1]
    }
    
    private func getNormalCoord(indexPath: IndexPath) -> [Int] {
        let username: String = self.playerSelf!.username
        let white: Bool = self.game!.getWhite(username: username)
        let x: Int = white ? indexPath.item / 8 : 7 - (indexPath.item / 8)
        let y: Int = white ? indexPath.item % 8 : 7 - (indexPath.item % 8)
        return [x,y]
    }
    
    private func getOrnamentCell(highlight: Bool, cell: SquareCell) -> SquareCell{
        if(highlight){
            cell.layer.borderColor = UIColor.magenta.cgColor
            cell.backgroundColor = cell.backgroundColor!.withAlphaComponent(0.7)
            cell.layer.borderWidth = 0.25
            return cell
        }
        cell.layer.borderWidth = 0
        cell.backgroundColor = cell.backgroundColor!.withAlphaComponent(1)
        return cell
    }
    
    private func getHighlightCell(indexPath: IndexPath, cell: SquareCell) -> SquareCell {
        let resolved: Bool = self.game!.status == "RESOLVED"
        let highlight: String = self.game!.highlight
        if(highlight == "TBD" || resolved){
            return self.getOrnamentCell(highlight: false, cell: cell)
        }
        let coordHighlight: [[Int]] = self.getHighlight(highlight: highlight)
        let coordNormal: [Int] = self.getNormalCoord(indexPath: indexPath)
        if(self.game!.outcome == "LANDMINE"){
            self.labelNotification.isHidden = false
            self.labelNotification.text = ".:*~ poison pawn ~*:."
            return self.highlightCoord(coordNormal: coordNormal, coordHighlight: coordHighlight, cell: cell)
        }
        let username: String = self.playerSelf!.username
        let turn: Bool = self.game!.getTurn(username: username)
        if(!turn){
            return self.getOrnamentCell(highlight: false, cell: cell)
        }
        return self.highlightCoord(coordNormal: coordNormal, coordHighlight: coordHighlight, cell: cell)
    }
    
    private func highlightCoord(coordNormal: [Int], coordHighlight: [[Int]], cell: SquareCell) -> SquareCell {
        for (_, coord) in coordHighlight.enumerated() {
            if(coord == coordNormal){
                return self.getOrnamentCell(highlight: true, cell: cell)
            }
        }
        return self.getOrnamentCell(highlight: false, cell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! SquareCell
        cell.backgroundColor = assignCellBackgroundColor(index: indexPath.row)
        cell.imageView.image = self.assignCellTschessElement(indexPath: indexPath)
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return self.getHighlightCell(indexPath: indexPath, cell: cell)
    }
    
    // MARK: PRIME MOVER
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let username: String = self.playerSelf!.username
        if(!self.game!.getTurn(username: username)){
            self.flash()
            return
        }
        let x = indexPath.item / 8
        let y = indexPath.item % 8
        print("x: \(x), y: \(y)")
        
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
            let passant = self.passant!.evaluate(coordinate: coordinate!, proposed: [x,y], state0: self.matrix!)
            if(passant){
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
