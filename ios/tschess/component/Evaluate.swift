//
//  Evaluate.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Evaluate: UIViewController {
    
    var gameTschess: EntityGame?
    
    public func setGameTschess(gameTschess: EntityGame) {
        self.gameTschess = gameTschess
    }
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    private var customTransitioningDelegate = TransitioningDelegate()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    var state: [[Piece?]]?
    
    func setState(state: [[Piece?]]) {
        self.state = state
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
    
    let dateTime: DateTime = DateTime()
    
    @IBAction func rejectButtonClick(_ sender: Any) {
        let requestPayload = [
            "id_game": self.gameTschess!.id,
            "id_self": self.playerSelf!.id,
            "id_other": self.playerOther!.id,
            "accept": false] as [String: Any]
        
        UpdateEval().execute(requestPayload: requestPayload) { (result) in
            print("result: \(result)")
            
            DispatchQueue.main.async {
                //self.activityIndicator!.stopAnimating()
                //self.activityIndicator!.isHidden = true
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
        //self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func acceptButtonClick(_ sender: Any) {
        let requestPayload = [
            "id_game": self.gameTschess!.id,
            "id_self": self.playerSelf!.id,
            "id_other": self.playerOther!.id,
           "accept": true] as [String: Any]
        
        UpdateEval().execute(requestPayload: requestPayload) { (result) in
            print("result: \(result)")
            
            DispatchQueue.main.async {
                        //self.activityIndicator!.stopAnimating()
                        //self.activityIndicator!.isHidden = true
                        self.presentingViewController!.dismiss(animated: false, completion: nil)
                    }
                }
                //self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
    
}
