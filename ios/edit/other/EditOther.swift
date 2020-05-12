//
//  Edit.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EditOther: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
    /* - * - */
    
    
    
    var playerSelf: EntityPlayer?
    
    
    var gameTschess: EntityGame?
    
    
    
    var selection: Int? = nil
    
    public func setSelection(selection: Int){
        self.selection = selection
    }
    
    public func setBACK(BACK: String){
        self.BACK = BACK
    }
    
    
    
    /* - * - */
    
    
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    
    
    public func setGameTschess(gameTschess: EntityGame) {
        self.gameTschess = gameTschess
    }
    
    //MARK: Layout: Core
    @IBOutlet weak var titleLabel: UILabel!
    var titleText: String?
    @IBOutlet weak var backButton: UIButton!
    var BACK: String?
    @IBOutlet weak var headerView: UIView!
    var playerOther: EntityPlayer?
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public func renderHeaderOther() {
        self.avatarImageView.image = self.playerOther!.getImageAvatar()
        self.usernameLabel.text = self.playerOther!.username
        self.eloLabel.text = self.playerOther!.getLabelTextElo()
        self.rankLabel.text = self.playerOther!.getLabelTextRank()
        self.dateLabel.text = self.playerOther!.getLabelTextDate()
    }
    
    //MARK: Constant
    let DATE_TIME: DateTime = DateTime()
    let REUSE_IDENTIFIER = "square"
    let PLACEMENT_LIST = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    let ELEMENT_LIST = [
        "red_pawn",
        "red_knight",
        "red_bishop",
        "red_rook",
        "red_queen",
        "red_amazon",
        "red_hunter",
        "red_poison"]
    
    //MARK: Layout: Content
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var totalPointLabel: UILabel!
    var totalPointValue: Int?
    
    private func setTotalPointValue() {
        let totalPointValue = self.getPointValue(config: self.configActiv!)
        self.totalPointLabel.text = String(totalPointValue)
    }
    
    func setTitleText(titleText: String) {
        self.titleText = titleText
    }
    
    //MARK: Input
    @IBOutlet weak var pieceCollectionView: UICollectionView!
    @IBOutlet weak var pieceCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var boardViewConfigHeight: NSLayoutConstraint!
    @IBOutlet weak var boardViewConfig: BoardView!
    
    //MARK: Variables
    var configAbort: [[Piece?]]?
    var configCache: [[Piece?]]?
    var configActiv: [[Piece?]]?
    var selectionPieceName: String?
    
    private func getPointValue(config: [[Piece?]]) -> Int {
        var totalPointValue: Int = 0
        for row in config {
            for piece in row {
                if(piece == nil) {
                    continue
                }
                totalPointValue += Int(piece!.getStrength())!
            }
        }
        return totalPointValue
    }
    
    func inExcess(piece: Piece, config: [[Piece?]]) -> Bool {
        let pointIncrease = Int(piece.strength)!
        let pointValue0 = self.getPointValue(config: config)
        let pointValue1 = pointValue0 + pointIncrease
        if(pointValue1 > 39){
            return true
        }
        return false
    }
    
    //MARK: Render
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.pieceCollectionView {
            let elementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConfigCell", for: indexPath) as! ConfigCell
            
            let elementImageIdentifier: String = self.ELEMENT_LIST[indexPath.row]
            let elementImage: UIImage = UIImage(named: elementImageIdentifier)!
            elementCell.configureCell(image: elementImage)
            
            let elementObject: Piece = Edit().generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])!
            elementCell.nameLabel.text = elementObject.name
            elementCell.pointsLabel.text = elementObject.strength
            
            elementCell.imageView.alpha = 1
            elementCell.nameLabel.alpha = 1
            elementCell.pointsLabel.alpha = 1
            if(self.inExcess(piece: elementObject, config: self.configActiv!)){
                elementCell.imageView.alpha = 0.5
                elementCell.nameLabel.alpha = 0.5
                elementCell.pointsLabel.alpha = 0.5
            }
            return elementCell
        }
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
        if(self.configActiv![x][y] != nil){
            cell.imageView.image = self.configActiv![x][y]!.getImageDefault()
        }
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?{
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = UIColor.clear
        return previewParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return self.collectionView(collectionView, itemsForBeginning: session, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        //self.notificationLabel.isHidden = true
        self.configCache = self.configActiv!
        if collectionView == self.pieceCollectionView {
            let tschessElement = Edit().generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])
            
            if(self.inExcess(piece: tschessElement!, config: self.configActiv!)){
                return []
            }
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            let imageName = Edit().imageNameFromPiece(piece: tschessElement!)!
            self.selectionPieceName = imageName
            let itemProvider = NSItemProvider(object: UIImage(named: imageName)!)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.previewProvider = {
                () -> UIDragPreview? in
                let imageView = UIImageView(image: UIImage(named: imageName)!)
                imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                let previewParameters = UIDragPreviewParameters()
                previewParameters.backgroundColor = UIColor.clear
                return UIDragPreview(view: imageView, parameters: previewParameters)
            }
            self.setTotalPointValue()
            return [dragItem]
        }
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        let tschessElement = self.configActiv![x][y]
        if(tschessElement == nil) {
            return []
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        self.configActiv![x][y] = nil
        self.boardViewConfig.reloadData()
        self.pieceCollectionView.reloadData()
        /***/
        let imageName = Edit().imageNameFromPiece(piece: tschessElement!)!
        self.selectionPieceName = imageName
        let itemProvider = NSItemProvider(object: UIImage(named: imageName)!)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.previewProvider = {
            () -> UIDragPreview? in
            let imageView = UIImageView(image: UIImage(named: imageName)!)
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            let previewParameters = UIDragPreviewParameters()
            previewParameters.backgroundColor = UIColor.clear
            return UIDragPreview(view: imageView, parameters: previewParameters)
        }
        self.setTotalPointValue()
        return [dragItem]
    }
    
    internal func collectionView(_: UICollectionView, dragSessionDidEnd: UIDragSession){
        self.pieceCollectionView.reloadData()
        self.setTotalPointValue()
        //self.notificationLabel.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView,  dropSessionDidEnd session: UIDropSession) {
        var kingAbsent: Bool = true
        for row in self.configActiv! {
            for tschessElement in row {
                if(tschessElement == nil){
                    continue
                }
                if(tschessElement!.name.lowercased().contains("king")){
                    kingAbsent = false
                }
            }
        }
        if(!kingAbsent){
            return
        }
        self.configActiv = self.configCache
        self.boardViewConfig.reloadData()
        self.setTotalPointValue()
        self.pieceCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let x = coordinator.destinationIndexPath!.row / 8
        let y = coordinator.destinationIndexPath!.row % 8
        
        let occupant: Piece? = self.configActiv![x][y]
        if(occupant != nil){
            if(occupant!.name.lowercased().contains("king")){
                self.configActiv = self.configCache
                boardViewConfig.reloadData()
                return
            }
        }
        let tschessElement = Edit().generateTschessElement(name: self.selectionPieceName!)
        self.configActiv![x][y] = tschessElement!
        self.setTotalPointValue()
        self.boardViewConfig.reloadData()
        self.pieceCollectionView.reloadData()
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if(self.selectionPieceName != nil){
            if(self.selectionPieceName!.lowercased().contains("king")){
                self.configActiv = self.configCache
                boardViewConfig.reloadData() //give a warning also... feedback
            }
        }
        self.selectionPieceName = nil
        self.boardViewConfig.reloadData()
        self.pieceCollectionView.reloadData()
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.boardViewConfig.isHidden = true
        
        self.boardViewConfig.delegate = self
        self.boardViewConfig.dataSource = self
        self.boardViewConfig.dragDelegate = self
        self.boardViewConfig.dropDelegate = self
        
        self.pieceCollectionView.delegate = self
        self.pieceCollectionView.dataSource = self
        self.pieceCollectionView.dragDelegate = self
        
        self.pieceCollectionView.addInteraction(UIDropInteraction(delegate: self))
      
        self.contentView.addInteraction(UIDropInteraction(delegate: self))
      
        self.headerView.addInteraction(UIDropInteraction(delegate: self))
        
        self.tabBarMenu.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.boardViewConfig.reloadData()
        
        if let longPressRecognizer = self.boardViewConfig.gestureRecognizers?.compactMap({ $0 as? UILongPressGestureRecognizer}).first {
            longPressRecognizer.minimumPressDuration = 0.1 // your custom value
        }
        
        if let longPressRecognizer = self.pieceCollectionView.gestureRecognizers?.compactMap({ $0 as? UILongPressGestureRecognizer}).first {
            longPressRecognizer.minimumPressDuration = 0.1 // your custom value
        }
        
        self.boardViewConfig.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activityIndicator.isHidden = true
        
        self.boardViewConfig.isUserInteractionEnabled = true
        self.boardViewConfig.dragInteractionEnabled = true
        self.boardViewConfig.alwaysBounceVertical = false
        self.boardViewConfig.bounces = false
        
        self.pieceCollectionView.isUserInteractionEnabled = true
        self.pieceCollectionView.dragInteractionEnabled = true
        
        switch self.selection! {
        case 1:
            self.configActiv = self.playerSelf!.getConfig(index: 1)
            self.configAbort = self.configActiv
            break
        case 2:
            self.configActiv = self.playerSelf!.getConfig(index: 2)
            self.configAbort = self.configActiv
            break
        default:
            self.configActiv = self.playerSelf!.getConfig(index: 0)
            self.configAbort = self.configActiv
        }
        self.titleLabel.text = self.titleText
        self.renderHeaderOther()
        
        //self.notificationLabel.isHidden = true
        //self.notificationLabel.text = "click - hold to engage - drag"
        self.setTotalPointValue()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.boardViewConfigHeight.constant = boardViewConfig.contentSize.height
    }
}

