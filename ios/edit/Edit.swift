//
//  EditSelf.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Edit: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
    @IBOutlet weak var viewFairy: UIView!
    
    //@IBOutlet weak var componentHeader: Header!
    //viewHeader
    //header
    var header: Header?
    @IBOutlet weak var viewHeader: UIView!
    
    //MARK: Constant
    let ELEMENT_LIST = [
        "red_pawn",
        "red_knight",
        "red_bishop",
        "red_rook",
        "red_queen",
        "red_amazon",
        "red_hunter",
        "red_poison"]
    
    func allocatable(piece: Piece, config: [[Piece?]]) -> Bool {
        let pointIncrease = Int(piece.strength)!
        let pointValue0 = self.getPointValue(config: config)
        let pointValue1 = pointValue0 + pointIncrease
        if(pointValue1 > 39){
            return false
        }
        return true
    }
    
    func getPointValue(config: [[Piece?]]) -> Int {
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
    
    func generateTschessElement(name: String) -> Piece? {
        if(name.contains("grasshopper")){
            return Grasshopper()
        }
        if(name.contains("hunter")){
            return Hunter()
        }
        if(name.contains("poison")){
            return Poison()
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
        if(piece.name == Poison().name){
            return "red_poison"
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
    
    //@IBOutlet weak var labelHoldDrag: UILabel!
    
    //MARK: Member
    var player: EntityPlayer!
    var selection: Int!
    //var editCore: EditCore!
    var confirm: Bool!
    
    //MARK: Variables
    var configCache: [[Piece?]]?
    var configActiv: [[Piece?]]?
    var candidateName: String?
    var candidateCoord: [Int]?
    
    //MARK: Layout
    @IBOutlet weak var viewPointLabel: UIView!
    @IBOutlet weak var tschessElementCollectionView: UICollectionView!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var configCollectionView: BoardView!
    //@IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //@IBOutlet weak var displacementImage: UIImageView!
    //@IBOutlet weak var displacementLabel: UILabel!
    //@IBOutlet weak var eloLabel: UILabel!
    //@IBOutlet weak var rankLabel: UILabel!
    //@IBOutlet weak var usernameLabel: UILabel!
    //@IBOutlet weak var avatarImageView: UIImageView!
    //@IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var totalPointLabel: UILabel!
    
    func back() {
        if(!self.confirm){
            self.navigationController?.popViewController(animated: false)
            return
        }
        self.confirm = false
        let storyboard: UIStoryboard = UIStoryboard(name: "PopCancel", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PopCancel") as! PopCancel
        viewController.presentingController = self.navigationController
        self.present(viewController, animated: true, completion: nil)
    }
    
    static func create(player: EntityPlayer, select: Int, height: CGFloat) -> Edit {
        let storyboard: UIStoryboard = UIStoryboard(name: "Edit", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Edit") as! Edit
        viewController.player = player
        viewController.selection = select
        viewController.confirm = false
        return viewController
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewFairy!.isHidden = true
        
        self.configCollectionView.isHidden = true
        self.configCollectionView.delegate = self
        self.configCollectionView.dataSource = self
        self.configCollectionView.dragDelegate = self
        self.configCollectionView.dropDelegate = self
        self.tschessElementCollectionView.delegate = self
        self.tschessElementCollectionView.dataSource = self
        self.tschessElementCollectionView.dragDelegate = self
        
        self.tabBarMenu.delegate = self
        //self.activityIndicator.isHidden = true
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = true
        self.configCollectionView.alwaysBounceVertical = false
        self.configCollectionView.bounces = false
        self.tschessElementCollectionView.isUserInteractionEnabled = true
        self.tschessElementCollectionView.dragInteractionEnabled = true
        
        self.tschessElementCollectionView.addInteraction(UIDropInteraction(delegate: self))
        self.headerView.addInteraction(UIDropInteraction(delegate: self))
        self.contentView.addInteraction(UIDropInteraction(delegate: self))
        self.tabBarMenu.addInteraction(UIDropInteraction(delegate: self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configCollectionView.gestureRecognizers?.forEach { (recognizer) in
            if let longPressRecognizer = recognizer as? UILongPressGestureRecognizer {
                longPressRecognizer.minimumPressDuration = 0.004
            }
        }
        self.tschessElementCollectionView.gestureRecognizers?.forEach { (recognizer) in
            if let longPressRecognizer = recognizer as? UILongPressGestureRecognizer {
                longPressRecognizer.minimumPressDuration = 0.06
            }
        }
        self.configCollectionView.layoutSubviews()
        self.configCollectionView.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configCollectionViewHeight.constant = self.configCollectionView.contentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.header = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.viewHeader!.addSubview(self.header!)
        self.header!.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: self.header!, attribute: $0, relatedBy: .equal, toItem: self.header!.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        self.header!.set(player: self.player!)
        
        switch self.selection! {
        case 1:
            self.configActiv = self.player!.getConfig(index: 1)
            self.header!.labelTitle.text = "config. 1"
            break
        case 2:
            self.configActiv = self.player!.getConfig(index: 2)
            self.header!.labelTitle.text = "config. 2"
            break
        default:
            self.configActiv = self.player!.getConfig(index: 0)
            self.header!.labelTitle.text = "config. 0̸"
        }
        self.configCache = self.configActiv
        
     
        
        
        self.setTotalPointValue()
    }
    
    private func setTotalPointValue() {
        let totalPointValue: Int = self.getPointValue(config: self.configActiv!)
        self.totalPointLabel.text = String(totalPointValue)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.selectedItem = nil
        switch item.tag {
        case 0:
            self.back()
        case 2:
            let storyboard: UIStoryboard = UIStoryboard(name: "PopHelp", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PopHelp") as! PopDismiss
            self.present(viewController, animated: true, completion: nil)
        default:
            DispatchQueue.main.async() {
                self.header!.indicatorActivity!.isHidden = false
                self.header!.indicatorActivity!.startAnimating()
            }
            let id = self.player!.id
            let config = self.player!.setConfig(index: self.selection!, config: self.configActiv!)
            let updateConfig = ["id": id, "config": config, "index": self.selection!] as [String: Any]
            
            UpdateConfig().execute(requestPayload: updateConfig) { (result) in
                
                DispatchQueue.main.async() {
                    self.header!.indicatorActivity!.isHidden = true
                    self.header!.indicatorActivity!.stopAnimating()
                    
                    guard let navigationController = self.navigationController else { return }
                    var navigationArray = navigationController.viewControllers
                    navigationArray.remove(at: 1) //Config
                    self.navigationController?.viewControllers = navigationArray
                    
                    var storyboard: UIStoryboard = UIStoryboard(name: "ConfigP", bundle: nil)
                    var viewController = storyboard.instantiateViewController(withIdentifier: "ConfigP") as! Config
                    if(UIScreen.main.bounds.height.isLess(than: 750)){
                        storyboard = UIStoryboard(name: "ConfigL", bundle: nil)
                        viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
                    }
                    viewController.playerSelf = result!
                    viewController.labelTapHidden = true
                    self.navigationController?.pushViewController(viewController, animated: false)
                    
                    guard let navigationController0 = self.navigationController else { return }
                    var navigationArray0 = navigationController0.viewControllers
                    navigationArray0.remove(at: 1) //EditSelf
                    self.navigationController?.viewControllers = navigationArray0
                }
            }
        }
    }
}

//MARK: DataSource
extension Edit: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.tschessElementCollectionView {
            return self.ELEMENT_LIST.count
        }
        return 16
    }
}

//MARK: FlowLayout
extension Edit: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.tschessElementCollectionView {
            return CGSize(width: 100, height: 150)
        }
        let cellsAcross: CGFloat = 8
        let dim = UIScreen.main.bounds.width / cellsAcross
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

extension Edit: UICollectionViewDelegate {
    
    //MARK: Render //gotta look at this...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tschessElementCollectionView {
            let elementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConfigCell", for: indexPath) as! ConfigCell
            
            let elementImageIdentifier: String = self.ELEMENT_LIST[indexPath.row]
            let elementImage: UIImage = UIImage(named: elementImageIdentifier)!
            elementCell.configureCell(image: elementImage)
            
            let elementObject: Piece = self.generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])!
            elementCell.nameLabel.text = "\(elementObject.name.lowercased()): \(elementObject.strength)"
            elementCell.pointsLabel.isHidden = true
            
            elementCell.imageView.alpha = 1
            elementCell.nameLabel.alpha = 1
            elementCell.pointsLabel.alpha = 1
            if(!self.allocatable(piece: elementObject, config: self.configActiv!)){
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
}


//MARK: DragDelegate
extension Edit: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        self.configCache = self.configActiv!
        let row: Int = indexPath.row
        if collectionView == self.tschessElementCollectionView {
            let piece: Piece = self.generateTschessElement(name: self.ELEMENT_LIST[row])!
            
            if(!piece.standard){
                self.viewFairy!.isHidden = false
            }
            
            let allocatable: Bool = self.allocatable(piece: piece, config: self.configActiv!)
            if(!allocatable){
                return []
            }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            let name: String = self.imageNameFromPiece(piece: piece)!
            self.candidateName = name
            
            let image: UIImage = UIImage(named: name)!
            let itemProvider = NSItemProvider(object: image)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.previewProvider = {
                () -> UIDragPreview? in
                let imageView = UIImageView(image: image)
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
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        
        if(!tschessElement!.standard){
            self.viewFairy!.isHidden = false
        }
        
        
        let name: String = self.imageNameFromPiece(piece: tschessElement!)!
        let image: UIImage = UIImage(named: name)!
        let itemProvider = NSItemProvider(object: image)
        
        let dragItem: UIDragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.previewProvider = {
            () -> UIDragPreview? in
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            let previewParameters = UIDragPreviewParameters()
            previewParameters.backgroundColor = UIColor.clear
            let dragPreview: UIDragPreview = UIDragPreview(view: imageView, parameters: previewParameters)
            self.candidateName = name
            self.candidateCoord = [x,y]
            self.setTotalPointValue()
            return dragPreview
        }
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?{
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = UIColor.clear
        return previewParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return self.collectionView(collectionView, itemsForBeginning: session, at: indexPath)
    }
    
    internal func collectionView(_: UICollectionView, dragSessionDidEnd: UIDragSession){
        self.candidateName = nil
        self.candidateCoord = nil
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
        self.setTotalPointValue()
    }
    
}

//MARK: DropDelegate
extension Edit: UICollectionViewDropDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move)
    }
    
    private func revert() -> Bool {
        for row in self.configActiv! {
            for piece: Piece? in row {
                if(piece == nil){
                    continue
                }
                if(piece!.name == "King"){
                    return false
                }
            }
        }
        return true
    }
    
    private func flash() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        let flashFrame = UIView(frame: self.configCollectionView.bounds)
        flashFrame.backgroundColor = UIColor.white
        flashFrame.alpha = 0.7
        self.configCollectionView.addSubview(flashFrame)
        UIView.animate(withDuration: 0.1, animations: {
            flashFrame.alpha = 0.0
        }, completion: {(finished:Bool) in
            flashFrame.removeFromSuperview()
        })
    }
    
    private func rollback() {
        self.configActiv = self.configCache
        self.flash()
    }
    
    func renderPopup(fairy: Fairy) {
        let message: String = "\n\(fairy.description)"
        let alert = UIAlertController(title: "🧚 \(fairy.name) 🧚", message: message, preferredStyle: .alert)
        let option01 = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        option01.setValue(UIColor.lightGray, forKey: "titleTextColor")
        alert.addAction(option01)
        self.present(alert, animated: true)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        self.viewFairy!.isHidden = true
        
        let point = session.location(in: self.viewFairy!)
        let piece: Piece? = self.generateTschessElement(name: self.candidateName!)
        if self.viewFairy!.bounds.contains(point) {
            if(!piece!.standard){
                self.renderPopup(fairy: piece as! Fairy)
            }
        }
        
        if(self.revert()){
            self.rollback()
            return
        }
        if(self.candidateCoord == nil){
            return
        }
        let candidate = self.configActiv![self.candidateCoord![0]][self.candidateCoord![1]]
        if(candidate == nil){
            return
        }

        
        if self.viewFairy!.bounds.contains(point) {
            if(!candidate!.standard){
                self.renderPopup(fairy: candidate as! Fairy)
            }
        }
        
        
        
        if(candidate!.name == "King"){
            self.rollback()
            return
        }
        self.confirm = true
        self.configActiv![self.candidateCoord![0]][self.candidateCoord![1]] = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        self.viewFairy!.isHidden = true
        
        let x = coordinator.destinationIndexPath!.row / 8
        let y = coordinator.destinationIndexPath!.row % 8
        let candidate: Piece? = self.configActiv![x][y]
        if(candidate != nil){
            if(candidate!.name == "King"){
                self.rollback()
                return
            }
        }
        self.confirm = true
        let piece: Piece? = self.generateTschessElement(name: self.candidateName!)
        if(self.candidateCoord == nil){
            self.configActiv![x][y] = piece
            return
        }
        self.configActiv![self.candidateCoord![0]][self.candidateCoord![1]] = nil
        self.configActiv![x][y] = piece
    }
}
