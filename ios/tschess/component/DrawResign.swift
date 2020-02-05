//
//  DrawResign.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
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
    
    var gameTschess: EntityGame?

       public func setGameTschess(gameTschess: EntityGame) {
           self.gameTschess = gameTschess
       }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
        
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = customTransitioningDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
    }
    
    @IBAction func surrenderButtonClick(_ sender: Any) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
//        let requestPayload = [
//            "id_game": self.gameTschess!.idGame,
//            "id_self": self.gameTschess!.playerSelf.id,
//            "id_oppo": self.gameTschess!.playerOppo.id,
//            "white": self.gameTschess!.white!] as [String: Any]
        
//        UpdateResign {
//
//            func execute(requestPayload: [String: Any],
        
//        UpdateResign().execute(requestPayload: requestPayload) { (result) in
//            print("result: \(result)")
//            
//            DispatchQueue.main.async {
//                self.activityIndicator!.stopAnimating()
//                self.activityIndicator!.isHidden = true
//                self.presentingViewController!.dismiss(animated: false, completion: nil)
//            }
//        }
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
