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
    var editCore: EditCore!
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
    
    /** !!!!!!
     * finally this should live "modally" above config, since it's
     * a "top-level" activity, to return there we'll just kill this
     * task... !!!!
     */
    @IBAction func backButtonClick(_ sender: Any) {
        if(!self.confirm){
            self.dismiss(animated: false, completion: nil)
            let pvc: Config = self.presentingViewController! as! Config
            pvc.playerSelf = self.playerSelf!
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Cancel", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Cancel") as! Cancel
        viewController.playerSelf = self.playerSelf!
        self.present(viewController, animated: true, completion: nil)
    }
    
    static func create(player: EntityPlayer, select: Int, height: CGFloat) -> EditSelf {
        let identifier: String = height.isLess(than: 750) ? "L" : "P"
        let storyboard: UIStoryboard = UIStoryboard(name: "EditSelf\(identifier)", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditSelf\(identifier)") as! EditSelf
        viewController.playerSelf = player
        viewController.selection = select
        viewController.confirm = false
        viewController.editCore = EditCore()
        return viewController
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.confirm = false /// ???
        
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
                longPressRecognizer.minimumPressDuration = 0.004
            }
        }
        self.tschessElementCollectionView.gestureRecognizers?.forEach { (recognizer) in
            if let longPressRecognizer = recognizer as? UILongPressGestureRecognizer {
                longPressRecognizer.minimumPressDuration = 0.06
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
        self.configCache = self.configActiv
        self.renderHeader()
        self.setTotalPointValue()
    }
    
    private func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
        self.displacementImage.image = self.playerSelf!.getImageDisp()!
        self.displacementImage.tintColor = self.playerSelf!.tintColor
    }
    
    private func setTotalPointValue() {
        let totalPointValue: Int = self.editCore.getPointValue(config: self.configActiv!)
        self.totalPointLabel.text = String(totalPointValue)
        if(totalPointValue < 39){
            self.viewPointLabel.isHidden = false
            self.tschessElementCollectionView.isHidden = false
            return
        }
        self.viewPointLabel.isHidden = true
        self.tschessElementCollectionView.isHidden = true
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.selectedItem = nil
        switch item.tag {
        case 0:
            self.backButtonClick("")
//            if(!self.confirm){
//                self.backButtonClick("")
//                return
//            }
//            let storyboard: UIStoryboard = UIStoryboard(name: "Cancel", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "Cancel") as! Cancel
//            viewController.playerSelf = self.playerSelf!
//            self.present(viewController, animated: true, completion: nil)
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
                DispatchQueue.main.async() {
                    self.activityIndicator!.isHidden = true
                    self.activityIndicator!.stopAnimating()
                    //self.playerSelf = result! //what about this?????
                    //self.modalTransitionStyle = .crossDissolve
                    self.dismiss(animated: false, completion: nil)
                    let pvc: Config = self.presentingViewController! as! Config
                    pvc.playerSelf = result!
                }
                
            }
        }
    }
    
}

//MARK: DataSource
extension EditSelf: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.tschessElementCollectionView {
            return self.editCore.ELEMENT_LIST.count
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
    
    //MARK: Render //gotta look at this...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tschessElementCollectionView {
            let elementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConfigCell", for: indexPath) as! ConfigCell
            
            let elementImageIdentifier: String = self.editCore.ELEMENT_LIST[indexPath.row]
            let elementImage: UIImage = UIImage(named: elementImageIdentifier)!
            elementCell.configureCell(image: elementImage)
            
            let elementObject: Piece = self.editCore.generateTschessElement(name: self.editCore.ELEMENT_LIST[indexPath.row])!
            elementCell.nameLabel.text = "\(elementObject.name.lowercased()): \(elementObject.strength)"
            elementCell.pointsLabel.isHidden = true
            
            elementCell.imageView.alpha = 1
            elementCell.nameLabel.alpha = 1
            elementCell.pointsLabel.alpha = 1
            if(!self.editCore.allocatable(piece: elementObject, config: self.configActiv!)){
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
extension EditSelf: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        self.configCache = self.configActiv!
        let row: Int = indexPath.row
        if collectionView == self.tschessElementCollectionView {
            let piece: Piece = self.editCore.generateTschessElement(name: self.editCore.ELEMENT_LIST[row])!
            let allocatable: Bool = self.editCore.allocatable(piece: piece, config: self.configActiv!)
            if(!allocatable){
                return []
            }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            let name: String = self.editCore.imageNameFromPiece(piece: piece)!
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
extension EditSelf: UICollectionViewDropDelegate {
    
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
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
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
        let piece: Piece? = self.editCore.generateTschessElement(name: self.candidateName!)
        if(self.candidateCoord == nil){
            self.configActiv![x][y] = piece
            return
        }
        self.configActiv![self.candidateCoord![0]][self.candidateCoord![1]] = nil
        self.configActiv![x][y] = piece
    }
}
