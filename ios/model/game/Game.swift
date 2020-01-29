//
//  Game.swift
//  ios
//
//  Created by Matthew on 7/27/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Game: Equatable, Hashable {
    
    var avatarSelf: String?
    
    let dateTime: DateTime = DateTime()
    
    var hashValue: Int {
        get {
            if(identifier != nil) {
                return identifier!.hashValue
            }
            return self.opponent.getId().hashValue ^
                self.opponent.getUsername().hashValue ^
                self.opponent.getAvatar().hashValue ^
                self.opponent.getRank().hashValue ^
                self.opponent.getElo().hashValue
        }
    }
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        if(lhs.identifier != nil && rhs.identifier != nil) {
            return lhs.identifier! == rhs.identifier!
        }
        return lhs.opponent.getId()     == rhs.opponent.getId()     &&
            lhs.opponent.getUsername()   == rhs.opponent.getUsername()   &&
            lhs.opponent.getAvatar() == rhs.opponent.getAvatar() &&
            lhs.opponent.getRank()   == rhs.opponent.getRank()   &&
            lhs.opponent.getElo()    == rhs.opponent.getElo()
    }
    
    var opponent: PlayerCore
    
    var identifier: String?
    var usernameWhite: String?
    var usernameBlack: String?
    var lastMoveWhite: String?
    var lastMoveBlack: String?
    var clock: String?
    var configurationInviter: [[TschessElement?]]?
    var usernameTurn: String?
    
    var gameStatus: String
    var winner: String
    var drawProposer: String
    var checkOn: String
    
    var updated: Date?
    var created: Date?
    var outcome: String?
    var state: [[TschessElement?]]?
    
    
    
    func getOpponent() -> PlayerCore {
        return self.opponent
    }
    
    var inbound: Bool
    var invitation: Bool
    var actualDate: String
    var endDate: String
    var disp: Int
    var odds: Int
    var winnerInt: Int
    
    init(
        opponent: PlayerCore,
        identifier: String? = nil,
        usernameWhite: String? = nil,
        usernameBlack: String? = nil,
        lastMoveWhite: String? = nil,
        lastMoveBlack: String? = nil,
        clock: String? = nil,
        configurationInviter: [[TschessElement?]]? = nil,
        usernameTurn: String? = nil,
        inviterId: String? = nil,
        inviteeId: String? = nil,
        gameStatus: String = "PROPOSED",
        winner: String = "TBD",
        drawProposer: String = "NONE",
        checkOn: String = "NONE",
        
        endDate: String = "TBD",
        disp: Int = 0,
        odds: Int = 0,
        winnerInt: Int = 0,
        actualDate: String = "TBD",
        invitation: Bool = false,
        inbound: Bool = false
        
    ) {
        self.opponent = opponent
        
        self.identifier = identifier
        self.usernameWhite = usernameWhite
        self.usernameBlack = usernameBlack
        self.lastMoveWhite = lastMoveWhite
        self.lastMoveBlack = lastMoveBlack
        self.clock = clock
        self.configurationInviter = configurationInviter
        self.usernameTurn = usernameTurn
        
        self.gameStatus = gameStatus
        self.winner = winner
        self.drawProposer = drawProposer
        self.checkOn = checkOn
        
        self.updated = dateTime.currentDate()
        self.skin = "NONE"
        
        self.endDate = endDate
        self.disp = disp
        self.odds = odds
        self.winnerInt = winnerInt
        self.actualDate = actualDate
        self.invitation = invitation
        self.inbound = inbound
    }
    
    var skin: String
    
    func setSkin(skin: String) {
        self.skin = skin
    }
    
    func getSkin() -> String {
        return self.skin
    }
    
    func getOutcome() -> String? {
        return outcome
    }
    
    func setOutcome(outcome: String) {
        self.outcome = outcome
    }
    
    func setCreated(created: Date?) {
        self.created = created
    }
    
    func getCreated() -> Date? {
        return created
    }
    
    func getState() -> [[TschessElement?]]? {
        return state
    }
    
    func setState(state: [[TschessElement?]]) {
        self.state = state
    }
    
    func setConfigurationInviter(configurationInviter: [[TschessElement?]]) {
        self.configurationInviter = configurationInviter
    }
    
    func getConfigurationInviter() -> [[TschessElement?]]? {
        return self.configurationInviter
    }
    
    func setUpdated(date: Date?) {
        self.updated = date
    }
    
    func getUpdated() -> Date? {
        return updated
    }
    
    func getOpponentRank() -> String {
        opponent.getRank()
    }
    
    func setClock(clock: String) {
        self.clock = clock
    }
    
    func getClock() -> String? {
        return clock
    }
    
    func setInbound(inbound: Bool) {
        self.inbound = inbound
    }
    
    func getInbound() -> Bool? {
        return inbound
    }
    
    func setUsernameWhite(usernameWhite: String) {
        self.usernameWhite = usernameWhite
    }
    
    func setUsernameBlack(usernameBlack: String) {
        self.usernameBlack = usernameBlack
    }
    
    func setIdentifier(identifier: String) {
        self.identifier = identifier
    }
    
    func getOpponentId() -> String {
        return opponent.getId()
    }
    
    func getUsernameOpponent() -> String {
        return opponent.getUsername()
    }
    
    func getOpponentElo() -> String {
        return opponent.getElo()
    }
    
    func getOpponentAvatar() -> String {
        return opponent.getAvatar()
    }
    
    func setAvatarSelf(avatarSelf: String) {
        self.avatarSelf = avatarSelf
    }
    
    func getAvatarSelf() -> String {
        return self.avatarSelf!
    }
    
    func setUsernameTurn(usernameTurn: String) {
        self.usernameTurn = usernameTurn
    }
    
    func getUsernameTurn() -> String {
        return usernameTurn!
    }
    
    public func getUsernameWhite() -> String {
        return usernameWhite!
    }
    
    public func getUsernameBlack() -> String {
        return usernameBlack!
    }
    
    func setDrawProposer(drawProposer: String) {
        self.drawProposer = drawProposer
    }
    
    func getDrawProposer() -> String {
        return drawProposer
    }
    
    func setCheckOn(checkOn: String) {
        self.checkOn = checkOn
    }
    
    func getCheckOn() -> String {
        return checkOn
    }
    
    func setWinner(winner: String) {
        self.winner = winner
    }
    
    func getWinner() -> String {
        return winner
    }
    
    func getGameStatus() -> String {
        return gameStatus
    }
    
    func setGameStatus(gameStatus: String)  {
        self.gameStatus = gameStatus
    }
    
    public func setLastMoveWhite(lastMoveWhite: String) {
        self.lastMoveWhite = lastMoveWhite
    }
    
    public func getLastMoveWhite() -> String {
        return lastMoveWhite!
    }
    
    public func setLastMoveBlack(lastMoveBlack: String) {
        self.lastMoveBlack = lastMoveBlack
    }
    
    public func getLastMoveBlack() -> String {
        return lastMoveBlack!
    }
    
    public func getIdentifier() -> String {
        return identifier!
    }
    
    public func changeTurn() {
        if(usernameTurn == usernameWhite){
            usernameTurn = usernameBlack
        } else {
            usernameTurn = usernameWhite
        }
    }
    
    var messageWhite: String?
    public func setMessageWhite(messageWhite: String){
        self.messageWhite = messageWhite
    }
    public func getMessageWhite() -> String  {
        return self.messageWhite!
    }
    var messageBlack: String?
    public func setMessageBlack(messageBlack: String){
        self.messageBlack = messageBlack
    }
    public func getMessageBlack() -> String  {
        return self.messageBlack!
    }
    var messageWhitePosted: String?
    public func setMessageWhitePosted(messageWhitePosted: String){
        self.messageWhitePosted = messageWhitePosted
    }
    public func getMessageWhitePosted() -> String  {
        return self.messageWhitePosted!
    }
    
    var seenMessageWhite: Bool?
    public func setSeenMessageWhite(seenMessageWhite: Bool){
        self.seenMessageWhite = seenMessageWhite
    }
    public func getSeenMessageWhite() -> Bool {
        return self.seenMessageWhite!
    }
    var seenMessageBlack: Bool?
    public func setSeenMessageBlack(seenMessageBlack: Bool){
        self.seenMessageBlack = seenMessageBlack
    }
    public func getSeenMessageBlack() -> Bool {
        return self.seenMessageBlack!
    }
    var messageBlackPosted: String?
    public func setMessageBlackPosted(messageBlackPosted: String){
        self.messageBlackPosted = messageBlackPosted
    }
    public func getMessageBlackPosted() -> String  {
        return self.messageBlackPosted!
    }
    
}
