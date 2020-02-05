//
//  Promotion.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Promotion: UIViewController {
    
    var chess: Tschess?
    var coordinate: [Int]?
    
    @IBOutlet weak var imageViewKnight: UIImageView!
    @IBOutlet weak var imageViewBishop: UIImageView!
    @IBOutlet weak var imageViewQueen: UIImageView!
    @IBOutlet weak var imageViewRook: UIImageView!
    
    private var customTransitioningDelegate = TransitioningDelegate()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    
    
    
    public func setChess(chess: Tschess) {
        self.chess = chess
    }
    
    var transitioner: Transitioner?
    public func setTransitioner(transitioner: Transitioner) {
        self.transitioner = transitioner
    }
    
    var proposed: [Int]?
    public func setProposed(proposed: [Int]) {
        self.proposed = proposed
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = customTransitioningDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clickKnight = UITapGestureRecognizer(target: self, action: #selector(self.clickKnight(gesture:)))
        imageViewKnight.addGestureRecognizer(clickKnight)
        imageViewKnight.isUserInteractionEnabled = true
        
        let clickBishop = UITapGestureRecognizer(target: self, action: #selector(self.clickBishop(gesture:)))
        imageViewBishop.addGestureRecognizer(clickBishop)
        imageViewBishop.isUserInteractionEnabled = true
        
        let clickRook = UITapGestureRecognizer(target: self, action: #selector(self.clickRook(gesture:)))
        imageViewRook.addGestureRecognizer(clickRook)
        imageViewRook.isUserInteractionEnabled = true
        
        let clickQueen = UITapGestureRecognizer(target: self, action: #selector(self.clickQueen(gesture:)))
        imageViewQueen.addGestureRecognizer(clickQueen)
        imageViewQueen.isUserInteractionEnabled = true
    }
    
    @objc func clickKnight(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) == nil {
            return
        }
        self.execute(white: WhiteKnight(), black: BlackKnight())
    }
    
    @objc func clickBishop(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) == nil {
            return
        }
        self.execute(white: WhiteBishop(), black: BlackBishop())
    }
    
    @objc func clickRook(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) == nil {
            return
        }
        self.execute(white: WhiteRook(), black: BlackRook())
    }
    
    @objc func clickQueen(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) == nil {
            return
        }
        self.execute(white: WhiteQueen(), black: BlackQueen())
    }
    
    public func evaluate(coordinate: [Int], proposed: [Int]) -> Bool {
//        let gamestate = self.chess!.getGamestate()
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        let tschessElement = tschessElementMatrix[coordinate[0]][coordinate[1]]
//        if(tschessElement == nil){
//            return false
//        }
//        if(tschessElement!.name.contains("Arrow")) {
//            return false
//        }
//        if(tschessElement!.name.contains("Pawn")) {
//            let rank = proposed[0] == 0
//            let move = coordinate[0] - proposed[0] == 1
//            if(rank && move){
//                self.coordinate = coordinate
//                return true
//            }
//        }
        return false
    }
    
    private func execute(white: TschessElement, black: TschessElement) {
//        let gamestate = self.chess!.getGamestate()
//        var tschessElementMatrix = gamestate.getTschessElementMatrix()
//        var tschessElement: TschessElement = white
//        let affiliation = gamestate.getSelfAffiliation()
//        if(affiliation != "WHITE"){
//            tschessElement = black
//        }
//        tschessElementMatrix[proposed![0]][proposed![1]] = tschessElement
//        tschessElementMatrix[coordinate![0]][coordinate![1]] = nil
//
//        Highlighter().restoreSelection(coordinate: proposed!, gamestate: gamestate)
//        Highlighter().neutralize(gamestate: gamestate)
//
//        // is this redundant from render effect????
//        gamestate.setLastMoveUpdate(gamestate: gamestate)
//        gamestate.changeTurn()
//        gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//        gamestate.setDrawProposer(drawProposer: "NONE")
//
//        Transitioner().evaluateCheckMate(gamestate: gamestate)
//
//        let requestUpdate = GamestateSerializer().execute(gamestate: gamestate)
//        UpdateGamestate().execute(requestPayload: requestUpdate)
//
//        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
}
