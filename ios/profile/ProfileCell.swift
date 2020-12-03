//
//  ProfileCell.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var optionImageView: UIImageView!
    
    @IBOutlet weak var optionLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        optionImageView.layer.cornerRadius = optionImageView.frame.size.width/2
        optionImageView.clipsToBounds = true
    }
    
}
