//
//  Info.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Info: UIViewController, UITabBarDelegate, UIPopoverPresentationControllerDelegate, UITextViewDelegate {
    
    let dateTime: DateTime = DateTime()
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var fairyImageView: UIImageView!
    @IBOutlet weak var fairyNameLabel: UILabel!
    @IBOutlet weak var fairyPointsLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var attributeTextView: UITextView!
    
    var fairyElement: Fairy?
    
    func setFairyElement(fairyElement: Fairy) {
        self.fairyElement = fairyElement
    }
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fairyImageView.image = fairyElement!.getImageDefault()
        self.fairyNameLabel.text = fairyElement!.getName().lowercased()
        self.fairyPointsLabel.text = fairyElement!.getStrength()
        
        self.activityIndicator.isHidden = true
    }
    
    var insufficientBalance: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarMenu.delegate = self
        
        
        self.attributeTextView.isEditable = false
        self.attributeTextView.backgroundColor = UIColor.white
        self.attributeTextView.textColor = UIColor.black
        self.attributeTextView.text = self.fairyElement!.description
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectFairies().execute(player: self.player!, height: height)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                SelectFairies().execute(player: self.player!, height: height)
            }
            return
        default:
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                SelectHome().execute(player: self.player!, height: height)
            }
        }
    }
    
}
