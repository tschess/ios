//
//  Config.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Config: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDropInteractionDelegate {
    
    var titleText: String?
    
    func setTitleText(titleText: String) {
        self.titleText = titleText
    }
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var splitViewHeight0: NSLayoutConstraint!
    @IBOutlet weak var splitViewHeight1: NSLayoutConstraint!
    @IBOutlet weak var splitViewHeight2: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var configCollectionView0: BoardView!
    @IBOutlet weak var configCollectionViewHeight0: NSLayoutConstraint!
    
    @IBOutlet weak var configCollectionView1: BoardView!
    @IBOutlet weak var configCollectionViewHeight1: NSLayoutConstraint!
    
    @IBOutlet weak var configCollectionView2: BoardView!
    @IBOutlet weak var configCollectionViewHeight2: NSLayoutConstraint!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var attributeAlphaDotFull: [NSAttributedString.Key: NSObject]?
    var attributeAlphaDotHalf: [NSAttributedString.Key: NSObject]?
    
    var updatePhotoGesture: UITapGestureRecognizer?
    var swipeRightGesture: UISwipeGestureRecognizer?
    var swipeLeftGesture: UISwipeGestureRecognizer?
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    var tschessElementMatrix0: [[Piece?]]?
    var tschessElementMatrix1: [[Piece?]]?
    var tschessElementMatrix2: [[Piece?]]?
    
    var playerSelf: EntityPlayer?
    
    public func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarMenu.delegate = self
        
        self.activityIndicator.isHidden = true
        
        self.configCollectionView0.delegate = self
        self.configCollectionView0.dataSource = self
        let editCollectionView0 = UITapGestureRecognizer(target: self, action: #selector(self.editCollectionView0))
        self.configCollectionView0.addGestureRecognizer(editCollectionView0)
        
        self.configCollectionView1.delegate = self
        self.configCollectionView1.dataSource = self
        let editCollectionView1 = UITapGestureRecognizer(target: self, action: #selector(self.editCollectionView1))
        self.configCollectionView1.addGestureRecognizer(editCollectionView1)
        
        self.configCollectionView2.delegate = self
        self.configCollectionView2.dataSource = self
        let editCollectionView2 = UITapGestureRecognizer(target: self, action: #selector(self.editCollectionView2))
        self.configCollectionView2.addGestureRecognizer(editCollectionView2)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        //self.presentingViewController!.dismiss(animated: false, completion: nil)
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func editCollectionView0() {
        let viewController = EditSelf.create(
            player: self.playerSelf!,
            select: 0,
            height: UIScreen.main.bounds.height)
        viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(viewController, animated: false , completion: nil)
    }
    
    @objc func editCollectionView1() {
        let viewController = EditSelf.create(
                   player: self.playerSelf!,
                   select: 1,
                   height: UIScreen.main.bounds.height)
               viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
               self.present(viewController, animated: false , completion: nil)
    }
    
    @objc func editCollectionView2() {
        let viewController = EditSelf.create(
                   player: self.playerSelf!,
                   select: 2,
                   height: UIScreen.main.bounds.height)
               viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
               self.present(viewController, animated: false , completion: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.renderHeader()
        
        self.configCollectionView0.isHidden = true
        self.configCollectionView1.isHidden = true
        self.configCollectionView2.isHidden = true
        
        self.tschessElementMatrix0 = self.playerSelf!.getConfig(index: 0)
        self.tschessElementMatrix1 = self.playerSelf!.getConfig(index: 1)
        self.tschessElementMatrix2 = self.playerSelf!.getConfig(index: 2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //let totalContentHeight = self.contentView.frame.size.height - 8 // 4???
        let totalContentHeight = self.contentView.frame.size.height
        
        self.splitViewHeight0.constant = totalContentHeight/3
        self.splitViewHeight1.constant = totalContentHeight/3
        self.splitViewHeight2.constant = totalContentHeight/3
        
        self.configCollectionView0.bounces = false
        self.configCollectionView0.alwaysBounceVertical = false
        self.configCollectionViewHeight0.constant = configCollectionView0.contentSize.height
        
        
        self.configCollectionView1.bounces = false
        self.configCollectionView1.alwaysBounceVertical = false
        self.configCollectionViewHeight1.constant = configCollectionView1.contentSize.height
        
        
        self.configCollectionView2.bounces = false
        self.configCollectionView2.alwaysBounceVertical = false
        self.configCollectionViewHeight2.constant = configCollectionView2.contentSize.height
    }
    
    @objc func renderElementCollectionView() {
        self.avatarImageView.removeGestureRecognizer(self.updatePhotoGesture!)
        self.view.removeGestureRecognizer(self.swipeRightGesture!)
        self.view.removeGestureRecognizer(self.swipeLeftGesture!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configCollectionView0.reloadData()
        self.configCollectionView0.isHidden = false
        self.configCollectionView1.reloadData()
        self.configCollectionView1.isHidden = false
        self.configCollectionView2.reloadData()
        self.configCollectionView2.isHidden = false
    }
}

//MARK: - UICollectionViewDataSource
extension Config: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.configCollectionView0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! SquareCell
            
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
            
            if(self.tschessElementMatrix0![x][y] != nil){
                cell.imageView.image = self.tschessElementMatrix0![x][y]!.getImageDefault()
            } else {
                cell.imageView.image = nil
            }
            cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
            cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
            return cell
        }
        if collectionView == self.configCollectionView1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! SquareCell
            
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
            
            if(self.tschessElementMatrix1![x][y] != nil){
                cell.imageView.image = self.tschessElementMatrix1![x][y]!.getImageDefault()
            } else {
                cell.imageView.image = nil
            }
            cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
            cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! SquareCell
        
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
        
        if(self.tschessElementMatrix2![x][y] != nil){
            cell.imageView.image = self.tschessElementMatrix2![x][y]!.getImageDefault()
        } else {
            cell.imageView.image = nil
        }
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
        
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension Config: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 8
        let dim = collectionView.frame.width / cellsAcross
        return CGSize(width: dim, height: dim)
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
}

extension Config: UICollectionViewDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            //DispatchQueue.main.async {
            //let height: CGFloat = UIScreen.main.bounds.height
            //SelectFairies().execute(player: self.playerSelf!, height: height)
            //}
            //return
            self.tabBarMenu.selectedItem = nil
            
            
            
            //DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            if(height.isLess(than: 750)){
                //let root = UIApplication.shared.delegate! as! AppDelegate
                let storyboard: UIStoryboard = UIStoryboard(name: "FairiesL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FairiesL") as! Fairies
                viewController.playerSelf = self.playerSelf!
                viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                //root.window?.rootViewController?.present(viewController, animated: false , completion: nil)
                self.present(viewController, animated: false , completion: nil)
                return
            }
            //let root = UIApplication.shared.delegate! as! AppDelegate
            let storyboard: UIStoryboard = UIStoryboard(name: "FairiesP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "FairiesP") as! Fairies
            viewController.playerSelf = self.playerSelf!
            viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(viewController, animated: false , completion: nil)
            
            
            
            
            
        //}
        default:
            //DispatchQueue.main.async {
            //let height: CGFloat = UIScreen.main.bounds.height
            //SelectHome().execute(player: self.playerSelf!, height: height)
            //}
            //self.presentingViewController!.dismiss(animated: false, completion: nil)
            self.modalTransitionStyle = .crossDissolve
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}



