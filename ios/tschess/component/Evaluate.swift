//
//  Evaluate.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Evaluate: UIViewController {
    
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
//        self.gamestate!.setDrawProposer(drawProposer: "NONE")
//
//        let requestPayload = GamestateSerializer().execute(gamestate: gamestate!, updated: self.gamestate!.getUpdated())
//        UpdateGamestate().execute(requestPayload: requestPayload)
//
//        StoryboardSelector().chess(gamestate: self.gamestate!)
    }
    
    @IBAction func acceptButtonClick(_ sender: Any) {
//        self.gamestate!.setDrawProposer(drawProposer: "NONE")
//        self.gamestate!.setWinner(winner: "DRAW")
//        
//        let requestPayload = GamestateSerializer().execute(gamestate: gamestate!)
//        UpdateGamestate().execute(requestPayload: requestPayload)
//        
//        StoryboardSelector().chess(gamestate: self.gamestate!)
    }
    
}
