//
//  Edit.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EditSelf: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
    /* - * - */
    
    var selection: Int? = nil
    
    public func setSelection(selection: Int){
        self.selection = selection
    }
    
    var BACK: String?
    
    public func setBACK(BACK: String){
        self.BACK = BACK
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleText: String?
    
    func setTitleText(titleText: String) {
        self.titleText = titleText
    }
    
    /* - * - */
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    @IBOutlet weak var dropViewTop0: UIView!
    @IBOutlet weak var dropViewTop1: UIView!
    @IBOutlet weak var dropViewBottom0: UIView!
    
    //MARK: Layout: Core
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    //MARK: Layout: Core
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
        self.displacementImage.image = self.playerSelf!.getImageDisp()!
        self.displacementImage.tintColor = self.playerSelf!.tintColor
    }
    
    //MARK: Constant
    let DATE_TIME: DateTime = DateTime()
    let REUSE_IDENTIFIER = "square"
    let PLACEMENT_LIST = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    //    let ELEMENT_LIST = [
    //        "red_pawn",
    //        "red_knight",
    //        "red_bishop",
    //        "red_rook",
    //        "red_queen",
    //        "red_amazon",
    //        "red_landmine_pawn",
    //        "red_hunter",
    //        "red_grasshopper"]
    let ELEMENT_LIST = [
        "red_pawn",
        "red_knight",
        "red_bishop",
        "red_rook",
        "red_queen",
        "red_amazon",
        "red_hunter"]
    
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
    
    //MARK: Input
    @IBOutlet weak var tschessElementCollectionView: UICollectionView!
    @IBOutlet weak var tschessElementCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var configCollectionView: BoardView!
    
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
        if collectionView == self.tschessElementCollectionView {
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
        if collectionView == self.tschessElementCollectionView {
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
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
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
        self.tschessElementCollectionView.reloadData()
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
        self.configCollectionView.reloadData()
        self.setTotalPointValue()
        self.tschessElementCollectionView.reloadData()
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
                configCollectionView.reloadData()
                return
            }
        }
        let tschessElement = generateTschessElement(name: self.selectionPieceName!)
        self.configActiv![x][y] = tschessElement!
        self.setTotalPointValue()
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
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
                configCollectionView.reloadData() //give a warning also... feedback
            }
        }
        self.selectionPieceName = nil
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configCollectionView.isHidden = true
        
        self.configCollectionView.delegate = self
        self.configCollectionView.dataSource = self
        self.configCollectionView.dragDelegate = self
        self.configCollectionView.dropDelegate = self
        
        self.tschessElementCollectionView.delegate = self
        self.tschessElementCollectionView.dataSource = self
        self.tschessElementCollectionView.dragDelegate = self
        
        self.tschessElementCollectionView.addInteraction(UIDropInteraction(delegate: self))
        self.dropViewBottom0.addInteraction(UIDropInteraction(delegate: self))
        self.dropViewTop0.addInteraction(UIDropInteraction(delegate: self))
        self.dropViewTop1.addInteraction(UIDropInteraction(delegate: self))
        //self.splitView2.addInteraction(UIDropInteraction(delegate: self))
        self.headerView.addInteraction(UIDropInteraction(delegate: self))
        
        self.tabBarMenu.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configCollectionView.reloadData()
        
        if let longPressRecognizer = self.configCollectionView.gestureRecognizers?.compactMap({ $0 as? UILongPressGestureRecognizer}).first {
            longPressRecognizer.minimumPressDuration = 0.1 // your custom value
        }
        
        if let longPressRecognizer = self.tschessElementCollectionView.gestureRecognizers?.compactMap({ $0 as? UILongPressGestureRecognizer}).first {
            longPressRecognizer.minimumPressDuration = 0.1 // your custom value
        }
        
        self.configCollectionView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //let totalContentHeight = self.contentView.frame.size.height - 8
        //self.splitViewHeight0.constant = totalContentHeight/3
        //self.splitViewHeight1.constant = totalContentHeight/3
        //self.splitViewHeight2.constant = totalContentHeight/3
        
        self.activityIndicator.isHidden = true
        
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = true
        self.configCollectionView.alwaysBounceVertical = false
        self.configCollectionView.bounces = false
        
        self.tschessElementCollectionView.isUserInteractionEnabled = true
        self.tschessElementCollectionView.dragInteractionEnabled = true
        
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
        self.renderHeader()
        
        self.notificationLabel.isHidden = true
        self.setTotalPointValue()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
    }
}

//MARK: DataSource
extension EditSelf: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.tschessElementCollectionView {
            return ELEMENT_LIST.count
        }
        return PLACEMENT_LIST.count
    }
}

//MARK: FlowLayout
extension EditSelf: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.tschessElementCollectionView {
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
        if collectionView == self.tschessElementCollectionView {
            return 8
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension EditSelf: UICollectionViewDelegate {
    
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
        DispatchQueue.main.async {
            let height: CGFloat = self.view.frame.size.height
            SelectConfig().execute(player: self.playerSelf!, height: height)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.selectedItem = nil
        
        switch item.tag {
        case 0:
            self.backButtonClick("~")
            return
        default:
            DispatchQueue.main.async() {
                self.activityIndicator!.isHidden = false
                self.activityIndicator!.startAnimating()
            }
            let id = self.playerSelf!.id
            let config = self.playerSelf!.setConfig(index: self.selection!, config: self.configActiv!)
            
            let updateConfig = ["id": id, "config": config, "index": self.selection!] as [String: Any]
            
            UpdateConfig().execute(requestPayload: updateConfig) { (result) in
                if result == result {
                    DispatchQueue.main.async() {
                        self.activityIndicator!.isHidden = true
                        self.activityIndicator!.stopAnimating()
                        self.playerSelf = result!
                        self.backButtonClick("~")
                    }
                }
                //ERROR
                DispatchQueue.main.async() {
                    self.activityIndicator!.isHidden = false
                    self.activityIndicator!.startAnimating()
                    self.backButtonClick("~")
                }
            }
        }
    }
}


//MARK: DragDelegate
extension EditSelf: UICollectionViewDragDelegate {}

//MARK: DropDelegate
extension EditSelf: UICollectionViewDropDelegate {}
