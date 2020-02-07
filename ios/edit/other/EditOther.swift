//
//  Edit.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

//MARK: DragDelegate
extension EditOther: UICollectionViewDragDelegate {}

//MARK: DropDelegate
extension EditOther: UICollectionViewDropDelegate {}

class EditOther: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
    var BACK: String?
    
    public func setBACK(BACK: String){
        self.BACK = BACK
    }
    
    var activeConfigNumber: Int?
    
    public func setActiveConfigNumber(activeConfigNumber: Int){
        self.activeConfigNumber = activeConfigNumber
    }
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    @IBOutlet weak var dropViewTop0: UIView!
    @IBOutlet weak var dropViewTop1: UIView!
    @IBOutlet weak var dropViewBottom0: UIView!
    @IBOutlet weak var splitView2: UIView!
    
    //MARK: Layout: Core
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerView: UIView!
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
        "red_landmine_pawn",
        "red_hunter",
        "red_grasshopper"]
    
    //MARK: Layout: Content
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var splitViewHeight0: NSLayoutConstraint!
    @IBOutlet weak var splitViewHeight1: NSLayoutConstraint!
    @IBOutlet weak var splitViewHeight2: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var totalPointLabel: UILabel!
    var totalPointValue: Int?
    
    private func setTotalPointValue() {
        let totalPointValue = self.getPointValue(config: self.configActiv!)
        self.totalPointLabel.text = String(totalPointValue)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    var titleText: String?
    
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
            
            let elementObject: Piece = self.generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])!
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
        self.configCache = self.configActiv!
        if collectionView == self.pieceCollectionView {
            let tschessElement = generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])
            
            if(self.inExcess(piece: tschessElement!, config: self.configActiv!)){
                return []
            }
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            let imageName = self.imageNameFromPiece(piece: tschessElement!)!
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
        let imageName = imageNameFromPiece(piece: tschessElement!)!
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
        let tschessElement = generateTschessElement(name: self.selectionPieceName!)
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
        self.boardViewConfig.delegate = self
        self.boardViewConfig.dataSource = self
        self.boardViewConfig.dragDelegate = self
        self.boardViewConfig.dropDelegate = self
        
        self.pieceCollectionView.delegate = self
        self.pieceCollectionView.dataSource = self
        self.pieceCollectionView.dragDelegate = self
        
        self.pieceCollectionView.addInteraction(UIDropInteraction(delegate: self))
        self.dropViewBottom0.addInteraction(UIDropInteraction(delegate: self))
        self.dropViewTop0.addInteraction(UIDropInteraction(delegate: self))
        self.dropViewTop1.addInteraction(UIDropInteraction(delegate: self))
        self.splitView2.addInteraction(UIDropInteraction(delegate: self))
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let totalContentHeight = self.contentView.frame.size.height - 8
        self.splitViewHeight0.constant = totalContentHeight/3
        self.splitViewHeight1.constant = totalContentHeight/3
        self.splitViewHeight2.constant = totalContentHeight/3
        
        self.activityIndicator.isHidden = true
        
        self.boardViewConfig.isUserInteractionEnabled = true
        self.boardViewConfig.dragInteractionEnabled = true
        self.boardViewConfig.alwaysBounceVertical = false
        self.boardViewConfig.bounces = false
        
        self.pieceCollectionView.isUserInteractionEnabled = true
        self.pieceCollectionView.dragInteractionEnabled = true
        
        switch self.activeConfigNumber {
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
        
        self.notificationLabel.isHidden = true
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
    
    func generateTschessElement(name: String) -> Piece? {
        if(name.contains("grasshopper")){
            return Grasshopper()
        }
        if(name.contains("hunter")){
            return Hunter()
        }
        if(name.contains("poison")){
            return PoisonPawn()
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
    
    func imageNameFromPiece(piece: Piece) -> String? {
        if(piece.name == Grasshopper().name){
            return "red_grasshopper"
        }
        if(piece.name == Hunter().name){
            return "red_hunter"
        }
        if(piece.name == PoisonPawn().name){
            return "red_landmine_pawn"
        }
        if(piece.name == Amazon().name){
            return "red_amazon"
        }
        if(piece.name == Pawn().name){
            return "red_pawn"
        }
        if(piece.name == Knight().name){
            return "red_knight"
        }
        if(piece.name == Bishop().name){
            return "red_bishop"
        }
        if(piece.name == Rook().name){
            return "red_rook"
        }
        if(piece.name == Queen().name){
            return "red_queen"
        }
        if(piece.name == King().name){
            return "red_king"
        }
        return nil
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        if(self.BACK == "HOME"){
            DispatchQueue.main.async {
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
                homeViewController.setPlayer(player: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = homeViewController
            }
            return
        }
        if(self.titleText == "challenge"){
            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
            viewController.setPlayerOther(playerOther: self.playerOther!)
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            //viewController.setGameModel(gameModel: gameModel)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        if(self.titleText == "quick play"){
            let storyboard: UIStoryboard = UIStoryboard(name: "Play", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Play") as! Play
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            viewController.setPlayerOther(playerOther: self.playerOther!)
            viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        //if(self.titleText!.contains("play!")){
        let storyboard: UIStoryboard = UIStoryboard(name: "Ack", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Ack") as! Ack
        if(self.activeConfigNumber! == 0){
            viewController.activeConfigNumber.text = "0̸"
        }
        if(self.activeConfigNumber! == 1){
            viewController.activeConfigNumber.text = "1"
        }
        if(self.activeConfigNumber! == 2){
            viewController.activeConfigNumber.text = "2"
        }
        viewController.setPlayerOther(playerOther: self.playerOther!)
        viewController.setPlayerSelf(playerSelf: self.playerSelf!)
        UIApplication.shared.keyWindow?.rootViewController = viewController
        //return
        //}
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0://back
            tabBar.selectedItem = nil
            if(self.titleText == "challenge"){
                let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.playerOther!)
                viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            }
            if(self.titleText == "quick play"){
                let storyboard: UIStoryboard = UIStoryboard(name: "Play", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Play") as! Play
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.playerOther!)
                viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            }
            //if(self.titleText!.contains("play!")){
            let storyboard: UIStoryboard = UIStoryboard(name: "Ack", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Ack") as! Ack
            viewController.setPlayerOther(playerOther: self.playerOther!)
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            if(self.activeConfigNumber! == 0){
                viewController.configActive = 0
            }
            if(self.activeConfigNumber! == 1){
                viewController.configActive = 1
            }
            if(self.activeConfigNumber! == 2){
                viewController.configActive = 2
            }
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        //}
        default: //save...
            tabBar.selectedItem = nil
            
            DispatchQueue.main.async() {
                self.activityIndicator!.isHidden = false
                self.activityIndicator!.startAnimating()
            }
            let id = self.playerSelf!.id
            
            //let config = ConfigSerializer().serializeConfiguration(savedConfigurationMatrix: self.elementMatrixActiv!)
            var updateConfig = [
                "id": id,
                "config": self.playerSelf!.setConfig(index: self.activeConfigNumber!, config: self.configActiv!),
                "updated": self.DATE_TIME.currentDateString()
                ] as [String: Any]
            
            var index: Int = 0
            if(self.activeConfigNumber! == 1){
                index = 1
            }
            if(self.activeConfigNumber! == 2){
                index = 2
            }
            updateConfig["index"] = index
            UpdateConfig().execute(requestPayload: updateConfig) { (result) in
                if result == nil {
                    print("error!") // print a popup
                }
                self.playerSelf = result!
                DispatchQueue.main.async() {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    if(self.titleText == "new challenge"){
                        
                        let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
                        viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                        viewController.setPlayerOther(playerOther: self.playerOther!)
                        viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                        
                        return
                    }
                    if(self.titleText == "quick play"){
                        let storyboard: UIStoryboard = UIStoryboard(name: "Play", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "Play") as! Play
                        viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                        viewController.setPlayerOther(playerOther: self.playerOther!)
                        viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                        return
                    }
                    let storyboard: UIStoryboard = UIStoryboard(name: "Ack", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Ack") as! Ack
                    viewController.setPlayerOther(playerOther: self.playerOther!)
                    viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                    if(self.activeConfigNumber! == 0){
                        viewController.configActive = 0
                    }
                    if(self.activeConfigNumber! == 1){
                        viewController.configActive = 1
                    }
                    if(self.activeConfigNumber! == 2){
                        viewController.configActive = 2
                    }
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    
                }
            }
        }
    }
}
