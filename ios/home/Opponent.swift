//
//  Opponent.swift
//  ios
//
//  Created by S. Matthew English on 11/23/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Opponent: UIView {
    
    @IBOutlet weak var labelUsername00: UILabel!
    @IBOutlet weak var imageAvatar00: UIImageView!
    
    @IBOutlet weak var viewHolder00: UIView!
    @IBOutlet weak var viewHolder01: UIView!
    @IBOutlet weak var viewHolder02: UIView!
    
    @IBOutlet weak var imageAvatar01: UIImageView!
    @IBOutlet weak var labelUsername01: UILabel!
    @IBOutlet weak var imageAvatar02: UIImageView!
    
    @IBOutlet weak var labelUsername02: UILabel!
    @IBOutlet weak var viewHolder00width: NSLayoutConstraint!
    @IBOutlet weak var viewHolder01width: NSLayoutConstraint!
    @IBOutlet weak var viewHolder02width: NSLayoutConstraint!


    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
 
    
    public func set() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        self.viewHolder00width.constant = screenWidth/3
        self.viewHolder01width.constant = screenWidth/3
        self.viewHolder02width.constant = screenWidth/3
        
        //        self.labelUsername.text = player.username
        
        //self.imageAvatar00.image = player.getImageAvatar()
        imageAvatar00.layer.cornerRadius = imageAvatar00.frame.size.width/2
        imageAvatar00.clipsToBounds = true
        
        //self.imageAvatar01.image = player.getImageAvatar()
        imageAvatar01.layer.cornerRadius = imageAvatar01.frame.size.width/2
        imageAvatar01.clipsToBounds = true
        
        //self.imageAvatar02.image = player.getImageAvatar()
        imageAvatar02.layer.cornerRadius = imageAvatar02.frame.size.width/2
        imageAvatar02.clipsToBounds = true
        
        
    }
    
    
}
