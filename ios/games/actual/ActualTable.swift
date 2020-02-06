//
//  ActualTable.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class ActualTable: UITableViewController, SwipeTableViewCellDelegate {
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    var gameMenuTableList: [EntityGame] = [EntityGame]()
    
    func getGameMenuTableList() -> [EntityGame] {
        return gameMenuTableList
    }
    
    var label: UILabel?
    
    public var pageFromWhichContentLoads: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.pageFromWhichContentLoads = 0
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    var activityIndicator: UIActivityIndicatorView?
    
    public func setIndicator(indicator: UIActivityIndicatorView){
        self.activityIndicator = indicator
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameMenuTableList.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let game = gameMenuTableList[indexPath.row]
        if(game.status == "ONGOING"){
            print(" - Tschess - ")
            //            let requestPayload: [String: Any] = ["id_game": gameModel.getIdentifier(), "id_player": self.player!.getId()]
            //            let gameAck: GameAck = GameAck(idGame: gameModel.getIdentifier(), playerSelf: self.player!, playerOppo: gameModel.getOpponent())
            //            let gameConnect: GameConnect = GameConnect(gameAck: gameAck)
            //            RequestConnect().execute(requestPayload: requestPayload, gameConnect: gameConnect) { (gameTschess) in
            //                print("result: \(gameTschess)")
            //                /**
            //                 * ERROR HANDLING!!!
            //                 */
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                viewController.setPlayerOther(playerOther: game.getPlayerOther(username: self.playerSelf!.username))
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setGameTschess(gameTschess: game)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return nil
        }
        if(game.getInboundInvitation(username: self.playerSelf!.username)){
            
            guard orientation == .right else {
                let nAction = SwipeAction(style: .default, title: "nACK") { action, indexPath in
                    print("nACK")
                    self.activityIndicator!.isHidden = false
                    self.activityIndicator!.startAnimating()
                    //                            let requestPayload: [String: Any] = ["id_game": game.identifier!, "id_player": self.player!.getId()]
                    //
                    //                            UpdateNack().execute(requestPayload: requestPayload) { (player) in
                    //                                print("player: \(player)")
                    //                                //ERROR...
                    //                                self.setPlayer(player: player!)
                    //                                self.actual!.setPlayer(player: player!)
                    //                                DispatchQueue.main.async {
                    //                                    self.actual!.renderHeader()
                    //                                    self.activityIndicator!.stopAnimating()
                    //                                    self.activityIndicator!.isHidden = true
                    //                                    self.gameMenuTableList.remove(at: indexPath.row)
                    //                                    self.tableView!.reloadData()
                    //                                }
                    //                            }
                }
                nAction.backgroundColor = .red
                if #available(iOS 13.0, *) {
                    nAction.image = UIImage(systemName: "hand.thumbsdown.fill")!
                }
                return [nAction]
            }
            let ackAction = SwipeAction(style: .default, title: "ACK") { action, indexPath in
                
                let game = self.gameMenuTableList[indexPath.row]
                let playerOther: EntityPlayer = game.getPlayerOther(username: self.playerSelf!.username)
                
                //            print("ACK")
                let storyboard: UIStoryboard = UIStoryboard(name: "Ack", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Ack") as! Ack
                viewController.setPlayerOther(playerOther: playerOther)
                viewController.setPlayer(player: self.playerSelf!)
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setGameTschess(gameTschess: game)
                
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            ackAction.backgroundColor = .green
            if #available(iOS 13.0, *) {
                ackAction.image = UIImage(systemName: "hand.thumbsup.fill")!
            }
            return [ackAction]
            
        }
        guard orientation == .left else {
            return nil
        }
        
        let rescind = SwipeAction(style: .default, title: "RESCIND") { action, indexPath in
            print("RESCIND")
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            //            let requestPayload: [String: Any] = ["id_game": game.identifier!, "id_player": self.player!.getId()]
            //
            //            UpdateRescind().execute(requestPayload: requestPayload) { (result) in
            //                print("result: \(result)")
            //                DispatchQueue.main.async {
            //                    self.activityIndicator!.stopAnimating()
            //                    self.activityIndicator!.isHidden = true
            //                    self.gameMenuTableList.remove(at: indexPath.row)
            //                    self.tableView!.reloadData()
            //                }
            //            }
        }
        rescind.backgroundColor = .orange
        if #available(iOS 13.0, *) {
            rescind.image = UIImage(systemName: "xmark.rectangle.fill")!
        }
        return [rescind]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = gameMenuTableList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActualCell", for: indexPath) as! ActualCell
        cell.delegate = self
        cell.usernameLabel.text = game.getLabelTextUsernameOpponent(username: self.playerSelf!.username)
        cell.avatarImageView.image = game.getImageAvatarOpponent(username: self.playerSelf!.username)
        
        if(game.status == "ONGOING"){
            cell.timeIndicatorLabel.text = game.getLabelTextDate(update: true)
            if(game.getInboundGame(username: self.playerSelf!.username)){
                if #available(iOS 13.0, *) {
                    let image = UIImage(systemName: "gamecontroller.fill")!
                    cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
                    cell.actionImageView.tintColor = .black
                }
                return cell
            }
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "gamecontroller")!
                cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
                cell.actionImageView.tintColor = .black
            }
            return cell
        }
        if(game.status == "PROPOSED"){
            cell.timeIndicatorLabel.text = game.getLabelTextDate(update: false)
            if(game.getInboundInvitation(username: self.playerSelf!.username)){
                if #available(iOS 13.0, *) {
                    cell.actionImageView.tintColor = .black
                    let image = UIImage(systemName: "tray.and.arrow.down")!
                    cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
                }
                return cell
            }
            if #available(iOS 13.0, *) {
                cell.actionImageView.tintColor = .black
                let image = UIImage(systemName: "tray.and.arrow.up")!
                cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! ActualCell
        let game = gameMenuTableList[indexPath.row]
        if(game.getInboundInvitation(username: self.playerSelf!.username)){
            cell.showSwipe(orientation: .right, animated: true)
            return
        }
        return cell.showSwipe(orientation: .left, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let visibleRows = self.tableView.indexPathsForVisibleRows
        let lastRow = visibleRows?.last?.row
        if(lastRow == nil){
            return
        }
        let REQUEST_PAGE_SIZE: Int = 9
        
        let index = self.pageFromWhichContentLoads
        let size = REQUEST_PAGE_SIZE
        let indexFrom: Int =  index * size
        let indexTo: Int = indexFrom + REQUEST_PAGE_SIZE - 2
        
        if(lastRow! <= indexTo){
            return
        }
        if lastRow == indexTo {
            self.pageFromWhichContentLoads += 1
            self.fetchMenuTableList()
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let gameTableMenuItem = gameMenuTableList[indexPath.row]
        let closeAction = UIContextualAction(style: .normal, title:  "nACK", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, marked as Closed")
            success(true)
        })
        if #available(iOS 13.0, *) {
            closeAction.image = UIImage(systemName: "hand.thumbsdown.fill")!
        }
        closeAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let game = gameMenuTableList[indexPath.row]
        if(game.getInboundInvitation(username: self.playerSelf!.username)){
            let modifyAction = UIContextualAction(style: .normal, title:  "ACK", handler: { (ac:UIContextualAction, view: UIView, success: (Bool) -> Void) in
                print("Update action ...")
                success(true)
            })
            if #available(iOS 13.0, *) {
                modifyAction.image = UIImage(systemName: "hand.thumbsup.fill")!
            }
            modifyAction.backgroundColor = .green
            return UISwipeActionsConfiguration(actions: [modifyAction])
        }
        return nil
    }
    
    func appendToTableList(additionalCellList: [EntityGame]) {
        let currentCount = self.gameMenuTableList.count
        
        for game in additionalCellList {
            if(!self.gameMenuTableList.contains(game)){
                self.gameMenuTableList.append(game)
            }
        }
        if(currentCount != self.gameMenuTableList.count){
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchMenuTableList() {
        
        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            
        }
        let REQUEST_PAGE_SIZE: Int = 9
        //let pageFromWhichContentLoads: Int = 0
        let requestPayload = [
            "id": self.playerSelf!.id,
            "index": self.pageFromWhichContentLoads, //TODO ~ remove this...
            "size": REQUEST_PAGE_SIZE
            ] as [String: Any]
        
        RequestActual().execute(requestPayload: requestPayload) { (result) in
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            if(result == nil){
                return
            }
            self.appendToTableList(additionalCellList: result!)
        }
    }
    
}

extension UITableView {
    
    var selectionCount: Int {
        let sections = self.numberOfSections
        var rows = 0
        for i in 0...sections - 1 {
            rows += self.numberOfRows(inSection: i)
        }
        return rows
    }
}
