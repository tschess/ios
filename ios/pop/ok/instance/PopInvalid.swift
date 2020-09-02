//
//  CompInvalid.swift
//  ios
//
//  Created by S. Matthew English on 8/28/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Invalid: UIViewController {
    
    private let transDelegate: TransDelegate = TransDelegate(width: 242, height: 158)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure() {
        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
        self.transitioningDelegate = self.transDelegate
    }
    
    @IBOutlet weak var buttonAccept: UIButton!
    
    @IBAction func buttonClickAccept(_ sender: Any) {
        DispatchQueue.main.async {
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
    
}
