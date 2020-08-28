//
//  Confirm.swift
//  ios
//
//  Created by S. Matthew English on 8/26/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Confirm: UIViewController {
    
    @IBOutlet weak var imageShare: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    var playerSelf: EntityPlayer?
    var game: EntityGame?
    
    let textWins: String = "🙂 you win! 🎉"
    let textLost: String = "🙃 you lost. 🤝"
    let textDraw: String = "😐 you draw. ✍️"
    
    @IBOutlet weak var buttonAccept: UIButton!
    
    //private var transitionStart = TransInvalid()
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
        
        self.imageShare.isHidden = true
        
        self.game!.promptConfirm = false
        self.game!.confirm = nil
        
        let draw: Bool = self.game!.isDraw()
        if(draw){
            self.labelText.text = self.textDraw
            return
        }
        let username: String = self.playerSelf!.username
        let wins: Bool = self.game!.getWinner(username: username)
        if(wins){
            self.labelText.text = self.textWins
            return
        }
        self.labelText.text = self.textLost
    }
    
    @IBAction func buttonClickAccept(_ sender: Any) {
        
        let username: String = self.playerSelf!.username
        let white: Bool = self.game!.getWhite(username: username)
        
        let requestPayload: [String: Any] = ["id_game": game!.id, "white": white]
        
        UpdateConfirm().execute(requestPayload: requestPayload) { (_) in
        }
        DispatchQueue.main.async {
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.menuRefresh()
    }
    
    //TODO: ought not be here...
    func menuRefresh() {
        DispatchQueue.main.async {
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let viewControllers = navigationController.viewControllers
                for vc in viewControllers {
                    if vc.isKind(of: Menu.classForCoder()) {
                        let menu: Menu = vc as! Menu
                        menu.menuTable!.refresh(refreshControl: nil)
                    }
                }
                
            }
        }
    }
    
}
