//
//  DynamicCollectionView.swift
//  ios
//
//  Created by Matthew on 7/31/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class DynamicCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        return self.collectionViewLayout.collectionViewContentSize
    }

}
