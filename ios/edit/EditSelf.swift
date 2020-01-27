//
//  Edit.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit //

class EditSelf: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
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
    
    //MARK: Layout: Header
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    //MARK: Layout: Menu
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
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
    var points: Int?
    
    //MARK: Lifecycle
    
    private func assignHeader() {
       let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = self.player!.getRank()
        self.usernameLabel.text = self.player!.getUsername()
        self.eloLabel.text = self.player!.getElo()
        self.displacementLabel.text = String(abs(Int(self.player!.getDisp())!))
        let disp: Int = Int(self.player!.getDisp())!
        if(disp >= 0){
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.up")!
                self.displacementImage.image = image
                self.displacementImage.tintColor = .green
            }
            return
        }
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "arrow.down")!
            self.displacementImage.image = image
            self.displacementImage.tintColor = .red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCollectionView.delegate = self
        self.configCollectionView.dataSource = self
        self.configCollectionView.dragDelegate = self
        self.configCollectionView.dropDelegate = self
        self.tschessElementCollectionView.delegate = self
        self.tschessElementCollectionView.dataSource = self
        self.tschessElementCollectionView.dragDelegate = self
        self.tabBarMenu.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.isHidden = true
        
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = true
        self.configCollectionView.alwaysBounceVertical = false
        self.configCollectionView.bounces = false
        
        self.tschessElementCollectionView.isUserInteractionEnabled = true
        self.tschessElementCollectionView.dragInteractionEnabled = true
        
        switch self.titleText {
        case "config. 1":
            self.elementMatrixActiv = self.player!.getConfig1()
            self.elementMatrixAbort = self.elementMatrixActiv
            break
        case "config. 2":
            self.elementMatrixActiv = self.player!.getConfig2()
            self.elementMatrixAbort = self.elementMatrixActiv
            break
        default:
            self.elementMatrixActiv = self.player!.getConfig0()
            self.elementMatrixAbort = self.elementMatrixActiv
        }
        self.titleLabel.text = self.titleText
        self.assignHeader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
    }
    
    @objc func kingNotificationGesture() {
        //self.pointsLabel.text = "\(self.generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!))/39"
        //self.pointsView.isHidden = false
        //self.notificationLabel.isHidden = true
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
    
    func disactivated(tschessElement: TschessElement) -> Bool {
        let pointsCurrent = self.generatePointsTotal(tschessElementMatrix: self.elementMatrixActiv!)
        let pointsNew = pointsCurrent + Int(tschessElement.strength)!
        if(pointsNew > 39){
            return true
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tschessElementCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TschessElementCell", for: indexPath) as! TschessElementCell
            cell.configureCell(image: UIImage(named: self.ELEMENT_LIST[indexPath.row])!)
            let tschessElement = generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])
            cell.nameLabel.text = tschessElement!.name
            cell.pointsLabel.text = tschessElement!.strength
            cell.imageView.alpha = 1
            cell.nameLabel.alpha = 1
            cell.pointsLabel.alpha = 1
            if(self.disactivated(tschessElement: tschessElement!)){
                cell.imageView.alpha = 0.5
                cell.nameLabel.alpha = 0.5
                cell.pointsLabel.alpha = 0.5
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ConfigCollectionViewCell
        
        if (indexPath.row % 2 == 0) {
            if (indexPath.row / 8 == 0) {
                cell.backgroundColor = .black
            } else {
                cell.backgroundColor = .white
            }
        } else {
            if (indexPath.row / 8 == 0) {
                cell.backgroundColor = .white
            } else {
                cell.backgroundColor = .black
            }
        }
        
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        
        if(self.elementMatrixActiv![x][y] != nil){
            cell.imageView.image = self.elementMatrixActiv![x][y]!.getImageDefault()
        } else {
            cell.imageView.image = nil
        }
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
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

//MARK: DragDelegate
extension EditSelf: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?{
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = UIColor.clear
        return previewParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return self.collectionView(collectionView, itemsForBeginning: session, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        //        if(!self.notificationLabel.isHidden){
        //            self.notificationLabel.isHidden = true
        //            self.pointsLabel.text = "\(self.generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!))/39"
        //            self.pointsView.isHidden = false
        //        }
        self.elementMatrixCache = self.elementMatrixActiv!
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        if collectionView == self.tschessElementCollectionView {
            let tschessElement = generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])
            if(self.disactivated(tschessElement: tschessElement!)){
                return []
            }
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
            return [dragItem]
        }
        /***/
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        let tschessElement = self.elementMatrixActiv![x][y]
        if(tschessElement == nil) {
            return []
        }
        self.elementMatrixActiv![x][y] = nil
        self.configCollectionView.reloadData()
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
        return [dragItem]
    }
    
    internal func collectionView(_: UICollectionView, dragSessionDidEnd: UIDragSession){
        tschessElementCollectionView.reloadData()
        //self.pointsLabel.text = "\(self.generatePointsTotal(tschessElementMatrix: self.tschessElementMatrix!))/39"
    }
    
}

