//
//  TschessTests.swift
//  iosTests
//
//  Created by Matthew on 10/7/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import XCTest
@testable import ios

class TschessTests: XCTestCase {
    
    func testZero() {
        
        let stateTransitionValidator: StateTransitionValidator = StateTransitionValidator()
        
        var opponent: Opponent = Opponent(username: "000", elo: "0", avatarUrl: "000")
        
        var gameModel: Game = Game(opponent: opponent)
        
        var fairyElement: ArrowPawn = ArrowPawn()
        
        var userModel: User = User(identifier: "xxx", username: "xxx", age: "22", elo: "22", tschx: "22", avatarUrl: "yayaya", fairyElementList: [fairyElement])
        
        var row_0 = [TschessElement?](repeating: nil, count: 8)
        row_0[0] = WhitePawn()
        row_0[1] = WhitePawn()
        row_0[2] = WhitePawn()
        row_0[3] = WhitePawn()
        row_0[4] = WhitePawn()
        row_0[5] = WhitePawn()
        row_0[6] = WhitePawn()
        row_0[7] = WhitePawn()
        
        var row_1 = [TschessElement?](repeating: nil, count: 8)
        row_1[0] = WhiteRook()
        row_1[1] = WhiteKnight()
        row_1[2] = WhiteBishop()
        row_1[3] = WhiteQueen()
        row_1[4] = WhiteKing()
        row_1[5] = WhiteBishop()
        row_1[6] = WhiteKnight()
        row_1[7] = WhiteRook()
        
        let row_2 = [TschessElement?](repeating: nil, count: 8)
        let row_3 = [TschessElement?](repeating: nil, count: 8)
        let row_4 = [TschessElement?](repeating: nil, count: 8)
        let row_5 = [TschessElement?](repeating: nil, count: 8)
        
        var row_6 = [TschessElement?](repeating: nil, count: 8)
        row_6[0] = BlackRook()
        row_6[1] = BlackKnight()
        row_6[2] = BlackBishop()
        row_6[3] = BlackQueen()
        row_6[4] = BlackKing()
        row_6[5] = BlackBishop()
        row_6[6] = BlackKnight()
        row_6[7] = BlackRook()
        
        var row_7 = [TschessElement?](repeating: nil, count: 8)
        row_7[0] = BlackPawn()
        row_7[1] = BlackPawn()
        row_7[2] = BlackPawn()
        row_7[3] = BlackPawn()
        row_7[4] = BlackPawn()
        row_7[5] = BlackPawn()
        row_7[6] = BlackPawn()
        row_7[7] = BlackPawn()
        
        var tschessElementMatrix: [[TschessElement?]] = [row_0, row_1, row_2, row_3, row_4, row_5, row_6, row_7]
        
        var gamestate: Gamestate = Gamestate(gameModel: gameModel, tschessElementMatrix: tschessElementMatrix)
       
        //stateTransitionValidator.evaluateInput(coordinate: [0,0], gamestate: gamestate)
        
        //XCTAssert(myObject === otherReferenceToMyFirstObject) // passes
    }
    
}

