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
    
    var activeConfigNumber: Int?
    
    public func setActiveConfigNumber(activeConfigNumber: Int){
        self.activeConfigNumber = activeConfigNumber
    }
    
    var playerOther: PlayerCore?
    
    public func setPlayerOther(playerOther: PlayerCore){
        self.playerOther = playerOther
    }
    
    var playerSelf: Player?
    
    public func setPlayerSelf(playerSelf: Player){
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
    
    private func assignHeader() {
        let dataDecoded: Data = Data(base64Encoded: self.playerOther!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = self.playerOther!.getRank()
        self.usernameLabel.text = self.playerOther!.getUsername()
        self.eloLabel.text = self.playerOther!.getElo()
        
        let date: String = self.playerOther!.getDate()
        if(date == "TBD"){
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YY"
            var yayayaya = formatter.string(from: DateTime().currentDate())
            yayayaya.insert("'", at: yayayaya.index(yayayaya.endIndex, offsetBy: -2))
            self.dateLabel.text = yayayaya
        } else {
            //date...
        }
    }
    
    //MARK: Constant
    let DATE_TIME: DateTime = DateTime()
    let REUSE_IDENTIFIER = "cell"
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
        "red_grasshopper",
        "red_arrow"]
    
    //MARK: Layout: Content
       @IBOutlet weak var notificationLabel: UILabel!
       @IBOutlet weak var splitViewHeight0: NSLayoutConstraint!
       @IBOutlet weak var splitViewHeight1: NSLayoutConstraint!
       @IBOutlet weak var splitViewHeight2: NSLayoutConstraint!
       @IBOutlet weak var contentView: UIView!
       @IBOutlet weak var totalPointLabel: UILabel!
       var totalPointValue: Int?
       
       private func setTotalPointValue() {
           let totalPointValue = self.getPointValue(elementMatrix: self.elementMatrixActiv!)
           self.totalPointLabel.text = String(totalPointValue)
       }
       
       @IBOutlet weak var titleLabel: UILabel!
       var titleText: String?
       
       func setTitleText(titleText: String) {
           self.titleText = titleText
       }
       
       //MARK: Input
       @IBOutlet weak var tschessElementCollectionView: UICollectionView!
       @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
       @IBOutlet weak var configCollectionView: DynamicCollectionView!
       
       //MARK: Variables
       var elementMatrixAbort: [[TschessElement?]]?
       var elementMatrixCache: [[TschessElement?]]?
       var elementMatrixActiv: [[TschessElement?]]?
       var selectionElementName: String?
    
    private func getPointValue(elementMatrix: [[TschessElement?]]) -> Int {
        var totalPointValue: Int = 0
        for row in elementMatrix {
            for element in row {
                if(element == nil) {
                    continue
                }
                totalPointValue += Int(element!.getStrength())!
            }
        }
        return totalPointValue
    }
    
    func inExcess(element: TschessElement, elementMatrix: [[TschessElement?]]) -> Bool {
        let pointIncrease = Int(element.strength)!
        let pointValue0 = self.getPointValue(elementMatrix: elementMatrix)
        let pointValue1 = pointValue0 + pointIncrease
        if(pointValue1 > 39){
            return true
        }
        return false
    }
    
    //MARK: Render
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tschessElementCollectionView {
            let elementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TschessElementCell", for: indexPath) as! TschessElementCell
            
            let elementImageIdentifier: String = self.ELEMENT_LIST[indexPath.row]
            let elementImage: UIImage = UIImage(named: elementImageIdentifier)!
            elementCell.configureCell(image: elementImage)
            
            let elementObject: TschessElement = self.generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])!
            elementCell.nameLabel.text = elementObject.name
            elementCell.pointsLabel.text = elementObject.strength
            
            elementCell.imageView.alpha = 1
            elementCell.nameLabel.alpha = 1
            elementCell.pointsLabel.alpha = 1
            if(self.inExcess(element: elementObject, elementMatrix: self.elementMatrixActiv!)){
                elementCell.imageView.alpha = 0.5
                elementCell.nameLabel.alpha = 0.5
                elementCell.pointsLabel.alpha = 0.5
            }
            return elementCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ConfigCollectionViewCell
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
        if(self.elementMatrixActiv![x][y] != nil){
            cell.imageView.image = self.elementMatrixActiv![x][y]!.getImageDefault()
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
        self.elementMatrixCache = self.elementMatrixActiv!
        if collectionView == self.tschessElementCollectionView {
            let tschessElement = generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])
            
            if(self.inExcess(element: tschessElement!, elementMatrix: self.elementMatrixActiv!)){
                return []
            }
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            let imageName = self.imageNameFromElement(tschessElement: tschessElement!)!
            self.selectionElementName = imageName
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
        let tschessElement = self.elementMatrixActiv![x][y]
        if(tschessElement == nil) {
            return []
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        self.elementMatrixActiv![x][y] = nil
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
        /***/
        let imageName = imageNameFromElement(tschessElement: tschessElement!)!
        self.selectionElementName = imageName
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
        for row in self.elementMatrixActiv! {
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
        self.elementMatrixActiv = self.elementMatrixCache
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
        
        let occupant: TschessElement? = self.elementMatrixActiv![x][y]
        if(occupant != nil){
            if(occupant!.name.lowercased().contains("king")){
                self.elementMatrixActiv = self.elementMatrixCache
                configCollectionView.reloadData()
                return
            }
        }
        let tschessElement = generateTschessElement(name: self.selectionElementName!)
        self.elementMatrixActiv![x][y] = tschessElement!
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
        if(self.selectionElementName != nil){
            if(self.selectionElementName!.lowercased().contains("king")){
                self.elementMatrixActiv = self.elementMatrixCache
                configCollectionView.reloadData() //give a warning also... feedback
            }
        }
        self.selectionElementName = nil
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.splitView2.addInteraction(UIDropInteraction(delegate: self))
        self.headerView.addInteraction(UIDropInteraction(delegate: self))
        
        self.tabBarMenu.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let totalContentHeight = self.contentView.frame.size.height - 8
        self.splitViewHeight0.constant = totalContentHeight/3
        self.splitViewHeight1.constant = totalContentHeight/3
        self.splitViewHeight2.constant = totalContentHeight/3
        
        self.activityIndicator.isHidden = true
        
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = true
        self.configCollectionView.alwaysBounceVertical = false
        self.configCollectionView.bounces = false
        
        self.tschessElementCollectionView.isUserInteractionEnabled = true
        self.tschessElementCollectionView.dragInteractionEnabled = true
        
        switch self.activeConfigNumber {
        case 1:
            self.elementMatrixActiv = self.playerSelf!.getConfig1()
            self.elementMatrixAbort = self.elementMatrixActiv
            break
        case 2:
            self.elementMatrixActiv = self.playerSelf!.getConfig2()
            self.elementMatrixAbort = self.elementMatrixActiv
            break
        default:
            self.elementMatrixActiv = self.playerSelf!.getConfig0()
            self.elementMatrixAbort = self.elementMatrixActiv
        }
        self.titleLabel.text = self.titleText
        self.assignHeader()
        
        self.notificationLabel.isHidden = true
        self.setTotalPointValue()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
    }
}

