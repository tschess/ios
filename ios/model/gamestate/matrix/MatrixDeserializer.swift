//
//  CanonicalGamestate.swift
//  ios
//
//  Created by Matthew on 11/6/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class MatrixDeserializer {
    
    var username: String?
    func setUsername(username: String) {
        self.username = username
    }
    
    var usernameWhite: String?
    func setUsernameWhite(username: String) {
        self.usernameWhite = username
    }
    
    var usernameBlack: String?
    func setUsernameBlack(username: String) {
        self.usernameBlack = username
    }
    
    var gameStatus: String?
    func setGameStatus(gameStatus: String)  {
        self.gameStatus = gameStatus
    }
    
    func generateTschessElement(name: String) -> TschessElement? {
        
        if(name.contains("WhitePawn")){
            let whitePawn = WhitePawn()
            if(!name.contains("_x")){
                whitePawn.setFirstTouch(firstTouch: false)
            }
            return whitePawn
        }
        if(name.contains("BlackPawn")){
            let blackPawn = BlackPawn()
            if(!name.contains("_x")){
                blackPawn.setFirstTouch(firstTouch: false)
            }
            return blackPawn
        }
        
        if(name.contains("WhiteKnight")){
            return WhiteKnight()
        }
        if(name.contains("BlackKnight")){
            return BlackKnight()
        }
        
        if(name.contains("WhiteBishop")){
            return WhiteBishop()
        }
        if(name.contains("BlackBishop")){
            return BlackBishop()
        }
        
        if(name.contains("WhiteRook")){
            let whiteRook = WhiteRook()
            if(!name.contains("_x")){
                whiteRook.setFirstTouch(firstTouch: false)
            }
            return whiteRook
        }
        if(name.contains("BlackRook")){
            let blackRook = BlackRook()
            if(!name.contains("_x")){
                blackRook.setFirstTouch(firstTouch: false)
            }
            return blackRook
        }
        
        if(name.contains("WhiteQueen")){
            return WhiteQueen()
        }
        if(name.contains("BlackQueen")){
            return BlackQueen()
        }
        
        if(name.contains("WhiteKing")){
            let whiteKing = WhiteKing()
            if(!name.contains("_x")){
                whiteKing.setFirstTouch(firstTouch: false)
            }
            return whiteKing
        }
        if(name.contains("BlackKing")){
            let blackKing = BlackKing()
            if(!name.contains("_x")){
                blackKing.setFirstTouch(firstTouch: false)
            }
            return blackKing
        }
        
        if(name.contains("BlackArrowPawn")){
            return BlackArrowPawn()
        }
        if(name.contains("WhiteArrowPawn")){
            return WhiteArrowPawn()
        }
        
        if(name.contains("BlackGrasshopper")){
            return BlackGrasshopper()
        }
        if(name.contains("WhiteGrasshopper")){
            return WhiteGrasshopper()
        }
        
        if(name.contains("BlackHunter")){
            return BlackHunter()
        }
        if(name.contains("WhiteHunter")){
            return WhiteHunter()
        }
        
        if(name.contains("BlackLandminePawn")){
            if(self.gameStatus! == "RESOLVED"){
                return BlackReveal()
            }
            let blackLandminePawn = BlackLandminePawn()
            if(!name.contains("_x")){
                blackLandminePawn.setFirstTouch(firstTouch: false)
            }
            blackLandminePawn.setUsername(username: username!)
            blackLandminePawn.setUsernameBlack(username: usernameBlack!)
            blackLandminePawn.setImageVisible(imageVisible: blackLandminePawn.getImageDefault())
            return blackLandminePawn
        }
        if(name.contains("WhiteLandminePawn")){
            if(self.gameStatus! == "RESOLVED"){
                return WhiteReveal()
            }
            let whiteLandminePawn = WhiteLandminePawn()
            if(!name.contains("_x")){
                whiteLandminePawn.setFirstTouch(firstTouch: false)
            }
            whiteLandminePawn.setUsername(username: username!)
            whiteLandminePawn.setUsernameWhite(username: usernameWhite!)
            whiteLandminePawn.setImageVisible(imageVisible: whiteLandminePawn.getImageDefault())
            return whiteLandminePawn
        }
        if(name.contains("WhiteReveal")){
            return WhiteReveal()
        }
        if(name.contains("BlackReveal")){
            return BlackReveal()
        }
        if(name.contains("BlackMedusa")){
            return BlackMedusa()
        }
        if(name.contains("WhiteMedusa")){
            return WhiteMedusa()
        }
        
        if(name.contains("BlackSpy")){
            return BlackSpy()
        }
        if(name.contains("WhiteSpy")){
            return WhiteSpy()
        }
        
        if(name.contains("BlackAmazon")){
            return BlackAmazon()
        }
        if(name.contains("WhiteAmazon")){
            return WhiteAmazon()
        }
        return nil
    }
    
    func buildConstituentElementList(rowDictionaryList: [String], orientationBlack: Bool) -> [TschessElement?] {
        var outputRow = [TschessElement?](repeating: nil, count: 8)
        for i in (0 ..< 8) {
            if(rowDictionaryList[i] != "") {
                if(orientationBlack){
                    if(self.generateTschessElement(name: rowDictionaryList[i]) !=  nil){
                        outputRow[7 - i] = generateTschessElement(name: rowDictionaryList[i])!
                    }
                } else {
                    if(self.generateTschessElement(name: rowDictionaryList[i]) !=  nil){
                        outputRow[i] = generateTschessElement(name: rowDictionaryList[i])!
                    }
                }
            }
        }
        return outputRow
    }
    
    public func deserialize(stringRepresentation: [[String]], orientationBlack: Bool)  -> [[TschessElement?]] {
        let rowA = self.buildConstituentElementList(rowDictionaryList: stringRepresentation[0], orientationBlack: orientationBlack)
        let rowB = self.buildConstituentElementList(rowDictionaryList: stringRepresentation[1], orientationBlack: orientationBlack)
        let rowC = self.buildConstituentElementList(rowDictionaryList: stringRepresentation[2], orientationBlack: orientationBlack)
        let rowD = self.buildConstituentElementList(rowDictionaryList: stringRepresentation[3], orientationBlack: orientationBlack)
        let rowE = self.buildConstituentElementList(rowDictionaryList: stringRepresentation[4], orientationBlack: orientationBlack)
        let rowF = self.buildConstituentElementList(rowDictionaryList: stringRepresentation[5], orientationBlack: orientationBlack)
        let rowG = self.buildConstituentElementList(rowDictionaryList: stringRepresentation[6], orientationBlack: orientationBlack)
        let rowH = self.buildConstituentElementList(rowDictionaryList: stringRepresentation[7], orientationBlack: orientationBlack)
        if(orientationBlack){
            return [rowH, rowG, rowF, rowE, rowD, rowC, rowB, rowA]
        }
        return [rowA, rowB, rowC, rowD, rowE, rowF, rowG, rowH]
    }
    
}
