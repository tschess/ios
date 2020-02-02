//
//  SkinTableCell.swift
//  ios
//
//  Created by Matthew on 1/16/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SkinsTableCell: UITableViewCell {
    
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellForegroundView: UIView!
    @IBOutlet weak var cellForegroundImage: UIImageView!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var cellBackgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
