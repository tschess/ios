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
        
        self.transitioner = Transitioner()
        
        self.castling = Castle()
        self.castling!.setTransitioner(transitioner: transitioner!)
        
        self.pawnPromotionStoryboard = UIStoryboard(name: "Promotion", bundle: nil)
        self.pawnPromotion = pawnPromotionStoryboard!.instantiateViewController(withIdentifier: "Promotion") as? Promotion
        self.pawnPromotion!.setTransitioner(transitioner: transitioner!)
        self.pawnPromotion!.setChess(chess: self)
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
        
        self.timerLabel.isHidden = true
        self.contentViewLabel.isHidden = true
        
        self.renderHeader()
        self.startTimers()
        
        self.tschessElementMatrix = self.gameTschess!.getStateClient(username: self.playerSelf!.username)
    }
    
    var tschessElementMatrix: [[Piece?]]?
    
    private func getTurn() -> Bool {
        return self.gameTschess!.getTurn(username: self.playerSelf!.username)
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
    
    private func assignCellBackgroundColor(indexPath: IndexPath) -> UIColor {
        if (indexPath.row % 2 == 0) {
            if ((indexPath.row / 8) % 2 == 0) {
                return UIColor.purple
            } else {
                return UIColor.brown
            }
        }
        if ((indexPath.row / 8) % 2 == 0) {
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
        guard pollingTimer == nil else { return }
        guard counterTimer == nil else { return }
        
        pollingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pollingTask), userInfo: nil, repeats: true)
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func stopTimers() {
        pollingTimer?.invalidate()
        pollingTimer = nil
        
        counterTimer?.invalidate()
        counterTimer = nil
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
        cell.layer.borderWidth = 0
        
        return cell
    }
    
    func resolveGameTimeout() {
        self.stopTimers()
        
    }
    
    private func attributeString(red: String, black: String) -> NSMutableAttributedString {
        let attributeRed = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)]
        let attributeBlack = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)]
        let label = NSMutableAttributedString(string: red, attributes: attributeRed)
        let content = NSMutableAttributedString(string: black, attributes: attributeBlack)
        let attributeString = NSMutableAttributedString()
        attributeString.append(label)
        attributeString.append(content)
        return attributeString
    }
    
    private func evaluateDrawProposal() {
        self.stopTimers()
        DispatchQueue.main.async {
            let evaluateProposalStoryboard: UIStoryboard = UIStoryboard(name: "Evaluate", bundle: nil)
            let evaluateProposal = evaluateProposalStoryboard.instantiateViewController(withIdentifier: "Evaluate") as! Evaluate
            evaluateProposal.modalTransitionStyle = .crossDissolve
            self.present(evaluateProposal, animated: true, completion: nil)
        }
    }
    
    private func processDrawProposal() {
        DispatchQueue.main.async {
            self.contentViewLabel.attributedText = self.attributeString(red: "", black: "awaiting result of draw proposal")
        }
    }
    
    // MARK: polling task
    
    @objc func pollingTask() {
        //        PollingAgent().execute(id: self.gameModel!.getIdentifier(), gamestate: self.gamestate!) { (result, error) in
        //            if(error != nil || result == nil){
        //                return
        //            }
        //            let dateLocal = self.dateTime!.toFormatDate(string: self.gamestate!.getUpdated())
        //            let dateServer = self.dateTime!.toFormatDate(string: result!.getUpdated())
        //            if(dateServer <= dateLocal){
        //                return
        //            }
        //            if(self.assessDrawValues(gamestate: result!)){
        //                return
        //            }
        //            self.setGamestate(gamestate: result!)
        //            DispatchQueue.main.async {
        //                self.indicatorLabelUpdate()
        //                self.collectionView.reloadData()
        //            }
        //        }
    }
    
    // MARK: prime mover
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(!self.getTurn()){
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
        let state0 = self.gameTschess!.getStateClient(username: self.playerSelf!.username)
        self.tschessElementMatrix = self.transitioner!.evaluateInput(coordinate: [x,y], state: state0)
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
        cell.backgroundColor = assignCellBackgroundColor(indexPath: indexPath)
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
        case 0:
            self.stopTimers()
            DispatchQueue.main.async() {
                let storyboard: UIStoryboard = UIStoryboard(name: "Actual", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Actual") as! Actual
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        case 1:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "DrawResign", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "DrawResign") as! DrawResign
                viewController.setTabBar(tabBarMenu: self.tabBarMenu!)
                self.present(viewController, animated: true, completion: nil)
            }
        default:
            self.stopTimers()
            //print("lol")
        }
    }
    
}
