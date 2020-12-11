//
//  HomeMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit


class HomeTable: UITableViewController, SwipeTableViewCellDelegate {
        
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let username: String = self.activity!.player!.username
        let game = self.list[indexPath.row]
        if(game.status == "ONGOING"){
            return nil
        }
        if(game.isResolved()){
            return self.swipeResolved(orientation: orientation, game: game)
        }
        let inbound: Bool = game.getInboundInvitation(username: username)
        if(inbound){
            return self.swipProposedInbound(orientation: orientation, game: game)
        }
        return self.swipProposedOutbound(orientation: orientation, game: game)
    }
    
    func invite(opponent: EntityPlayer, game: EntityGame, ACCEPT: Bool = false, REMATCH: Bool = false) {
        let storyboard: UIStoryboard = UIStoryboard(name: "PopInvite", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvite") as! PopInvite
        viewController.ACCEPT = ACCEPT
        viewController.REMATCH = REMATCH
        viewController.player = self.activity!.player
        viewController.opponent = opponent
        viewController.test = self.activity!.navigationController
        viewController.game = game
        self.activity!.present(viewController, animated: true, completion: nil)
    }
    
    private func swipProposedInbound(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        if(orientation == .left) {
            return nil
        }
        let nAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
            cell.hideSwipe(animated: false, completion: nil)
            
            self.activity!.header!.setIndicator(on: true)
            let requestPayload: [String: Any] = ["id_game": game.id, "id_self": self.activity!.player!.id]
            UpdateNack().execute(requestPayload: requestPayload) { (result) in
                self.list.remove(at: indexPath.row)
                self.activity!.header!.setIndicator(on: false, tableView: self.activity!.table!)
            }
        }
        nAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
        nAction.image = UIImage(named: "td_w")!
        nAction.title = "reject"
        
        let ackAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
            cell.hideSwipe(animated: false, completion: nil)
            
            let game: EntityGame = self.list[indexPath.row]
            let username: String = self.activity!.player!.username
            let opponent: EntityPlayer = game.getPlayerOther(username: username)
            self.invite(opponent: opponent, game: game, ACCEPT: true)
        }
        ackAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
        ackAction.title = "Accept"
        ackAction.image = UIImage(named: "tu_w")!
        return [ackAction,nAction]
    }
    
    private func swipProposedOutbound(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        if(orientation == .right) {
            let rescind = SwipeAction(style: .default, title: nil) { action, indexPath in
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                cell.hideSwipe(animated: false, completion: nil)
                self.activity!.header!.setIndicator(on: true)
                let game = self.list[indexPath.row]
                let requestPayload: [String: Any] = ["id_game": game.id, "id_self": self.activity!.player!.id]
                UpdateRescind().execute(requestPayload: requestPayload) { (result) in
                    self.list.remove(at: indexPath.row)
                    self.activity!.header!.setIndicator(on: false, tableView: self.activity!.table!)
                }
            }
            rescind.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            rescind.image = UIImage(named: "close_w")!
            rescind.title = "Rescind"
            return [rescind]
        }
        return nil
    }
    
    private func swipeResolved(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        let username: String = self.activity!.player!.username
        if(orientation == .right) {
            let rematch = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                
                cell.hideSwipe(animated: false, completion: nil)
                
                let game: EntityGame = self.list[indexPath.row]
                
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
                    viewController.game = game
                    viewController.player = self.activity!.player!
                    self.activity!.present(viewController, animated: false, completion: nil)
                }
            }
            rematch.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            rematch.title = "Snapshot"
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
    
    var swiped: Bool
    var index: Int
    var list: [EntityGame]
    var activity: Home?
    
    required init?(coder aDecoder: NSCoder) {
        self.swiped = false
        self.index = 0
        self.list = [EntityGame]()
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func viewDidLoad() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.white
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(refreshControl: UIRefreshControl?) {
        self.index = 0
        self.fetch(refreshControl: refreshControl, refresh: true)
    }
    
    func fetch(refreshControl: UIRefreshControl? = nil, refresh: Bool = false) {
        if(!refresh){
            self.activity!.header!.setIndicator(on: true)
        }
        let payload = ["id": self.activity!.player!.id,
                       "index": self.index,
                       "size": Const().PAGE_SIZE,
                       "self": true
        ] as [String: Any]
        RequestActual().execute(requestPayload: payload) { (result) in
            if(refreshControl != nil){
                self.list = [EntityGame]()
                DispatchQueue.main.async {
                    refreshControl!.endRefreshing()
                }
            }
            self.appendToLeaderboardTableList(additionalCellList: result)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectSelectedRow(animated: true)
        
        let game = self.list[indexPath.row]
        if(game.isResolved()){
            let game: EntityGame = self.list[indexPath.row]
            let username: String = self.activity!.player!.username
            let opponent: EntityPlayer = game.getPlayerOther(username: username)
            self.invite(opponent: opponent, game: game, REMATCH: true)
            return
        }
        if(game.status == "ONGOING"){
            let opponent: EntityPlayer = game.getPlayerOther(username: self.activity!.player!.username)
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                viewController.playerOther = opponent
                viewController.player = self.activity!.player!
                viewController.game = game
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index: Int = indexPath.row
        let game: EntityGame = self.list[index]
        let username: String = self.activity!.player!.username
        let opponentUsername: String = game.getLabelTextUsernameOpponent(username: username)
        let opponentAvatar: UIImage = game.getImageAvatarOpponent(username: username)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.delegate = self
        cell.setContent(usernameSelf: username, usernameOther: opponentUsername, game: game, avatarImageOther: opponentAvatar)
        return cell
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        guard let cell = sender.view?.superview?.superview as? HomeCell else {
            return
        }
        if(!self.swiped){
            cell.showSwipe(orientation: .right, animated: true)
            self.swiped = true
            return
        }
        cell.hideSwipe(animated: true, completion: nil)
        self.swiped = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let listRowVisible: [IndexPath]? = self.tableView.indexPathsForVisibleRows
        let rowLast = listRowVisible?.last?.row
        if(rowLast == nil){
            return
        }
        let index = self.index
        let size = Const().PAGE_SIZE
        let indexFrom: Int =  index * size
        let indexTo: Int = indexFrom + Const().PAGE_SIZE - 2
        if rowLast == indexTo {
            self.index += 1
            self.fetch()
        }
    }
    
    func appendToLeaderboardTableList(additionalCellList: [EntityGame]) {
        for game in additionalCellList {
            self.list.append(game)
        }
        self.activity!.header!.setIndicator(on: false, tableView: self)
    }
}



extension UITableView {

    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }

}
