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
    
    public func setChess(chess: Tschess) {
        self.chess = chess
    }
    
    @IBOutlet weak var imageViewKnight: UIImageView!
    @IBOutlet weak var imageViewBishop: UIImageView!
    @IBOutlet weak var imageViewQueen: UIImageView!
    @IBOutlet weak var imageViewRook: UIImageView!
    
    private var customTransitioningDelegate = TransPro()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
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
        self.execute(promotionWhite: KnightWhite(), promotionBlack: KnightBlack())
    }
    
    @objc func clickBishop(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) == nil {
            return
        }
        self.execute(promotionWhite: BishopWhite(), promotionBlack: BishopBlack())
    }
    
    @objc func clickRook(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) == nil {
            return
        }
        self.execute(promotionWhite: RookWhite(), promotionBlack: RookBlack())
    }
    
    @objc func clickQueen(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) == nil {
            return
        }
        self.execute(promotionWhite: QueenWhite(), promotionBlack: QueenBlack())
    }
    
    public func evaluate(coordinate: [Int], proposed: [Int]) -> Bool {
        let state = self.chess!.game!.getStateClient(username: self.chess!.playerSelf!.username)
        let tschessElement = state[coordinate[0]][coordinate[1]]
        if(tschessElement == nil){
            return false
        }
        if(tschessElement!.name.contains("Pawn")) {
            let rank = proposed[0] == 0
            let move = coordinate[0] - proposed[0] == 1
            if(rank && move){
                return true
            }
        }
        return false
    }
    
    var transitioner: Transitioner?
    
    public func setTransitioner(transitioner: Transitioner) {
        self.transitioner = transitioner
    }
    
    var proposed: [Int]?
    
    public func setProposed(proposed: [Int]) {
        self.proposed = proposed
    }
    
    private func execute(promotionWhite: Piece, promotionBlack: Piece) {
        var promotionPiece: Piece = promotionWhite
        
        let white: Bool = self.chess!.game!.getWhite(username: self.chess!.playerSelf!.username)
        if(!white){
            promotionPiece = promotionBlack
        }
        
        var state = self.chess!.game!.getStateClient(username: self.chess!.playerSelf!.username)
        let coordinate: [Int]? = self.transitioner!.getCoordinate()
        state[coordinate![0]][coordinate![1]] = nil
        state[proposed![0]][proposed![1]] = promotionPiece
        
        self.chess!.tschessElementMatrix = self.transitioner!.deselectHighlight(state0: self.chess!.tschessElementMatrix!)
        let stateUpdate = SerializerState(white: white).renderServer(state: state)
        
        let hx: Int = white ? proposed![0] : 7 - proposed![0]
        let hy: Int = white ? proposed![1] : 7 - proposed![1]
        let h0: Int = white ? coordinate![0] : 7 - coordinate![0]
        let h1: Int = white ? coordinate![1] : 7 - coordinate![1]
        let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
        
        let requestPayload: [String: Any] = ["id_game": self.chess!.game!.id, "state": stateUpdate, "highlight": highlight, "condition": "TBD"]
        DispatchQueue.main.async() {
            self.chess!.activityIndicator.isHidden = false
            self.chess!.activityIndicator.startAnimating()
        }
        GameUpdate().success(requestPayload: requestPayload) { (success) in
            if(!success){
                //error
            }
            self.transitioner!.clearCoordinate()
        }
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
}
