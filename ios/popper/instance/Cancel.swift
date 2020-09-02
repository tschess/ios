//
//  Cancel.swift
//  ios
//
//  Created by S. Matthew English on 5/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Cancel: UIViewController {
    
    var playerSelf: EntityPlayer?
    var other: Bool = false
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonClickYes(_ sender: Any) {
        if(!self.other){
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                navigationController.dismiss(animated: true, completion: {
                    navigationController.popViewController(animated: false)
                })
            }

            return
        }
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.dismiss(animated: true, completion: {
                
                
                if let viewControllers = self.navigationController?.viewControllers {
                    for vc in viewControllers {
                        let ty = String(describing: type(of: vc))
                        if(ty == "Play"){
                            let home: Play = vc as! Play
                            home.playerSelf = self.playerSelf!
                        }
                        if(ty == "Ack"){
                            let home: Ack = vc as! Ack
                            home.playerSelf = self.playerSelf!
                        }
                        if(ty == "Challenge"){
                            let home: Challenge = vc as! Challenge
                            home.playerSelf = self.playerSelf!
                        }
                    }
                }
                navigationController.popViewController(animated: false)
            })
        }
    }
    
    @IBAction func buttonClickNo(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
