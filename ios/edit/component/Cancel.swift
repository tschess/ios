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
    var editOther: EditOther?
    
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    
    private var transitionHelp = TransHelp()
    
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
        transitioningDelegate = transitionHelp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonClickYes(_ sender: Any) {
        if(!self.other){
            let pvc: UIViewController = self.presentingViewController!
            self.dismiss(animated: true, completion: {
                pvc.dismiss(animated: false, completion: nil)
            })
            return
        }
        //self.presentingViewController!.dismiss(animated: false, completion: nil)
        //self.editOther!.backButtonClick("")
        // ^^^not good...
    }
    
    @IBAction func buttonClickNo(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
