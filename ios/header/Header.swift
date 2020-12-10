//
//  Header.swift
//  ios
//
//  Created by S. Matthew English on 11/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Header: UIView {
    
    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var imageDisplacementRank: UIImageView!
    
    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet var indicatorActivity: UIActivityIndicatorView!

   
    public func set(player: EntityPlayer) {
        
        self.labelUsername.text = player.username
        self.labelRating.text = player.getLabelTextElo()
        self.labelRank.text = player.getLabelTextRank()
        
        self.imageDisplacementRank.image = player.getImageDisp()!
        self.imageDisplacementRank.tintColor = player.tintColor
        
        self.imageAvatar.image = player.getImageAvatar()
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width/2
        imageAvatar.clipsToBounds = true
    }
    
    func setIndicator(on: Bool, tableView: UITableViewController? = nil) {
        if(on) {
            DispatchQueue.main.async() {
                if(self.indicatorActivity!.isHidden){
                    self.indicatorActivity!.isHidden = false
                }
                if(!self.indicatorActivity!.isAnimating){
                    self.indicatorActivity!.startAnimating()
                }
            }
            return
        }
        DispatchQueue.main.async() {
            tableView!.tableView.reloadData()
            self.indicatorActivity!.stopAnimating()
            self.indicatorActivity!.isHidden = true
        }
    }
        
}

extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
