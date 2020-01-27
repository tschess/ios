//
//  Gamestate.swift
//  ios
//
//  Created by Matthew on 8/9/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class Gamestate {
    
    var updated: String
    let dateTime: DateTime = DateTime()
    
    var player: Player?
    var gameModel: Game?
    var tschessElementMatrix: [[TschessElement?]]
    
    init(gameModel: Game, tschessElementMatrix: [[TschessElement?]]) {
        self.gameModel = gameModel
        self.tschessElementMatrix = tschessElementMatrix
        self.updated = self.dateTime.currentDateString()
    }
    
    func copy() -> Gamestate {
        let copy = Gamestate(gameModel: self.getGameModel(), tschessElementMatrix: self.getTschessElementMatrix())
        
        copy.processPollingResult(lastMoveWhite: self.getLastMoveWhite(),
        lastMoveBlack: self.getLastMoveBlack(),
        tschessElementMatrix: self.getTschessElementMatrix(),
        usernameTurn: self.getUsernameTurn(),
        checkOn: self.getCheckOn(),
        winner: self.getWinner(),
        drawProposer: self.getDrawProposer())
        
        copy.setPlayer(player: self.getPlayer())
        
        return copy
    }
    
    func setSkin(skin: String) {
        self.gameModel!.setSkin(skin: skin)
    }
    
    func getSkin() -> String {
        return self.gameModel!.getSkin()
    }
    
    func setUpdated(updated: String) {
        self.updated = updated
    }
    
    func getUpdated() -> String {
       return updated
    }
    
    func processPollingResult(lastMoveWhite: String,
                              lastMoveBlack: String,
                              tschessElementMatrix: [[TschessElement?]],
                              usernameTurn: String,
                              checkOn: String,
                              winner: String,
                              drawProposer: String) {
        setLastMoveWhite(lastMoveWhite: lastMoveWhite)
        setLastMoveBlack(lastMoveBlack: lastMoveBlack)
        setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
        setUsernameTurn(usernameTurn: usernameTurn)
        setCheckOn(checkOn: checkOn)
        setWinner(winner: winner)
        setDrawProposer(drawProposer: drawProposer)
    }
    
    var highlight: [[Int]]?
    
    public func setHighlight(coords: [Int]?) {
        if(coords == nil){
            self.highlight = nil
            return
        }
        let a0 = coords![0]
        let a1 = coords![1]
        let z0 = coords![2]
        let z1 = coords![3]
        if(self.getOrientationBlack()){
            self.highlight = [[7-a0,7-a1],[7-z0,7-z1]]
            return
        }
        self.highlight = [[a0,a1],[z0,z1]]
    }
    
    public func getHighlight() -> [[Int]]?  {
        return self.highlight
    }
    
    public func setLastMoveWhite(lastMoveWhite: String) {
        gameModel!.setLastMoveWhite(lastMoveWhite: lastMoveWhite)
    }
    
    public func getLastMoveWhite() -> String {
        return gameModel!.getLastMoveWhite()
    }
    
    public func setLastMoveBlack(lastMoveBlack: String) {
        gameModel!.setLastMoveBlack(lastMoveBlack: lastMoveBlack)
    }
    
    public func getLastMoveBlack() -> String {
        return gameModel!.getLastMoveBlack()
    }
    
    func getGameModel() -> Game {
        return gameModel!
    }
    
    public func setPlayer(player: Player) {
        self.player = player
    }
    
    func getPlayer() -> Player {
        return self.player!
    }
    
    func getUsernameSelf() -> String { //!!!
        return self.player!.getUsername()
    }
    
    func getUsernameOpponent() -> String {
        return gameModel!.getUsernameOpponent()
    }
    
    func getSelfId() -> String {
        return self.player!.getId()
    }
    
    func getOpponentId() -> String {
        return gameModel!.getOpponentId()
    }
    
    public func setGameModel(gameModel: Game) {
        self.gameModel = gameModel
    }
    
    func setCheckOn(checkOn: String) {
        self.gameModel!.setCheckOn(checkOn: checkOn)
    }
    
    func getCheckOn() -> String {
        return gameModel!.getCheckOn()
    }
    
    func setWinner(winner: String) {
        gameModel!.setWinner(winner: winner)
    }
    
    func getWinner() -> String {
        return gameModel!.getWinner()
    }
    
    public func setTschessElementMatrix(tschessElementMatrix: [[TschessElement?]]) {
        self.tschessElementMatrix = tschessElementMatrix
    }
    
    func getTschessElementMatrix() -> [[TschessElement?]] {
        return tschessElementMatrix
    }
    
    func setClock(clock: String) {
        gameModel!.setClock(clock: clock)
    }
    
    func getClock() -> String? {
        return gameModel!.getClock()
    }
    
    func getSelfAffiliation() -> String {
        if(self.getUsernameSelf() == self.getUsernameWhite()){
            return "WHITE"
        }
        return "BLACK"
    }
    
    func getOpponentAffiliation() -> String {
        if(self.getUsernameSelf() == self.getUsernameWhite()){
            return "BLACK"
        }
        return "WHITE"
    }
    
    public func setLastMoveUpdate(gamestate: Gamestate) {
        let update = dateTime.currentDateString()
        gamestate.setUpdated(updated: update)
        let turn = gamestate.getUsernameTurn()
        let white = gamestate.getUsernameWhite()
        if(turn == white){
            gamestate.setLastMoveWhite(lastMoveWhite: update)
            return
        }
        gamestate.setLastMoveBlack(lastMoveBlack: update)
    }
    
    func setDrawProposer(drawProposer: String) {
        gameModel!.setDrawProposer(drawProposer: drawProposer)
    }
    
    func getDrawProposer() -> String {
        return gameModel!.getDrawProposer()
    }
    
    public func getIdentifier() -> String {
        return gameModel!.getIdentifier()
    }
    
    public func getGameStatus() -> String {
        return gameModel!.getGameStatus()
    }
    
    public func setUsernameTurn(usernameTurn: String) {
        gameModel!.setUsernameTurn(usernameTurn: usernameTurn)
    }
    
    public func getUsernameTurn() -> String {
        return gameModel!.getUsernameTurn()
    }
    
    public func getUsernameWhite() -> String {
        return gameModel!.getUsernameWhite()
    }
    
    public func getUsernameBlack() -> String {
        return gameModel!.getUsernameBlack()
    }
    
    public func changeTurn() {
        return gameModel!.changeTurn()
    }
    
    func setGameStatus(gameStatus: String)  {
        gameModel!.setGameStatus(gameStatus: gameStatus)
    }
    
    public func getOrientationBlack() -> Bool {
        if(getUsernameWhite() == self.getUsernameSelf()){
            return false
        }
        return true
    }
    
    var dict = [[Int]: Array<[Int]>]()
    
}


