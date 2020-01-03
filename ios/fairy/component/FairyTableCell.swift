//
//  SquadUpAdapterCell.swift
//  ios
//
//  Created by Matthew on 8/8/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class FairyTableCell: UITableViewCell {
    
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
