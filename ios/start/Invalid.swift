//
//  Evaluate.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Invalid: UIViewController {
    
    @IBOutlet weak var buttonOk: UIButton!
    
   
 
    
   
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    

    
    private var customTransitioningDelegate = TransitioningDelegate()
    
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
        transitioningDelegate = customTransitioningDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
  
    
    @IBAction func buttonClickOk(_ sender: Any) {
        
        DispatchQueue.main.async {
                //self.activityIndicator!.stopAnimating()
                //self.activityIndicator!.isHidden = true
             self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
        
    
}
