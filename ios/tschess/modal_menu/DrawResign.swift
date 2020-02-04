//
//  DrawResign.swift
//  ios
//
//  Created by Matthew on 10/18/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class DrawResign: UIViewController  {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let dateTime: DateTime = DateTime()
    
    @IBOutlet weak var surrenderButton: UIButton!
    @IBOutlet weak var proposeDrawButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    private var customTransitioningDelegate = TransitioningDelegate()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    var gameTschess: GameTschess?

       public func setGameTschess(gameTschess: GameTschess) {
           self.gameTschess = gameTschess
       }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
        self.activityIndicator.isHidden = true
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = customTransitioningDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func surrenderButtonClick(_ sender: Any) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        let requestPayload = [
            "id_game": self.gameTschess!.gameAck!.idGame,
            "id_self": self.gameTschess!.gameAck!.playerSelf.id,
            "id_oppo": self.gameTschess!.gameAck!.playerOppo.id,
            "white": self.gameTschess!.gameAck!.white!] as [String: Any]
        
//        UpdateResign {
//
//            func execute(requestPayload: [String: Any],
        
        UpdateResign().execute(requestPayload: requestPayload) { (result) in
            print("result: \(result)")
            
            DispatchQueue.main.async {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func proposeDrawButtonClick(_ sender: Any) {
//        let requestPayload = [
//            "uuid_game": self.gamestate!.getIdentifier(),
//            "uuid_player": self.gamestate!.getSelfId(),
//            "updated": dateTime.currentDateString()
//        ]
        //UnilateralUpdateTask().execute(requestPayload: requestPayload, operationRoute: "draw")
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
}
