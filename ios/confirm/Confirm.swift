//
//  Confirm.swift
//  ios
//
//  Created by S. Matthew English on 8/26/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Confirm: UIViewController {
    
    let textWins: String = "🙂 you win! 🎉"
    let textLost: String = "🙃 you lost. 🤝"
    let textDraw: String = "😐 you draw. ✍️"
    
    @IBOutlet weak var buttonAccept: UIButton!
    
    private var transitionStart = TransInvalid()
    
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
        transitioningDelegate = transitionStart
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonClickAccept(_ sender: Any) {
        DispatchQueue.main.async {
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        
        }
    }
    
}
