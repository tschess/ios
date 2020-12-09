//
//  PopResult.swift
//  ios
//
//  Created by S. Matthew English on 12/9/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PopResult: UIViewController {
    
    @IBOutlet weak var ok: UIButton!
    
    
    var transitioner: Transitioner?
    private let transDelegate: TransDelegate = TransDelegate(width: 271, height: 301)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
        
      
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = transDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   
    @IBAction func selectOk(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
}
