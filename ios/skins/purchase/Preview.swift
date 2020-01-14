//
//  Preview.swift
//  ios
//
//  Created by Matthew on 11/11/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Preview: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var usernameLabel: UILabel?
    @IBOutlet weak var rankLabel: UILabel?
    
    @IBOutlet weak var collectionView: DynamicCollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var turnaryIndicatorLabel: UILabel!
    @IBOutlet weak var countdownTimerLabel: UILabel!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    var counter: String?
    
    var tschessElementMatrix: [[TschessElement?]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.isHidden = true
        
        self.counter = "24:00:00"
        
        let tschessElementArray = [
            ["BlackRook","BlackKnight","BlackBishop","BlackQueen","BlackKing","BlackBishop","BlackKnight","BlackRook"],
            ["BlackPawn","BlackPawn","BlackPawn","BlackPawn","BlackPawn","BlackPawn","BlackPawn","BlackPawn"],
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["WhitePawn","WhitePawn","WhitePawn","WhitePawn","WhitePawn","WhitePawn","WhitePawn","WhitePawn"],
            ["WhiteRook","WhiteKnight","WhiteBishop","WhiteQueen","WhiteKing","WhiteBishop","WhiteKnight","WhiteRook"]
        ]
        
        self.tschessElementMatrix =  MatrixDeserializer().deserialize(stringRepresentation: tschessElementArray, orientationBlack: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.tabBarMenu.delegate = self
        
        let device = StoryboardSelector().device()
        if(device == "MAGNUS" || device == "XANDROID"){
            return
        }
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView!.image = decodedimage
        self.rankLabel!.text = self.player!.getRank()
        self.usernameLabel!.text = self.player!.getName()
    }
    
    func flash() {
        let flashFrame = UIView(frame: collectionView.bounds)
        flashFrame.backgroundColor = UIColor.black
        flashFrame.alpha = 0.7
        collectionView.addSubview(flashFrame)
        UIView.animate(withDuration: 0.1, animations: {
            flashFrame.alpha = 0.0
        }, completion: {(finished:Bool) in
            flashFrame.removeFromSuperview()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.flash()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 8
        let dim = collectionView.frame.width / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = assignCellBackgroundColor(indexPath: indexPath)
        cell.imageView.image = assignCellTschessElement(indexPath: indexPath)
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
    private func assignCellTschessElement(indexPath: IndexPath) -> UIImage? {
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        if(self.tschessElementMatrix![x][y] != nil){
            return self.tschessElementMatrix![x][y]!.getImageVisible()
        }
        return nil
    }
    
    private func assignCellBackgroundColor(indexPath: IndexPath) -> UIColor {
        if (indexPath.row % 2 == 0) {
            if ((indexPath.row / 8) % 2 == 0) {
                return UIColor.purple
            } else {
                return UIColor.brown
            }
        }
        if ((indexPath.row / 8) % 2 == 0) {
            return UIColor.brown
        }
        return UIColor.purple
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
    var counterTimer: Timer?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
        
        self.counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = collectionView.contentSize.height
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func updateCounter() {

        var timeInterval_x = parseDuration(counter!)
        timeInterval_x -= TimeInterval(1.0)
        
        let sec = Int(timeInterval_x.truncatingRemainder(dividingBy: 60))
        let min = Int(timeInterval_x.truncatingRemainder(dividingBy: 3600) / 60)
        let hour = Int(timeInterval_x / 3600)
        
        counter = String(format: "%02d:%02d:%02d", hour, min, sec)
        self.countdownTimerLabel.text = counter
    }
    
    func parseDuration(_ timeString:String) -> TimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }
        var interval:Double = 0
        let parts = timeString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        return interval
    }
    
}
