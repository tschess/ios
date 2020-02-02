//
//  DrawResign.swift
//  ios
//
//  Created by Matthew on 10/18/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class DrawResign: UIViewController  {
    
    let dateTime: DateTime = DateTime()
    
    @IBOutlet weak var surrenderButton: UIButton!
    @IBOutlet weak var proposeDrawButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    private var customTransitioningDelegate = TransitioningDelegate()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    var gamestate: Gamestate?
    
    func setGamestate(gamestate: Gamestate) {
        self.gamestate = gamestate
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
    
    @IBAction func surrenderButtonClick(_ sender: Any) {
        self.gamestate!.setHighlight(coords: nil)
        let requestPayload = [
            "uuid_game": self.gamestate!.getIdentifier(),
            "uuid_player": self.gamestate!.getOpponentId(),
            "updated": dateTime.currentDateString()
        ]
        //UnilateralUpdateTask().execute(requestPayload: requestPayload, operationRoute: "resign")
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func proposeDrawButtonClick(_ sender: Any) {
        let requestPayload = [
            "uuid_game": self.gamestate!.getIdentifier(),
            "uuid_player": self.gamestate!.getSelfId(),
            "updated": dateTime.currentDateString()
        ]
        //UnilateralUpdateTask().execute(requestPayload: requestPayload, operationRoute: "draw")
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
}