//MARK: DropDelegate
extension EditSelf: UICollectionViewDropDelegate {
    
    func generatePointsTotal(tschessElementMatrix: [[TschessElement?]]) -> Int {
        var points: Int = 0
        for row in tschessElementMatrix {
            for tschessElement in row {
                if(tschessElement != nil) {
                    let addition = Int(tschessElement!.getStrength())!
                    points += addition
                }
            }
        }
        return points
    }
    
    func collectionView(_ collectionView: UICollectionView,  dropSessionDidEnd session: UIDropSession) {
        var kingAbsent: Bool = true
        for row in self.elementMatrixActiv! {
            for tschessElement in row {
                if(tschessElement != nil){
                    if(tschessElement!.name.lowercased().contains("king")){
                        kingAbsent = false
                    }
                }
            }
        }
        if(kingAbsent){
            self.elementMatrixActiv = self.elementMatrixCache
            configCollectionView.reloadData()
        }
        let pointUpdate = generatePointsTotal(tschessElementMatrix: self.elementMatrixActiv!)
        if(pointUpdate > 39){
            self.elementMatrixActiv = self.elementMatrixCache
            configCollectionView.reloadData()
        } else {
            //self.pointsLabel.text = "\(pointUpdate)/39"
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let x = coordinator.destinationIndexPath!.row / 8
        let y = coordinator.destinationIndexPath!.row % 8
        let tschessElement = generateTschessElement(name: self.selectionElementName!)
        self.elementMatrixActiv![x][y] = tschessElement!
        configCollectionView.reloadData()
    }
    
}

extension EditSelf: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //print("You selected cell #\(indexPath.item)!")
    }
    
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
    
    
    
    
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool { // 1
        //print("canHandle session: \(session)")
        return true
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal { // 2
        //print("sessionDidUpdate session: \(session)")
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        //print("performDrop session: \(session)")
        if(self.selectionElementName != nil){
            if(self.selectionElementName!.lowercased().contains("king")){
                
                //self.pointsView.isHidden = true
                //self.notificationLabel.isHidden = false
                //self.notificationLabel.text = "king cannot be removed"
                
                self.elementMatrixActiv = self.elementMatrixCache
                configCollectionView.reloadData() //give a warning also... feedback
            }
        }
        self.selectionElementName = nil
        self.configCollectionView.reloadData()
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        switch self.titleText {
        case "config. 1":
            self.player!.setConfig1(config1: self.elementMatrixAbort!)
            break
        case "config. 2":
            self.player!.setConfig2(config2: self.elementMatrixAbort!)
            break
        default:
            self.player!.setConfig0(config0: self.elementMatrixAbort!)
        }
        if(self.titleText == "select config"){
            StoryboardSelector().actual(player: self.player!)
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
        viewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0://back
            switch self.titleText {
            case "config. 1":
                self.player!.setConfig1(config1: self.elementMatrixAbort!)
                break
            case "config. 2":
                self.player!.setConfig2(config2: self.elementMatrixAbort!)
                break
            default:
                self.player!.setConfig0(config0: self.elementMatrixAbort!)
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
            viewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        default: //save...
            DispatchQueue.main.async() {
                self.activityIndicator!.isHidden = false
                self.activityIndicator!.startAnimating()
            }
            let id = self.player!.getId()
            let config = ConfigSerializer().serializeConfiguration(savedConfigurationMatrix: self.elementMatrixActiv!)
            var updateConfig = [
                "id": id,
                "config": config,
                "updated": self.DATE_TIME.currentDateString()
                ] as [String: Any]
            
            var index: Int = 0
            if(self.titleLabel.text == "config. 1"){
                index = 1
            }
            if(self.titleLabel.text == "config. 2"){
                index = 2
            }
            updateConfig["index"] = index
            UpdateConfig().execute(requestPayload: updateConfig, player: self.player!) { (result) in
                if result == nil {
                    print("error!") // print a popup
                }
                self.player = result!
                DispatchQueue.main.async() {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
                viewController.setPlayer(player: self.player!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
    }
}
