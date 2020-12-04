//
//  Fairies.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Fairies: UIViewController, UITabBarDelegate {
    
    var fairyElementList: [Fairy] = [Amazon(), Grasshopper(), Hunter(), Poison()]
    
   // @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    //@IBOutlet weak var displacementImage: UIImageView!
    //@IBOutlet weak var displacementLabel: UILabel!
    //@IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    //@IBOutlet weak var rankLabel: UILabel!
    //@IBOutlet weak var usernameLabel: UILabel!
    //@IBOutlet weak var avatarImageView: UIImageView!
    //@IBOutlet weak var activityIndicatorLabel: UIActivityIndicatorView!
    
    var player: EntityPlayer?
    
    //public func renderHeader() {
    //    self.avatarImageView.image = self.playerSelf!.getImageAvatar()
    //    self.usernameLabel.text = self.playerSelf!.username
    //    self.eloLabel.text = self.playerSelf!.getLabelTextElo()
    //    self.rankLabel.text = self.playerSelf!.getLabelTextRank()
    //    self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
    //    self.displacementImage.image = self.playerSelf!.getImageDisp()!
    //    self.displacementImage.tintColor = self.playerSelf!.tintColor
    //}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.renderHeader()
        //self.activityIndicatorLabel.isHidden = true
    }
    
    var squadUpAdapter: FairiesTable?
    
    func getSquadUpAdapter() -> FairiesTable? {
        return squadUpAdapter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Header
        let viewHeaderDynamic = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.viewHeader.addSubview(viewHeaderDynamic)
        viewHeaderDynamic.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: viewHeaderDynamic, attribute: $0, relatedBy: .equal, toItem: viewHeaderDynamic.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        viewHeaderDynamic.set(player: self.player!)
        
        self.tabBarMenu.delegate = self
        self.squadUpAdapter = children.first as? FairiesTable
        self.squadUpAdapter!.setPlayer(player: self.player!)
        self.squadUpAdapter!.setFairyElementList(fairyElementList: self.fairyElementList)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "FairiesTableSelection"),
            object: nil)
    }
    
    //@IBAction func backButtonClick(_ sender: Any) {
        //self.navigationController?.popViewController(animated: false)
    //}
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let squadUpDetailSelectionIndex = notification.userInfo!["fairies_table_selection"] as! Int
        let fairy: Fairy = squadUpAdapter!.getFairyElementList()![squadUpDetailSelectionIndex]
        
        //let viewController = UIViewController()
        //viewController.preferredContentSize = CGSize(width: 250, height: 108) //108
        //self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        //pickerView!.delegate = self
        //pickerView!.dataSource = self
        //pickerView!.backgroundColor = .black
        
        //pickerView!.layer.cornerRadius = 10
        //pickerView!.layer.masksToBounds = true
        
        //pickerView!.selectRow(1, inComponent: 0, animated: true)
        
        //viewController.view.addSubview(self.pickerView!)
        //let alert = UIAlertController(title: "🧚 \(fairy.name) ♟️", message: "", preferredStyle: UIAlertController.Style.alert)
        
        //alert.setValue(viewController, forKey: "contentViewController")
        
        
        
        
        
        let message: String = "\n\(fairy.description)"

        let alert = UIAlertController(title: "🧚 \(fairy.name) 🧚", message: message, preferredStyle: .alert)
        
        let option01 = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        option01.setValue(UIColor.lightGray, forKey: "titleTextColor")
        alert.addAction(option01)
        
        //let image = UIImageView(image: fairy.imageDefault)
        //alert.view.addSubview(image)
        //image.translatesAutoresizingMaskIntoConstraints = false
        //alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0))
        //alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: alert.view, attribute: .centerY, multiplier: 1, constant: 0))
        //alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 65.0))
        //alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 65.0))
        
       
    
        
        self.present(alert, animated: true)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            self.navigationController!.popToRootViewController(animated: false)
        default:
            self.navigationController?.popViewController(animated: false)
        }
    }
}


