//
//  Edit.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EditOther: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
    @IBAction func backButtonClick(_ sender: Any) {
        if(!self.confirm){
            if(self.back == "PLAY"){
                if let viewControllers = self.navigationController?.viewControllers {
                    for vc in viewControllers {
                        let ty = String(describing: type(of: vc))
                        if(ty == "Play"){
                            let home: Play = vc as! Play
                            home.playerSelf = self.playerSelf!
                            home.reloadInputViews()
                        }
                    }
                }
                self.navigationController?.popViewController(animated: false)
                return
            }
            if(self.back == "ACK"){
                if let viewControllers = self.navigationController?.viewControllers {
                    for vc in viewControllers {
                        let ty = String(describing: type(of: vc))
                        if(ty == "Ack"){
                            let home: Ack = vc as! Ack
                            home.playerSelf = self.playerSelf!
                            //home.configCollectionView.reloadData()
                            switch home.selection! {
                            case 1:
                                home.renderConfig1()
                            case 2:
                                home.renderConfig2()
                            default:
                                home.renderConfig0()
                            }
                        }
                    }
                }
                self.navigationController?.popViewController(animated: false)
                return
            }
            if(self.back == "CHALLENGE"){
                if let viewControllers = self.navigationController?.viewControllers {
                    for vc in viewControllers {
                        let ty = String(describing: type(of: vc))
                        if(ty == "Challenge"){
                            let home: Challenge = vc as! Challenge
                            home.playerSelf = self.playerSelf!
                            
                        }
                    }
                }
                self.navigationController?.popViewController(animated: false)
                return
            }
        }
        self.confirm = false
        let storyboard: UIStoryboard = UIStoryboard(name: "PopCancel", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PopCancel") as! PopCancel
        viewController.presentingController = self.navigationController
        self.present(viewController, animated: true, completion: nil)
    }
    
    static func create(playerSelf: EntityPlayer, playerOther: EntityPlayer? = nil, select: Int, back: String, height: CGFloat, game: EntityGame? = nil) -> EditOther {
        let identifier: String = height.isLess(than: 750) ? "L" : "P"
        let storyboard: UIStoryboard = UIStoryboard(name: "EditOther\(identifier)", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditOther\(identifier)") as! EditOther
        viewController.playerSelf = playerSelf
        viewController.selection = select
        
        viewController.game = game
        viewController.back = back
        viewController.playerOther = playerOther
        
        viewController.confirm = false
        viewController.editCore = EditCore()
        return viewController
    }
    
    //MARK: Member - core
    var playerSelf: EntityPlayer!
    var selection: Int!
    var editCore: EditCore!
    var confirm: Bool!
    
    //MARK: Member - unique
    var playerOther: EntityPlayer?
    var game: EntityGame?
    var back: String?
    
    //MARK: Variables
    var configCache: [[Piece?]]?
    var configActiv: [[Piece?]]?
    var candidateName: String?
    var candidateCoord: [Int]?
    
    //MARK: Layout - core
    @IBOutlet weak var viewPointLabel: UIView!
    @IBOutlet weak var pieceCollectionView: UICollectionView!
    @IBOutlet weak var boardViewConfigHeight: NSLayoutConstraint!
    @IBOutlet weak var boardViewConfig: BoardView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var totalPointLabel: UILabel!
    
    //MARK: Layout - unique
    @IBOutlet weak var dateLabel: UILabel!
    
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
        
        self.tabBarMenu.delegate = self
        self.activityIndicator.isHidden = true
        self.boardViewConfig.isUserInteractionEnabled = true
        self.boardViewConfig.dragInteractionEnabled = true
        self.boardViewConfig.alwaysBounceVertical = false
        self.boardViewConfig.bounces = false
        self.pieceCollectionView.isUserInteractionEnabled = true
        self.pieceCollectionView.dragInteractionEnabled = true
        
        self.pieceCollectionView.addInteraction(UIDropInteraction(delegate: self))
        self.headerView.addInteraction(UIDropInteraction(delegate: self))
        self.contentView.addInteraction(UIDropInteraction(delegate: self))
        self.tabBarMenu.addInteraction(UIDropInteraction(delegate: self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.boardViewConfig.reloadData()
        //self.boardViewConfig.isHidden = false
        self.boardViewConfig.gestureRecognizers?.forEach { (recognizer) in
            if let longPressRecognizer = recognizer as? UILongPressGestureRecognizer {
                longPressRecognizer.minimumPressDuration = 0.004
            }
        }
        self.pieceCollectionView.gestureRecognizers?.forEach { (recognizer) in
            if let longPressRecognizer = recognizer as? UILongPressGestureRecognizer {
                longPressRecognizer.minimumPressDuration = 0.06
            }
        }
        self.boardViewConfig.layoutSubviews()
        self.boardViewConfig.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.boardViewConfigHeight.constant = self.boardViewConfig.contentSize.height
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
    
    private func renderHeader() { // unique
        self.avatarImageView.image = self.playerOther!.getImageAvatar()
        self.usernameLabel.text = self.playerOther!.username
        self.eloLabel.text = self.playerOther!.getLabelTextElo()
        self.rankLabel.text = self.playerOther!.getLabelTextRank()
        self.dateLabel.text = self.playerOther!.getLabelTextDate()
    }
    
    private func setTotalPointValue() { // common
        let totalPointValue: Int = self.editCore.getPointValue(config: self.configActiv!)
        self.totalPointLabel.text = String(totalPointValue)
        if(totalPointValue < 39){
            self.viewPointLabel.isHidden = false
            self.pieceCollectionView.isHidden = false
            return
        }
        self.viewPointLabel.isHidden = true
        self.pieceCollectionView.isHidden = true
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.selectedItem = nil
        switch item.tag {
        case 0:
            self.backButtonClick("")
        case 2:
            let storyboard: UIStoryboard = UIStoryboard(name: "PopHelp", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PopHelp") as! PopDismiss
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
                        self.confirm = false
                        self.backButtonClick("")
                    }
                }
            }
        }
    }
    
}

//MARK: DataSource
extension EditOther: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.pieceCollectionView {
            return self.editCore.ELEMENT_LIST.count
        }
        return 16
    }
}

//MARK: FlowLayout
extension EditOther: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.pieceCollectionView {
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
    
    //MARK: Render //gotta look at this...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.pieceCollectionView {
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
extension EditOther: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        self.configCache = self.configActiv!
        let row: Int = indexPath.row
        if collectionView == self.pieceCollectionView {
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
        self.boardViewConfig.reloadData()
        self.pieceCollectionView.reloadData()
        self.setTotalPointValue()
    }
    
}

//MARK: DropDelegate
extension EditOther: UICollectionViewDropDelegate {
    
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
        let flashFrame = UIView(frame: self.boardViewConfig.bounds)
        flashFrame.backgroundColor = UIColor.white
        flashFrame.alpha = 0.7
        self.boardViewConfig.addSubview(flashFrame)
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