//MARK: DataSource
extension EditOther: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.tschessElementCollectionView {
            return ELEMENT_LIST.count
        }
        return PLACEMENT_LIST.count
    }
}

//MARK: FlowLayout
extension EditOther: UICollectionViewDelegateFlowLayout {
    
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

extension EditOther: UICollectionViewDelegate {
    
    func generateTschessElement(name: String) -> TschessElement? {
        if(name.contains("arrow")){
            return ArrowPawn()
        }
        if(name.contains("grasshopper")){
            return Grasshopper()
        }
        if(name.contains("hunter")){
            return Hunter()
        }
        if(name.contains("landmine")){
            return LandminePawn()
        }
        if(name.contains("medusa")){
            return Medusa()
        }
        if(name.contains("spy")){
            return Spy()
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
    
    func imageNameFromElement(tschessElement: TschessElement) -> String? {
        if(tschessElement.name == ArrowPawn().name){
            return "red_arrow"
        }
        if(tschessElement.name == Grasshopper().name){
            return "red_grasshopper"
        }
        if(tschessElement.name == Hunter().name){
            return "red_hunter"
        }
        if(tschessElement.name == LandminePawn().name){
            return "red_landmine_pawn"
        }
        if(tschessElement.name == Medusa().name){
            return "red_medusa"
        }
        if(tschessElement.name == Spy().name){
            return "red_spy"
        }
        if(tschessElement.name == Amazon().name){
            return "red_amazon"
        }
        if(tschessElement.name == Pawn().name){
            return "red_pawn"
        }
        if(tschessElement.name == Knight().name){
            return "red_knight"
        }
        if(tschessElement.name == Bishop().name){
            return "red_bishop"
        }
        if(tschessElement.name == Rook().name){
            return "red_rook"
        }
        if(tschessElement.name == Queen().name){
            return "red_queen"
        }
        if(tschessElement.name == King().name){
            return "red_king"
        }
        return nil
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        if(self.titleText == "new challenge"){
            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            viewController.setPlayer(player: self.playerSelf!)
            viewController.setOpponent(opponent: self.playerOther!)
            viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
            
            let gameModel = Game(opponent: self.playerOther!) //TODO: !!!
            viewController.setGameModel(gameModel: gameModel)
            
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        if(self.titleText == "quick play"){
            let storyboard: UIStoryboard = UIStoryboard(name: "Quick", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Quick") as! Quick
            viewController.setPlayer(player: self.playerSelf!)
            viewController.setOpponent(opponent: self.playerOther!)
            viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        //if(self.titleText!.contains("play!")){
            let storyboard: UIStoryboard = UIStoryboard(name: "Ack", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Ack") as! Ack
            viewController.setPlayer(player: self.playerSelf!)
            viewController.setOpponent(opponent: self.playerOther!) // <-- REDUNDANT
            let gameModel = Game(opponent: self.playerOther!) //TODO: !!! // <-- REDUNDANT
            viewController.setGameModel(gameModel: gameModel) // <-- REDUNDANT
            UIApplication.shared.keyWindow?.rootViewController = viewController
            //return
        //}
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0://back
            tabBar.selectedItem = nil
            if(self.titleText == "new challenge"){
                let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
                viewController.setPlayer(player: self.playerSelf!)
                viewController.setOpponent(opponent: self.playerOther!)
                viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
                
                let gameModel = Game(opponent: self.playerOther!) //TODO: !!!
                viewController.setGameModel(gameModel: gameModel)
                
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            }
            if(self.titleText == "quick play"){
                let storyboard: UIStoryboard = UIStoryboard(name: "Quick", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Quick") as! Quick
                viewController.setPlayer(player: self.playerSelf!)
                viewController.setOpponent(opponent: self.playerOther!)
                viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            }
            //if(self.titleText!.contains("play!")){
                let storyboard: UIStoryboard = UIStoryboard(name: "Ack", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Ack") as! Ack
                viewController.setPlayer(player: self.playerSelf!)
                viewController.setOpponent(opponent: self.playerOther!) // <-- REDUNDANT
                let gameModel = Game(opponent: self.playerOther!) //TODO: !!! // <-- REDUNDANT
                viewController.setGameModel(gameModel: gameModel) // <-- REDUNDANT
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            //}
        default: //save...
            tabBar.selectedItem = nil
            
            DispatchQueue.main.async() {
                self.activityIndicator!.isHidden = false
                self.activityIndicator!.startAnimating()
            }
            let id = self.playerSelf!.getId()
            let config = ConfigSerializer().serializeConfiguration(savedConfigurationMatrix: self.elementMatrixActiv!)
            var updateConfig = [
                "id": id,
                "config": config,
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
            UpdateConfig().execute(requestPayload: updateConfig, player: self.playerSelf!) { (result) in
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
                        viewController.setPlayer(player: self.playerSelf!)
                        viewController.setOpponent(opponent: self.playerOther!)
                        viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
                        //
                        let gameModel = Game(opponent: self.playerOther!) //TODO: !!!
                        viewController.setGameModel(gameModel: gameModel)
                        //
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                        return
                    }
                    if(self.titleText == "quick play"){
                        let storyboard: UIStoryboard = UIStoryboard(name: "Quick", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "Quick") as! Quick
                        viewController.setPlayer(player: self.playerSelf!)
                        viewController.setOpponent(opponent: self.playerOther!)
                        viewController.setActivateBackConfig(activateBackConfig: self.activeConfigNumber!)
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                        return
                    }
                    //if(self.titleText!.contains("play!")){
                        let storyboard: UIStoryboard = UIStoryboard(name: "Ack", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "Ack") as! Ack
                        viewController.setPlayer(player: self.playerSelf!)
                        viewController.setOpponent(opponent: self.playerOther!) // <-- REDUNDANT
                        let gameModel = Game(opponent: self.playerOther!) //TODO: !!! // <-- REDUNDANT
                        viewController.setGameModel(gameModel: gameModel) // <-- REDUNDANT
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                        //return
                    //}
                }
                
            }
        }
    }
}
