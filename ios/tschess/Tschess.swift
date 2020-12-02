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
    //@IBOutlet weak var buttonBack: UIButton!
    //@IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewCountdown: UIView!
    @IBOutlet weak var viewBoardHeight: NSLayoutConstraint!
    @IBOutlet weak var viewBoard: BoardView!
    //@IBOutlet weak var imageViewAvatar: UIImageView!
    //@IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var labelCheck: UILabel!
    //@IBOutlet weak var labelTitle: UILabel!
    //@IBOutlet weak var labelRank: UILabel!
    //@IBOutlet weak var labelElo: UILabel!
    
    @IBOutlet weak var labelNotification: UILabel!
    @IBOutlet weak var labelTurnary: UILabel!
    
    // STRONG
    @IBOutlet var labelCountdown: UILabel!
    //@IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tabBarMenu: UITabBar!
    
    // MARK: CONSTRUCTOR
    let highlighter: Highlighter
    let promotion: PopPromo
    let dateTime: DateTime
    
    required init?(coder aDecoder: NSCoder) {
        let storyboard: UIStoryboard = UIStoryboard(name: "PopPromo", bundle: nil)
        self.promotion = storyboard.instantiateViewController(withIdentifier: "PopPromo") as! PopPromo
        self.highlighter = Highlighter()
        self.dateTime = DateTime()
        super.init(coder: aDecoder)
    }
    
    //TODO: ought not be here...
    func menuRefresh() {
        DispatchQueue.main.async {
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let viewControllers = navigationController.viewControllers
                for vc in viewControllers {
                    if vc.isKind(of: Menu.classForCoder()) {
                        let menu: Menu = vc as! Menu
                        menu.menuTable!.refresh(refreshControl: nil)
                    }
                }
                
            }
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "PopOption", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PopOption") as! PopOption
                viewController.playerSelf = self.player!
                viewController.playerOther = self.game!.getPlayerOther(username: self.player!.username)
                viewController.game = self.game!
                self.tabBarMenu.selectedItem = nil
                self.present(viewController, animated: true, completion: nil)
            }
        default: //0
            //self.backButtonClick("")
            //print("lol")
            self.menuRefresh()
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            _ = self.navigationController?.popViewController(animated: false)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    var player: EntityPlayer?
    var playerOther: EntityPlayer?
    var game: EntityGame?
    
    // MARK: TIMER
    var timerPolling: Timer?
    
    func setTimer() {
        guard self.timerPolling == nil else {
            return
        }
        self.timerPolling = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pollingTask), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        self.timerPolling?.invalidate()
        self.timerPolling = nil
        self.countdown!.endTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
        self.endTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setLabel()
        self.setTimer()
        
        self.viewBoard.layoutSubviews()
        self.viewBoard.isHidden = false
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
        
        
        
        //TODO: Header
        let viewHeaderDynamic = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.viewHeader.addSubview(viewHeaderDynamic)
        viewHeaderDynamic.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: viewHeaderDynamic, attribute: $0, relatedBy: .equal, toItem: viewHeaderDynamic.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        viewHeaderDynamic.set(player: self.player!)
        
        
        
        let username: String = self.player!.username
        let matrix: [[Piece?]] = self.game!.getStateClient(username: username)
        self.matrix = matrix
        self.viewBoard.isHidden = true
        
        let white: Bool = self.game!.getWhite(username: username)
        let transitioner = Transitioner(white: white, collectionView: self.viewBoard)
        self.promotion.setTransitioner(transitioner: transitioner)
        self.promotion.setTschess(tschess: self)
        
        let game_id: String = self.game!.id
        //self.landmine = Landmine(game_id: game_id, white: white, transitioner: transitioner, activityIndicator: self.activityIndicator, tschess: self)
        self.passant = Passant(white: white, transitioner: transitioner, tschess: self)
        self.castle = Castle(white: white, transitioner: transitioner, tschess: self)
        self.transitioner = transitioner
        
        //self.activityIndicator.isHidden = true
        
        self.labeler = Labeler(
            labelCheck: self.labelCheck,
            labelNote: self.labelNotification,
            labelTurn: self.labelTurnary,
            labelCount: self.labelCountdown)
            //labelTitle: self.labelTitle)
        
        //TODO: REMOVE FOR POPPER
        self.labeler!.removePopper(game: self.game!, player: self.player!)
        
        self.countdown = Countdown(label: self.labelCountdown, date: self.dateTime, id: self.game!.id)
        self.countdown!.setLabelCountdown(update: self.game!.updated, resolved: self.game!.isResolved())
        self.countdown!.setTimer()
    }
    
    // MARK: ATOMIC
    var labeler: Labeler?
    var countdown: Countdown?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.labelElo.text = self.playerOther!.getLabelTextElo()
        //self.labelRank.text = self.playerOther!.getLabelTextRank()
        //self.labelUsername.text = self.playerOther!.username
        //self.imageViewAvatar.image = self.playerOther!.getImageAvatar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.viewBoardHeight.constant = viewBoard.contentSize.height
    }
    
    func pawnPromotion(proposed: [Int]) {
        DispatchQueue.main.async {
            self.promotion.setProposed(proposed: proposed)
            self.present(self.promotion, animated: false, completion: nil)
        }
    }
    
    func flash() {
        let flashFrame = UIView(frame: self.viewBoard.bounds)
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
                return UIColor.white
            }
            return UIColor.black
        }
        if ((index / 8) % 2 == 0) {
            return UIColor.black
        }
        return UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 8
        let dim = UIScreen.main.bounds.width / cellsAcross
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
    
    private func assignCellTschessElement(indexPath: IndexPath) -> UIImage? {
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        if(self.matrix![x][y] != nil){
            return self.matrix![x][y]!.getImageVisible()
        }
        return nil
    }
    
    private func getNormalCoord(indexPath: IndexPath) -> [Int] {
        let username: String = self.player!.username
        let white: Bool = self.game!.getWhite(username: username)
        let x: Int = white ? indexPath.item / 8 : 7 - (indexPath.item / 8)
        let y: Int = white ? indexPath.item % 8 : 7 - (indexPath.item % 8)
        return [x,y]
    }
    
    func renderDialogPoison() {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "PopPoison", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PopPoison") as! PopDismiss
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func renderDialogPassant() {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "PopPassant", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PopPassant") as! PopDismiss
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func renderDialogPopup() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.id = self.player!.id
            _ = UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if (settings.authorizationStatus == .notDetermined) {
                    DispatchQueue.main.async {
                        let storyboard: UIStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "PopUp") as! PopUp
                        viewController.playerSelf = self.player!
                        self.present(viewController, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    
    func renderDialogConfirm() {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "PopConfirm", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PopConfirm") as! PopConfirm
            viewController.game = self.game!
            viewController.playerSelf = self.player!
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! SquareCell
        cell.backgroundColor = assignCellBackgroundColor(index: indexPath.row)
        cell = self.getHighlightCell(indexPath: indexPath, cell: cell)
        
        cell.imageView.image = self.assignCellTschessElement(indexPath: indexPath)
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
    // MARK: PRIME MOVER
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let username: String = self.player!.username
        if(!self.game!.getTurnFlag(username: username)){
            self.flash()
            return
        }
        let x = indexPath.item / 8
        let y = indexPath.item % 8
        //print("x: \(x), y: \(y)")
        
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
                let stateUpdate = SerializerState(white: self.game!.getWhite(username: self.player!.username)).renderServer(state: stateX)
                
                let white: Bool = self.game!.getWhite(username: self.player!.username)
                
                let hx: Int = white ? x : 7 - x
                let hy: Int = white ? y : 7 - y
                let h0: Int = white ? coordinate![0] : 7 - coordinate![0]
                let h1: Int = white ? coordinate![1] : 7 - coordinate![1]
                let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
                
                let requestPayload: [String: Any] = [
                    "id_game": self.game!.id,
                    "state": stateUpdate,
                    "highlight": highlight,
                    "condition": "TBD"]
                DispatchQueue.main.async() {
                    //self.activityIndicator.isHidden = false
                    //self.activityIndicator.startAnimating()
                }
                GameUpdate().success(requestPayload: requestPayload) { (success) in
                    if(!success){
                        //error
                    }
                    self.transitioner!.clearCoordinate()
                    
                    /* * */
                    if(self.player!.isPopup()){
                        self.renderDialogPopup()
                    }
                    /* * */
                    
                }
                return
            }
            //otherwise invalid --> deselect...
            self.matrix = self.transitioner!.deselectHighlight(state0: self.matrix!)
            self.viewBoard.reloadData()
            self.transitioner!.clearCoordinate()
            return
        }
        let state0 = self.game!.getStateClient(username: self.player!.username)
        self.matrix = self.transitioner!.evaluateHighlightSelection(coordinate: [x,y], state0: state0)
        self.viewBoard.reloadData()
    }
    
    
    
    // MARK: POLLING GAME
    @objc func pollingTask() {
        let id_game: String = self.game!.id
        GameRequest().execute(id: id_game) { (game0) in
            if(game0 == nil){
                return
            }
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
                    //self.activityIndicator.stopAnimating()
                    //self.activityIndicator.isHidden = true
                    
                    self.game = game0!
                    
                    let username: String = self.player!.username
                    let matrix: [[Piece?]] = self.game!.getStateClient(username: username)
                    self.matrix = matrix
                    
                    // ~ * ~ //
                    self.setCheckMate()
                    // ~ * ~ //
                    
                    self.viewBoard.reloadData()
                    
                    self.setLabel()
                }
            }
        }
    }
    
    private func setLabel() {
        let check: Bool = self.game!.on_check
        let username: String = self.player!.username
        let condition: String = self.game!.condition
        let turnFlag = self.game!.getTurnFlag(username: username)
        let turnUser = self.game!.getTurnUser()
        let resolved: Bool = self.game!.isResolved()
        if(resolved){
            self.endTimer()
            self.renderDialogConfirm()
            self.menuRefresh()
        }
        //self.labeler!.setResolve(resolved: resolved)
        let winner: Bool = self.game!.getWinner(username: username)
        self.labeler!.setResolve(resolved: resolved, condition: condition, winner: winner)
        self.countdown!.setLabelCountdown(update: self.game!.updated, resolved: resolved)
        self.labeler!.setTurn(resolved: resolved, turnUser: turnUser)
        self.labeler!.setNote(condition: condition, resolved: resolved, turnUser: turnUser, turnFlag: turnFlag)
        self.labeler!.setCheck(check: check)
    }
    
    private func setCheckMate() {
        let czecher: Checker = Checker()
        let affiliation: String = self.game!.getAffiliationOther(username: self.player!.username)
        let king: [Int] = czecher.kingCoordinate(affiliation: affiliation, state: self.matrix!)
        let mate: Bool = czecher.mate(king: king, state: self.matrix!)
        let check: Bool = czecher.other(coordinate: king, state: self.matrix!)
        if (mate) {
            UpdateMate().execute(id: self.game!.id) { (_) in
                self.menuRefresh()
            }
            return
        }
        if (!check) {
            return
        }
        UpdateCheck().execute(id: self.game!.id) { (_) in
        }
        
    }
    
    private func getHighlightCell(indexPath: IndexPath, cell: SquareCell) -> SquareCell {
        let resolved: Bool = self.game!.isResolved()
        let highlight: String = self.game!.highlight
        if(highlight == "TBD" || resolved){
            return self.highlighter.getOrnamentCell(highlight: false, cell: cell)
        }
        let coordHighlight: [[Int]] = self.highlighter.getHighlight(highlight: highlight)
        let coordNormal: [Int] = self.getNormalCoord(indexPath: indexPath)
        return self.highlighter.highlightCoord(coordNormal: coordNormal, coordHighlight: coordHighlight, cell: cell)
    }
    
}
