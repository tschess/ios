//
//  Cancel.swift
//  ios
//
//  Created by S. Matthew English on 5/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PopCancel: UIViewController {
    
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
                            let play: Play = vc as! Play
                            play.playerSelf = self.playerSelf!
                            //play.view.layoutIfNeeded()
                        }
                        if(ty == "Ack"){
                            let ack: Ack = vc as! Ack
                            ack.playerSelf = self.playerSelf!
                            //ack.view.layoutIfNeeded()
                        }
                        if(ty == "Challenge"){
                            let home: Challenge = vc as! Challenge
                            home.playerSelf = self.playerSelf!
                            //home.view.layoutIfNeeded()
                        }
                        //if(ty == "Config"){
                            //let config: Config = vc as! Config
                            //config.playerSelf = self.playerSelf!
                            //config.view.layoutIfNeeded()
                        //}
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