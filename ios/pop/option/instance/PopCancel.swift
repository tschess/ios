//
//  Cancel.swift
//  ios
//
//  Created by S. Matthew English on 5/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PopCancel: UIViewController {
    
    var presentingController: UINavigationController?
    
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    
    private let transDelegate: TransDelegate = TransDelegate(width: 242, height: 158)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = transDelegate
    }
    
    @IBAction func buttonClickYes(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.presentingController!.popViewController(animated: false)
    }
    
    @IBAction func buttonClickNo(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
