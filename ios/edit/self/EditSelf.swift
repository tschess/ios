//
//  EditSelf.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EditSelf: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
    //MARK: Member
    var playerSelf: EntityPlayer!
    var selection: Int!
    var editCore: Edit!
    var confirm: Bool!
    
    //MARK: Variables
    var configAbort: [[Piece?]]?
    var configCache: [[Piece?]]?
    var configActiv: [[Piece?]]?
    var candidateName: String?
    var candidateCoord: [Int]?
    
    //MARK: Layout
    @IBOutlet weak var tschessElementCollectionView: UICollectionView!
    @IBOutlet weak var tschessElementCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var configCollectionView: BoardView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var totalPointLabel: UILabel!
    
    /**
     * finally this should live "modally" above config, since it's
     * a "top-level" activity, to return there we'll just kill this
     * task...
     */
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectConfig().execute(player: self.playerSelf!, height: height)
        }
    }
    
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
    
    static func create(player: EntityPlayer, select: Int, height: CGFloat) -> EditSelf {
        let identifier: String = height.isLess(than: 750) ? "L" : "P"
        let storyboard: UIStoryboard = UIStoryboard(name: "EditSelf\(identifier)", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditSelf\(identifier)") as! EditSelf
        viewController.playerSelf = player
        viewController.selection = select
        viewController.confirm = false
        viewController.editCore = Edit()
        return viewController
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
        
        self.tabBarMenu.delegate = self
        self.activityIndicator.isHidden = true
        self.configCollectionView.isUserInteractionEnabled = true
        self.configCollectionView.dragInteractionEnabled = true
        self.configCollectionView.alwaysBounceVertical = false
        self.configCollectionView.bounces = false
        self.tschessElementCollectionView.isUserInteractionEnabled = true
        self.tschessElementCollectionView.dragInteractionEnabled = true
        
        
        //self.view.addInteraction(UIDropInteraction(delegate: self))
        self.tschessElementCollectionView.addInteraction(UIDropInteraction(delegate: self))
        self.headerView.addInteraction(UIDropInteraction(delegate: self))
        self.contentView.addInteraction(UIDropInteraction(delegate: self))
        self.tabBarMenu.addInteraction(UIDropInteraction(delegate: self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configCollectionView.reloadData()
        self.configCollectionView.isHidden = false
        self.configCollectionView.gestureRecognizers?.forEach { (recognizer) in
            if let longPressRecognizer = recognizer as? UILongPressGestureRecognizer {
                longPressRecognizer.minimumPressDuration = 0.01
            }
        }
        self.tschessElementCollectionView.gestureRecognizers?.forEach { (recognizer) in
            if let longPressRecognizer = recognizer as? UILongPressGestureRecognizer {
                longPressRecognizer.minimumPressDuration = 0.1
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configCollectionViewHeight.constant = self.configCollectionView.contentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch self.selection! {
        case 1:
            self.configActiv = self.playerSelf!.getConfig(index: 1)
            self.titleLabel.text = "config. 1"
            break
        case 2:
            self.configActiv = self.playerSelf!.getConfig(index: 2)
            self.titleLabel.text = "config. 2"
            break
        default:
            self.configActiv = self.playerSelf!.getConfig(index: 0)
            self.titleLabel.text = "config. 0̸"
        }
        self.configAbort = self.configActiv
        self.renderHeader()
        self.setTotalPointValue()
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
        self.displacementImage.image = self.playerSelf!.getImageDisp()!
        self.displacementImage.tintColor = self.playerSelf!.tintColor
    }
    
    private func setTotalPointValue() {
        let totalPointValue = self.getPointValue(config: self.configActiv!)
        self.totalPointLabel.text = String(totalPointValue)
    }
    
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
    
    func allocatable(piece: Piece, config: [[Piece?]]) -> Bool {
        let pointIncrease = Int(piece.strength)!
        let pointValue0 = self.getPointValue(config: config)
        let pointValue1 = pointValue0 + pointIncrease
        if(pointValue1 > 39){
            return false
        }
        return true
    }
    
    //MARK: Render
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tschessElementCollectionView {
            let elementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConfigCell", for: indexPath) as! ConfigCell
            
            let elementImageIdentifier: String = self.ELEMENT_LIST[indexPath.row]
            let elementImage: UIImage = UIImage(named: elementImageIdentifier)!
            elementCell.configureCell(image: elementImage)
            
            let elementObject: Piece = self.editCore.generateTschessElement(name: self.ELEMENT_LIST[indexPath.row])!
            elementCell.nameLabel.text = elementObject.name
            elementCell.pointsLabel.text = elementObject.strength
            
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

//MARK: DataSource
extension EditSelf: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.tschessElementCollectionView {
            return ELEMENT_LIST.count
        }
        return 16
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
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.selectedItem = nil
        
        switch item.tag {
        case 0:
            self.backButtonClick("~")
        case 2:
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
                if result == result {
                    DispatchQueue.main.async() {
                        self.activityIndicator!.isHidden = true
                        self.activityIndicator!.stopAnimating()
                        self.playerSelf = result!
                        self.backButtonClick("~")
                    }
                }
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
extension EditSelf: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        print("aa")
        
        self.configCache = self.configActiv!
        
        let row: Int = indexPath.row
        print("row: \(row)")
        
        if collectionView == self.tschessElementCollectionView {
            
            let piece: Piece = self.editCore.generateTschessElement(name: self.ELEMENT_LIST[row])!
            
            let xname: String = piece.name
            print("name: \(xname)")
            
            let allocatable: Bool = self.allocatable(piece: piece, config: self.configActiv!)
            if(!allocatable){
                print("-")
                return []
            }
            print("*")
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            let name: String = self.editCore.imageNameFromPiece(piece: piece)!
            self.candidateName = name
            //let x = indexPath.row / 8
            //let y = indexPath.row % 8
            //self.candidateCoord = [x,y]
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
        
        let name: String = self.editCore.imageNameFromPiece(piece: tschessElement!)!
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
            //self.configActiv![x][y] = nil
            //self.configCollectionView.reloadData()
            //self.tschessElementCollectionView.reloadData()
            
            self.candidateName = name
            self.candidateCoord = [x,y]
            self.setTotalPointValue()
            return dragPreview
        }
        //self.setTotalPointValue()
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?{
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = UIColor.clear
        print("03")
        return previewParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        //return self.collectionView(collectionView, itemsForBeginning: session, at: indexPath)
        print("02")
        return self.collectionView(collectionView, itemsForBeginning: session, at: indexPath)
    }
    
    internal func collectionView(_: UICollectionView, dragSessionDidEnd: UIDragSession){ //last
        
        
        if(self.candidateCoord != nil){
            self.configActiv![self.candidateCoord![0]][self.candidateCoord![1]] = nil
        }
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
        
        //self.tschessElementCollectionView.reloadData()
        self.setTotalPointValue()
        
        
        self.candidateName = nil
        self.candidateCoord = nil
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
        //LAST OF DRAG
        print("zz")
    }
    
}

//MARK: DropDelegate
extension EditSelf: UICollectionViewDropDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        print("01")
        return true
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        print("02")
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        print("03")
        //if(self.candidate != nil){
            //if(self.candidate!.lowercased().contains("king")){
                //self.configActiv = self.configCache
                //self.configCollectionView.reloadData() //give a warning also... feedback
            //}
        //}
        
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        print("04")
        return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        print("05")
        let x = coordinator.destinationIndexPath!.row / 8
        let y = coordinator.destinationIndexPath!.row % 8
        
        //let occupant: Piece? = self.configActiv![x][y]
        //if(occupant != nil){
            //if(occupant!.name.lowercased().contains("king")){
                //self.configActiv = self.configCache
                //configCollectionView.reloadData()
                //return
            //}
        //}
        let tschessElement = self.editCore.generateTschessElement(name: self.candidateName!)
        self.configActiv![x][y] = tschessElement!
        //self.configActiv![self.candidateCoord![0]][self.candidateCoord![1]] = nil
        self.setTotalPointValue()
        self.configCollectionView.reloadData()
        self.tschessElementCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,  dropSessionDidEnd session: UIDropSession) {
        print("06")
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
    
}
