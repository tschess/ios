//
//  ActualTable.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class MenuTable: UITableViewController, SwipeTableViewCellDelegate {
    
    var menu: Menu?
    var indexPage: Int
    var listEntityGame: [EntityGame]
    
    required init?(coder aDecoder: NSCoder) {
        self.indexPage = 0
        self.listEntityGame = [EntityGame]()
        super.init(coder: aDecoder)
    }
    
    func fetchList() {
        self.menu!.setIndicator()
        let request: [String: Any] = ["id": self.menu!.playerSelf!.id, "index": self.indexPage, "size": Const().PAGE_SIZE, "self": true]
        RequestActual().execute(requestPayload: request) { (result) in
            self.menu!.setIndicator(on: false)
            self.menuTableListAppend(list: result)
        }
    }
    
    func menuTableListAppend(list: [EntityGame]) {
        let count0 = self.listEntityGame.count
        for game: EntityGame in list {
            if(self.listEntityGame.contains(game)){
                continue
            }
            self.listEntityGame.append(game)
        }
        let count1 = listEntityGame.count
        if(count0 != count1){
            self.menu!.setIndicator(on: false)
        }
    }
    
    // MARK: LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.tableFooterView = UIView()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.white
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(refreshControl: UIRefreshControl?) {
        self.indexPage = 0
        let request: [String: Any] = ["id": self.menu!.playerSelf!.id, "index": self.indexPage, "size": Const().PAGE_SIZE, "self": true]
        RequestActual().execute(requestPayload: request) { (result) in
            self.menu!.setIndicator(on: false)
            DispatchQueue.main.async {
                self.listEntityGame = result
                self.tableView.reloadData()
                if(refreshControl == nil){
                    return
                }
                refreshControl!.endRefreshing()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let visibleRows = self.tableView.indexPathsForVisibleRows
        let lastRow = visibleRows?.last?.row
        if(lastRow == nil){
            return
        }
        let index = self.indexPage
        let indexFrom: Int =  index * Const().PAGE_SIZE
        let indexTo: Int = indexFrom + Const().PAGE_SIZE - 2
        if lastRow == indexTo {
            self.indexPage += 1
            self.fetchList()
        }
    }
    
    // MARK: TABLE
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listEntityGame.count
    }
    
    private func swipeResolved(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        let username: String = self.menu!.playerSelf!.username
        if(orientation == .right) {
            let rematch = SwipeAction(style: .default, title: nil) { action, indexPath in
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                cell.hideSwipe(animated: false, completion: nil)
                
                let game: EntityGame = self.listEntityGame[indexPath.row]
                let playerOther: EntityPlayer = game.getPlayerOther(username: username)

                DispatchQueue.main.async {
                    var storyboard: UIStoryboard = UIStoryboard(name: "ChallengeP", bundle: nil)
                    var viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeP") as! Challenge
                    if(UIScreen.main.bounds.height.isLess(than: 750)){
                        storyboard = UIStoryboard(name: "ChallengeL", bundle: nil)
                        viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeL") as! Challenge
                    }
                    viewController.playerSelf = self.menu!.playerSelf!
                    viewController.playerOther = playerOther
                    viewController.selection = Int.random(in: 0...3)
                    viewController.BACK = "OTHER"
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
            rematch.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            rematch.title = "rematch"
            if(game.condition == "DRAW"){
                rematch.textColor = .yellow
                rematch.image = UIImage(named: "challenge_yel")!
                return [rematch]
            }
            if(game.getWinner(username: username)){
                rematch.textColor = .green
                rematch.image = UIImage(named: "challenge_grn")!
                return [rematch]
            }
            rematch.textColor = .red
            rematch.image = UIImage(named: "challenge_red")!
            return [rematch]
        }
        return nil
    }
    
    private func swipProposedInbound(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        if(orientation == .left) {
            let nAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                cell.hideSwipe(animated: false, completion: nil)
                
                self.menu!.setIndicator()
                let requestPayload: [String: Any] = ["id_game": game.id, "id_self": self.menu!.playerSelf!.id]
                UpdateNack().execute(requestPayload: requestPayload) { (result) in
                    self.listEntityGame.remove(at: indexPath.row)
                    self.menu!.setIndicator(on: false)
                }
            }
            nAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            nAction.image = UIImage(named: "td_w")!
            nAction.title = "reject"
            return [nAction]
        }
        let ackAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
            cell.hideSwipe(animated: false, completion: nil)
            
            let game: EntityGame = self.listEntityGame[indexPath.row]
            let username: String = self.menu!.playerSelf!.username
            let playerOther: EntityPlayer = game.getPlayerOther(username: username)
            
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "AckL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "AckL") as! Ack
                    viewController.setPlayerSelf(playerSelf: self.menu!.playerSelf!)
                    viewController.setPlayerOther(playerOther: playerOther)
                    viewController.setGameTschess(gameTschess: game)
                    viewController.setSelection(selection: Int.random(in: 0...3))
                    self.navigationController?.pushViewController(viewController, animated: false)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "AckP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "AckP") as! Ack
                viewController.setPlayerSelf(playerSelf: self.menu!.playerSelf!)
                viewController.setPlayerOther(playerOther: playerOther)
                viewController.setGameTschess(gameTschess: game)
                viewController.setSelection(selection: Int.random(in: 0...3))
                self.navigationController?.pushViewController(viewController, animated: false)
            }
            
        }
        ackAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
        ackAction.title = "accept"
        ackAction.image = UIImage(named: "tu_w")!
        return [ackAction]
    }
    
    private func swipProposedOutbound(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        if(orientation == .right) {
            let rescind = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                cell.hideSwipe(animated: false, completion: nil)
                
                self.menu!.setIndicator(on: true)
                let game = self.listEntityGame[indexPath.row]
                let requestPayload: [String: Any] = ["id_game": game.id, "id_self": self.menu!.playerSelf!.id]
                UpdateRescind().execute(requestPayload: requestPayload) { (result) in
                    self.listEntityGame.remove(at: indexPath.row)
                    self.menu!.setIndicator(on: false)
                }
            }
            //rescind.backgroundColor = .red
            rescind.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            rescind.image = UIImage(named: "close_w")!
            rescind.title = "rescind"
            return [rescind]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let username: String = self.menu!.playerSelf!.username
        let game = self.listEntityGame[indexPath.row]
        let inbound: Bool = game.getInboundInvitation(username: username)
        
        if(game.status == "ONGOING"){
            return nil
        }
        /* * */
        /* * */
        /* * */
        if(game.getPrompt(username: username)){
            return nil
        }
        /* * */
        /* * */
        /* * */
        if(game.isResolved()){
            return self.swipeResolved(orientation: orientation, game: game)
        }
        if(inbound){
            return self.swipProposedInbound(orientation: orientation, game: game)
        }
        return self.swipProposedOutbound(orientation: orientation, game: game)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index: Int = indexPath.row
        let game: EntityGame = self.listEntityGame[index]
        let username: String = self.menu!.playerSelf!.username
        let usernameOther: String = game.getLabelTextUsernameOpponent(username: username)
        let avatarImageOther: UIImage = game.getImageAvatarOpponent(username: username)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.delegate = self
        
        cell.setContent(usernameSelf: username, usernameOther: usernameOther, game: game, avatarImageOther: avatarImageOther)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MenuCell
        let game = self.listEntityGame[indexPath.row]
        if(game.isResolved()){
            DispatchQueue.main.async {
                cell.hideSwipe(animated: false, completion: nil)
                
                SelectSnapshot().snapshot(playerSelf: self.menu!.playerSelf!,
                                          game: game,
                                          presentor: self)
            }
            return
        }
        if(game.status == "ONGOING"){
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                let playerOther: EntityPlayer = game.getPlayerOther(username: self.menu!.playerSelf!.username)
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "dTschessL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessL") as! Tschess
                    viewController.playerOther = playerOther
                    viewController.playerSelf = self.menu!.playerSelf!
                    viewController.game = game
                    self.navigationController?.pushViewController(viewController, animated: false)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
                viewController.playerOther = playerOther
                viewController.playerSelf = self.menu!.playerSelf!
                viewController.game = game
                self.navigationController?.pushViewController(viewController, animated: false)
            }
            return
        }
        if(game.getInboundInvitation(username: self.menu!.playerSelf!.username)){
            cell.showSwipe(orientation: .right, animated: true)
            return
        }
        return cell.showSwipe(orientation: .left, animated: true)
    }
}
