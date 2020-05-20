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
            //DispatchQueue.main.async {
                //let height: CGFloat = UIScreen.main.bounds.height
                //SelectConfig().execute(player: self.playerSelf!, height: height)
            //}
            let presentingViewController = self.presentingViewController
            self.dismiss(animated: false, completion: {
                presentingViewController?.dismiss(animated: false, completion: {})
            })
            return
        }
        DispatchQueue.main.async {
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
        self.editOther!.backButtonClick("")
    }
    
    @IBAction func buttonClickNo(_ sender: Any) {
        DispatchQueue.main.async {
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
    
}
