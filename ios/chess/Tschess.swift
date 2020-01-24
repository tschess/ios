//
//  Tschess.swift
//  ios
//
//  Created by Matthew on 1/24/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Tschess: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
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
    //@IBOutlet weak var turnIndicatorImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewImage: UIImageView!
    @IBOutlet weak var contentViewLabel: UILabel!
    
    @IBOutlet weak var collectionView: DynamicCollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerImage: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var turnaryLabel: UILabel!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var defaultColor: UIColor?
    
    var deviceType: String?
    var player: Player?
    var gameModel: Game?
    var gamestate: Gamestate?
    
    var pollingTimer: Timer?
    var counterTimer: Timer?
    
    var counter: String?
    var dateTime: DateTime?
    var transitioner: Transitioner?
    
    var castling: Castling?
    var pawnPromotion: PawnPromotion?
    var pawnPromotionStoryboard: UIStoryboard?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.counter = "00:00:00"
        
        self.dateTime = DateTime()
        self.transitioner = Transitioner()
        
        self.castling = Castling()
        self.castling!.setTransitioner(transitioner: transitioner!)
        
        self.pawnPromotionStoryboard = UIStoryboard(name: "PawnPromotion", bundle: nil)
        self.pawnPromotion = pawnPromotionStoryboard!.instantiateViewController(withIdentifier: "PawnPromotion") as? PawnPromotion
        self.pawnPromotion!.setTransitioner(transitioner: transitioner!)
        //self.pawnPromotion!.setChess(chess: self)
    }
    
    public func setPlayer(player: Player) {
        self.player = player
    }
    
    public func setGameModel(gameModel: Game) {
        self.gameModel = gameModel
    }
    
    public func getGamestate() -> Gamestate {
        return self.gamestate!
    }
    
    public func setGamestate(gamestate: Gamestate) {
        self.gamestate = gamestate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
        self.collectionView.isHidden = false
        self.startTimers()
        //self.countdownTimerLabel.isHidden = false
        self.indicatorLabelUpdate()
        
        self.activityIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.tabBarMenu.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isHidden = true
        //self.countdownTimerLabel.isHidden = true
        self.deviceType = StoryboardSelector().device()
        
        //self.renderSkinLayout()
        //self.notificationLabel.text = nil
        self.assessDrawValues(gamestate: self.gamestate!)
        //if(!self.longView()){
            //return
        //}
        let dataDecoded: Data = Data(base64Encoded: self.gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView!.image = decodedimage
        self.rankLabel!.text = self.gameModel!.getOpponentRank()
        self.usernameLabel!.text = self.gameModel!.getOpponentName()
    }
    
    @objc func updateCounter() {
        if(counter == nil){
            return
        }
        var timeInterval_x = parseDuration(counter!)
        timeInterval_x -= TimeInterval(1.0)
        
        let sec = Int(timeInterval_x.truncatingRemainder(dividingBy: 60))
        let min = Int(timeInterval_x.truncatingRemainder(dividingBy: 3600) / 60)
        let hour = Int(timeInterval_x / 3600)
        
        counter = String(format: "%02d:%02d:%02d", hour, min, sec)
        timerLabel.text = counter
    }
    
    private func prohibited() -> Bool {
        let turn: Bool = self.player!.getName() == self.gamestate!.getUsernameTurn()
        let ongooing: Bool = gamestate!.getGameStatus() == "ONGOING"
        return !turn || !ongooing
    }
    
    func flash() {
        let flashFrame = UIView(frame: collectionView.bounds)
        flashFrame.backgroundColor = UIColor.black
        flashFrame.alpha = 0.7
        collectionView.addSubview(flashFrame)
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
    
    private func assignCellTschessElement(indexPath: IndexPath) -> UIImage? {
        let tschessElementMatrix = gamestate!.getTschessElementMatrix()
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        if(tschessElementMatrix[x][y] != nil){
            return tschessElementMatrix[x][y]!.getImageVisible()
        }
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = assignCellBackgroundColor(indexPath: indexPath)
        cell.imageView.image = assignCellTschessElement(indexPath: indexPath)
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return self.highlightLastMoveCoords(indexPath: indexPath, cell: cell)
    }
    
    func parseDuration(_ timeString:String) -> TimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }
        var interval: Double = 0
        let parts = timeString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        return interval
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
        StoryboardSelector().actual(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            self.stopTimers()
            StoryboardSelector().actual(player: self.player!)
        case 1:
            DispatchQueue.main.async {
                let drawResign_storyboard: UIStoryboard = UIStoryboard(name: "DrawResign", bundle: nil)
                let drawResign = drawResign_storyboard.instantiateViewController(withIdentifier: "DrawResign") as! DrawResign
                drawResign.setGamestate(gamestate: self.gamestate!)
                self.present(drawResign, animated: true, completion: nil)
            }
        default:
            self.stopTimers()
            StoryboardSelector().talk(player: self.player!, opponent: self.gamestate!.getGameModel().getOpponent(), gamestate: self.gamestate!)
        }
    }
    
    func pawnPromotion(proposed: [Int]) {
        DispatchQueue.main.async {
            self.pawnPromotion!.setProposed(proposed: proposed)
            self.present(self.pawnPromotion!, animated: false, completion: nil)
        }
    }
    
    private func updateCountdownTimer() {
        var countdownTimer_format: Date
        if(gamestate!.getUsernameTurn() == gamestate!.getUsernameWhite()){
            if(gamestate!.getLastMoveBlack() == "TBD"){
                return
            }
            countdownTimer_format = self.dateTime!.toFormatDate(string: gamestate!.getLastMoveBlack())
        } else {
            if(gamestate!.getLastMoveWhite() == "TBD"){
                return
            }
            countdownTimer_format = self.dateTime!.toFormatDate(string: gamestate!.getLastMoveWhite())
        }
        let countdownTimer_format_rn = self.dateTime!.currentDate()
        let secondsBetween: TimeInterval = countdownTimer_format_rn.timeIntervalSince(countdownTimer_format)
        let clock = gamestate!.getClock()!
        var limit: TimeInterval
        if(clock == "5"){
            limit = Double(clock)! * 60
        } else {
            limit = Double(clock)! * 60 * 60
        }
        if(limit - secondsBetween <= 0){
            resolveGameTimeout()
        }
        counter = String(limit - secondsBetween)
    }
    
    private func highlightLastMoveCoords(indexPath: IndexPath, cell: MyCollectionViewCell) -> MyCollectionViewCell {
        cell.layer.borderWidth = 0
        let highlight = self.gamestate!.getHighlight()
        if(highlight == nil){
            return cell
        }
        if(self.gamestate!.getGameStatus() == "RESOLVED"){ //not the place for this...
            return cell
        }
        if(self.gamestate!.getUsernameTurn() == self.player!.getName()){
            let x = indexPath.row / 8
            let y = indexPath.row % 8
            if(highlight!.contains([x,y])){
                cell.layer.borderColor = Colour().getRed().cgColor
                cell.layer.borderWidth = 1.5
            }
        }
        return cell
    }
    
    func resolveGameTimeout() {
        self.stopTimers()
        var winner = gamestate!.getUsernameWhite()
        if(gamestate!.getUsernameTurn() == gamestate!.getUsernameWhite()){
            winner = gamestate!.getUsernameBlack()
        }
        self.gamestate!.setWinner(winner: winner)
        self.gamestate!.setDrawProposer(drawProposer: "TIME")
        
        let requestPayload = GamestateSerializer().execute(gamestate: self.gamestate!)
        UpdateGamestate().execute(requestPayload: requestPayload)
    }
    
    private func attributeString(red: String, black: String) -> NSMutableAttributedString {
        let attributeRed = [
            NSAttributedString.Key.foregroundColor: Colour().getRed(),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)]
        let attributeBlack = [
            NSAttributedString.Key.foregroundColor: self.defaultColor!,
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
            let evaluateProposalStoryboard: UIStoryboard = UIStoryboard(name: "EvaluateProposal", bundle: nil)
            let evaluateProposal = evaluateProposalStoryboard.instantiateViewController(withIdentifier: "EvaluateProposal") as! EvaluateProposal
            evaluateProposal.modalTransitionStyle = .crossDissolve
            evaluateProposal.setGamestate(gamestate: self.gamestate!)
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
        PollingAgent().execute(id: self.gameModel!.getIdentifier(), gamestate: self.gamestate!) { (result, error) in
            if(error != nil || result == nil){
                return
            }
            let dateLocal = self.dateTime!.toFormatDate(string: self.gamestate!.getUpdated())
            let dateServer = self.dateTime!.toFormatDate(string: result!.getUpdated())
            if(dateServer <= dateLocal){
                return
            }
            if(self.assessDrawValues(gamestate: result!)){
                return
            }
            self.setGamestate(gamestate: result!)
            DispatchQueue.main.async {
                self.indicatorLabelUpdate()
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: prime mover
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(self.prohibited()){
            flash()
            return
        }
        let x = indexPath.item / 8
        let y = indexPath.item % 8
        let coordinate = self.transitioner!.getCoordinate()
        if(coordinate != nil){
            let pawnPromotion = self.pawnPromotion!.evaluate(coordinate: coordinate!, proposed: [x,y])
            if(pawnPromotion){
                self.transitioner!.clearCoordinate()
                self.gamestate!.setHighlight(coords: [x,y,coordinate![0],coordinate![1]])
                self.pawnPromotion(proposed: [x,y])
                return
            }
            let castling = self.castling!.execute(coordinate: coordinate!, proposed: [x,y], gamestate: self.gamestate!)
            if(castling){
                self.renderEffect()
                return
            }
            let enPassant = EnPassant().evaluate(coordinate: coordinate!, proposed: [x,y], gamestate: self.gamestate!)
            if(enPassant){
                self.renderEffect()
                return
            }
            let landmine = Landmine().detonate(coordinate: coordinate!, proposed: [x,y], gamestate: self.gamestate!)
            if(landmine){
                self.renderEffect()
                return
            }
            let hopped = Hopped().evaluate(coordinate: coordinate!, proposed: [x,y], gamestate: self.gamestate!)
            if(hopped){
                self.renderEffect()
                return
            }
        }
        self.transitioner!.evaluateInput(coordinate: [x,y], gamestate: self.gamestate!)
        self.indicatorLabelUpdate()
        self.collectionView.reloadData()
    }
    
    /* TODO !!! this can and probably should just live in the transitioner... */
    private func renderEffect() {
        Highlighter().neutralize(gamestate: self.gamestate!)
        self.gamestate!.setLastMoveUpdate(gamestate: self.gamestate!)
        self.gamestate!.changeTurn()
        self.transitioner!.clearCoordinate()
        Transitioner().evaluateCheckMate(gamestate: self.gamestate!)
        let requestUpdate = GamestateSerializer().execute(gamestate: self.gamestate!)
        UpdateGamestate().execute(requestPayload: requestUpdate)
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionViewHeight.constant = collectionView.contentSize.height
        self.updateCountdownTimer()
        self.evaluateEndOfGameTrigger()
    }
    
    private func evaluateEndOfGameTrigger() {
        let winner = self.gamestate!.getWinner()
        if(winner == "TBD"){
            return
        }
        self.gamestate!.setHighlight(coords: nil)
        self.stopTimers()
        self.timerLabel.text = nil
        self.turnaryLabel.text = nil
        self.gamestate!.setGameStatus(gameStatus: "RESOLVED")
        let drawProposer = gamestate!.getDrawProposer()
        if(drawProposer == "START"){
            self.titleViewLabel.attributedText = self.attributeString(red: "false start", black: "")
            self.contentViewLabel.attributedText = self.attributeString(red: "", black: ". ends in draw")
            return
        }
        if(winner == "DRAW"){
            self.titleViewLabel.attributedText = self.attributeString(red: "game over", black: "")
            self.contentViewLabel.attributedText = self.attributeString(red: "", black: "agree to draw")
            return
        }
        self.titleViewLabel.attributedText = self.attributeString(red: "game over", black: "")
        self.contentViewLabel.attributedText = self.attributeString(red: "", black: "\(winner) wins")
    }
    
    private func indicatorLabelUpdate() {
        let drawProposer = gamestate!.getDrawProposer()
        if(drawProposer == "LANDMINE"){
            self.contentViewLabel.text = "landmine!"
            self.contentViewLabel.textColor = Colour().getRed()
            self.gamestate!.setDrawProposer(drawProposer: "NONE")
        }
        else if(drawProposer == "PASSANT"){
            self.contentViewLabel.text = "en passant!"
            self.contentViewLabel.textColor = Colour().getRed()
            self.gamestate!.setDrawProposer(drawProposer: "NONE")
        }
        else if(drawProposer == "HOPPED"){
            self.contentViewLabel.text = "hopped!"
            self.contentViewLabel.textColor = Colour().getRed()
            self.gamestate!.setDrawProposer(drawProposer: "NONE")
        }
        else if(drawProposer == "CASTLE"){
            self.contentViewLabel.text = "castle"
            self.contentViewLabel.textColor = self.defaultColor
            self.gamestate!.setDrawProposer(drawProposer: "NONE")
        }
        else if(drawProposer == "NONE") {
            self.contentViewLabel.textColor = self.defaultColor
            self.contentViewLabel.text = ""
        }
        /* * */
        let usernameSelf = self.player!.getName()
        let usernameOpponent = self.gamestate!.getOpponentName()
        let usernameTurn = gamestate!.getUsernameTurn()
        let usernameCheck = gamestate!.getCheckOn()
        if(usernameSelf == usernameTurn){
            if(usernameSelf == usernameCheck){
                self.contentViewLabel.text = "you're in check"
                self.contentViewLabel.textColor = Colour().getRed()
                return
            }
           
            self.turnaryLabel.text = "\(self.player!.getName()) to move"
            
            return
        }
        if(usernameOpponent == usernameCheck){
            self.contentViewLabel.text = "opponent in check"
            self.contentViewLabel.textColor = self.defaultColor
            return
        }
        
        self.turnaryLabel.text = "\(self.gameModel!.getOpponentName()) to move"
    }
    
    private func assessDrawValues(gamestate: Gamestate) -> Bool {
        let usernameSelf = self.player!.getName()
        let usernameOpponent = self.gameModel!.getOpponentName()
        let drawProposerServer = gamestate.getDrawProposer()
        if(drawProposerServer == "NONE"){
            DispatchQueue.main.async {
                self.contentViewLabel.text = nil
            }
        }
        if(drawProposerServer == usernameSelf){
            self.processDrawProposal()
            return true
        }
        if(drawProposerServer == usernameOpponent){
            self.evaluateDrawProposal()
            return true
        }
        return false
    }
}

