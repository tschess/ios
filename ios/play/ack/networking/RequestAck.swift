//
//  RequestAck.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestAck {
    
    func execute(requestPayload: [String: Any], tschessCore: TschessCore, completion: @escaping ((TschessCore?) -> Void)) {
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/ack")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                
                let matrixDeserializer = MatrixDeserializer()
                matrixDeserializer.setUsername(username: tschessCore.playerSelf.username)
                matrixDeserializer.setUsernameWhite(username: tschessCore.playerSelf.username)
                matrixDeserializer.setUsernameBlack(username: tschessCore.playerOppo.username)
                
                print("999\n\n\n")
                print(json)
                print("\n\n\n999")
                
//                skin: SKIN? = nil,
//                       white: Bool? = nil,
//                       state: [[TschessElement?]]? = nil
                
                let white: Bool = json["white"] as! Bool
                print("white: \(white)")
                if(!white){
                    matrixDeserializer.setUsernameWhite(username: tschessCore.playerOppo.username)
                    matrixDeserializer.setUsernameBlack(username: tschessCore.playerSelf.username)
                }
                
               
                matrixDeserializer.setGameStatus(gameStatus: "ONGOING") ///lalalal
                
                
                let state0: [[String]] = json["state"]! as! [[String]]
                print("json[\"state\"]: \(json["state"])\n\n")
                print("state0: \(state0)")
                
                let state = matrixDeserializer.deserialize(stringRepresentation: state0, orientationBlack: !white)
                print("\n\n state: \(state)")
                
               let skin: String = json["skin"] as! String
               print("skin: \(skin)")
         
           
                
                completion(nil)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
    
    
    public func generateTschessElementMatrix(configurationInviter: [[String]], configurationAcceptor: [[TschessElement?]])  -> [[TschessElement?]] {
        var outputRow_0 = [TschessElement?](repeating: nil, count: 8)
        var outputRow_1 = [TschessElement?](repeating: nil, count: 8)
        let outputRow_2 = [TschessElement?](repeating: nil, count: 8)
        let outputRow_3 = [TschessElement?](repeating: nil, count: 8)
        let outputRow_4 = [TschessElement?](repeating: nil, count: 8)
        let outputRow_5 = [TschessElement?](repeating: nil, count: 8)
        var outputRow_6 = [TschessElement?](repeating: nil, count: 8)
        var outputRow_7 = [TschessElement?](repeating: nil, count: 8)
        
        let row_0 = configurationInviter[1]
        //print("row_0: \(row_0)")
        outputRow_0 = buildConstituentElementList(rowElementStringArray: row_0)
        
        let row_1 = configurationInviter[0]
        //print("row_1: \(row_1)")
        outputRow_1 = buildConstituentElementList(rowElementStringArray: row_1)
        
        for i in (0 ..< 8) {
            if(configurationAcceptor[0][i] != nil) {
                outputRow_6[i] = generateTschessElementWhite(name: configurationAcceptor[0][i]!.name)
            }
            if(configurationAcceptor[1][i] != nil) {
                outputRow_7[i] = generateTschessElementWhite(name: configurationAcceptor[1][i]!.name)
            }
        }
        
        var tschessElementMatrix: [[TschessElement?]]
        tschessElementMatrix = [
            outputRow_0,
            outputRow_1,
            outputRow_2,
            outputRow_3,
            outputRow_4,
            outputRow_5,
            outputRow_6,
            outputRow_7
        ]
        return tschessElementMatrix
    }
    
    func buildConstituentElementList(rowElementStringArray: [String]) -> [TschessElement?] {
        var outputRow = [TschessElement?](repeating: nil, count: 8)
        outputRow[7] = generateTschessElementBlack(name: rowElementStringArray[7])
        outputRow[6] = generateTschessElementBlack(name: rowElementStringArray[6])
        outputRow[5] = generateTschessElementBlack(name: rowElementStringArray[5])
        outputRow[4] = generateTschessElementBlack(name: rowElementStringArray[4])
        outputRow[3] = generateTschessElementBlack(name: rowElementStringArray[3])
        outputRow[2] = generateTschessElementBlack(name: rowElementStringArray[2])
        outputRow[1] = generateTschessElementBlack(name: rowElementStringArray[1])
        outputRow[0] = generateTschessElementBlack(name: rowElementStringArray[0])
        return outputRow
    }
    
    func generateTschessElementBlack(name: String) -> TschessElement? {
        if(name.contains("Landmine")){
            let blackLandminePawn = BlackLandminePawn()
            //blackLandminePawn.setUsername(username: self.player!.getUsername())
            //blackLandminePawn.setUsernameBlack(username: self.gameModel!.getUsernameBlack())
            //blackLandminePawn.setImageVisible(imageVisible: blackLandminePawn.getImageDefault())
            return blackLandminePawn
        }
        if(name.contains("Arrow")){
            return BlackArrowPawn()
        }
        if(name.contains("Pawn")){
            return BlackPawn()
        }
        if(name.contains("Knight")){
            return BlackKnight()
        }
        if(name.contains("Bishop")){
            return BlackBishop()
        }
        if(name.contains("Rook")){
            return BlackRook()
        }
        if(name.contains("Queen")){
            return BlackQueen()
        }
        if(name.contains("King")){
            return BlackKing()
        }
        if(name.contains("Grasshopper")){
            return BlackGrasshopper()
        }
        if(name.contains("Hunter")){
            return BlackHunter()
        }
        if(name.contains("Medusa")){
            return BlackMedusa()
        }
        if(name.contains("Spy")){
            return BlackSpy()
        }
        if(name.contains("Amazon")){
            return BlackAmazon()
        }
        return nil
    }
    
    func generateTschessElementWhite(name: String) -> TschessElement? {
        if(name.contains("Landmine")){
            let whiteLandminePawn = WhiteLandminePawn()
            //whiteLandminePawn.setUsername(username: self.player!.getUsername())
            //whiteLandminePawn.setUsernameWhite(username: self.gameModel!.getUsernameWhite())
            //whiteLandminePawn.setImageVisible(imageVisible: whiteLandminePawn.getImageDefault())
            return whiteLandminePawn
        }
        if(name.contains("Arrow")){
            return WhiteArrowPawn()
        }
        if(name.contains("Pawn")){
            return WhitePawn()
        }
        if(name.contains("Knight")){
            return WhiteKnight()
        }
        if(name.contains("Bishop")){
            return WhiteBishop()
        }
        if(name.contains("Rook")){
            return WhiteRook()
        }
        if(name.contains("Queen")){
            return WhiteQueen()
        }
        if(name.contains("King")){
            return WhiteKing()
        }
        if(name.contains("Grasshopper")){
            return WhiteGrasshopper()
        }
        if(name.contains("Hunter")){
            return WhiteHunter()
        }
        if(name.contains("Medusa")){
            return WhiteMedusa()
        }
        if(name.contains("Spy")){
            return WhiteSpy()
        }
        if(name.contains("Amazon")){
            return WhiteAmazon()
        }
        return nil
    }
}