//MARK: DataSource
extension EditOther: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.pieceCollectionView {
            return ELEMENT_LIST.count
        }
        return PLACEMENT_LIST.count
    }
}

//MARK: FlowLayout
extension EditOther: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.pieceCollectionView {
            return CGSize(width: 100, height: 150)
        }
        let cellsAcross: CGFloat = 8
        let dim = collectionView.frame.width / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.pieceCollectionView {
            return 8
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension EditOther: UICollectionViewDelegate {
    
    @IBAction func backButtonClick(_ sender: Any) {
        if(self.BACK == "PLAY"){
            DispatchQueue.main.async {
                let screenSize: CGRect = UIScreen.main.bounds
                let height = screenSize.height
                SelectPlay().execute(selection: self.selection!, playerSelf: self.playerSelf!, playerOther: self.playerOther!, height: height)
            }
            return
        }
        if(self.BACK == "CHALLENGE"){
            DispatchQueue.main.async {
                let screenSize: CGRect = UIScreen.main.bounds
                let height = screenSize.height
                SelectChallenge().execute(selection: self.selection!, playerSelf: self.playerSelf!, playerOther: self.playerOther!, BACK: "HOME", height: height)
            }
            return
        }
        if(self.BACK == "ACK"){
            DispatchQueue.main.async {
                let screenSize: CGRect = UIScreen.main.bounds
                let height = screenSize.height
                SelectAck().execute(selection: self.selection!, playerSelf: self.playerSelf!, playerOther: self.playerOther!, game: self.gameTschess!, height: height)
            }
            return
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.selectedItem = nil
        
        switch item.tag {
        case 0:
            self.backButtonClick("~")
        case 2:
            //print("fuck") //show the popup...
            let storyboard: UIStoryboard = UIStoryboard(name: "Help", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Help") as! Help
            self.present(viewController, animated: true, completion: nil)
        default:
            DispatchQueue.main.async() {
                self.activityIndicator!.isHidden = false
                self.activityIndicator!.startAnimating()
            }
            let id = self.playerSelf!.id
            let config = self.playerSelf!.setConfig(index: self.selection!, config: self.configActiv!)
            
            let updateConfig = ["id": id, "config": config, "index": self.selection!] as [String: Any]
            
            UpdateConfig().execute(requestPayload: updateConfig) { (result) in
                if result == nil {
                    print("error!") // print a popup
                    self.backButtonClick("~")
                }
                DispatchQueue.main.async() {
                    self.activityIndicator!.isHidden = true
                    self.activityIndicator!.stopAnimating()
                }
                self.playerSelf = result!
                self.backButtonClick("~")
            }
        }
    }
}

//MARK: DragDelegate
extension EditOther: UICollectionViewDragDelegate {}

//MARK: DropDelegate
extension EditOther: UICollectionViewDropDelegate {}
