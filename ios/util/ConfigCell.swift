//
//  ConfigCell.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class ConfigCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    //MARK: - Configure Cell
    func configureCell(image: UIImage) {
        self.imageView.image = image
        self.nameLabel.text = "tschess element"
        self.pointsLabel.text = "999"
    }
    
}
