//
//  HomeMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
//import SwipeCellKit


class HomeTable: UITableViewController {
    
    var swiped: Bool
    var index: Int
    var list: [EntityGame]
    var activity: HomeActivity?
    
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
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        self.index = 0
        self.fetch(refreshControl: refreshControl)
    }
    
    func fetch(refreshControl: UIRefreshControl? = nil) {
        self.activity!.setIndicator(on: true)
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
            } else {
                self.activity!.setIndicator(on: false)
            }
            self.appendToLeaderboardTableList(additionalCellList: result)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selection: [String: Any] = ["home_menu_selection": indexPath.row]
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "HomeMenuSelection"),
            object: nil,
            userInfo: selection)
    }
    
    //func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        //let username: String = self.activity!.player!.username
        //let game = self.list[indexPath.row]
        //if(game.status == "ONGOING"){
            //return nil
        //}
        //if(game.isResolved()){
            //return self.swipeResolved(orientation: orientation, game: game)
        //}
        //let inbound: Bool = game.getInboundInvitation(username: username)
        //if(inbound){
            //return self.swipProposedInbound(orientation: orientation, game: game)
        //}
        //return self.swipProposedOutbound(orientation: orientation, game: game)
    //}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index: Int = indexPath.row
        let game: EntityGame = self.list[index]
        let username: String = self.activity!.player!.username
        let usernameOther: String = game.getLabelTextUsernameOpponent(username: username)
        let avatarImageOther: UIImage = game.getImageAvatarOpponent(username: username)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        //cell.delegate = self
        cell.setContent(usernameSelf: username, usernameOther: usernameOther, game: game, avatarImageOther: avatarImageOther)
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
        let visibleRows = self.tableView.indexPathsForVisibleRows
        let lastRow = visibleRows?.last?.row
        if(lastRow == nil){
            return
        }
        let index = self.index
        let size = Const().PAGE_SIZE
        let indexFrom: Int =  index * size
        let indexTo: Int = indexFrom + Const().PAGE_SIZE - 2
        if lastRow == indexTo {
            self.index += 1
            self.fetch()
        }
    }
    
    func appendToLeaderboardTableList(additionalCellList: [EntityGame]) {
        for game in additionalCellList {
            self.list.append(game)
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    //private func swipeResolved(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        //let username: String = self.activity!.player!.username
        //if(orientation == .right) {
            //let rematch = SwipeAction(style: .default, title: nil) { action, indexPath in
                //let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                //cell.hideSwipe(animated: false, completion: nil)
                
                //let game: EntityGame = self.list[indexPath.row]
                //let opponent: EntityPlayer = game.getPlayerOther(username: username)
                //DispatchQueue.main.async {
                //var storyboard: UIStoryboard = UIStoryboard(name: "ChallengeP", bundle: nil)
                //var viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeP") as! Challenge
                //if(UIScreen.main.bounds.height.isLess(than: 750)){
                //storyboard = UIStoryboard(name: "ChallengeL", bundle: nil)
                //viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeL") as! Challenge
                //}
                //viewController.playerSelf = self.activity!.player!
                //viewController.playerOther = playerOther
                //viewController.selection = Int.random(in: 0...3)
                //viewController.BACK = "OTHER"
                //self.navigationController?.pushViewController(viewController, animated: false)
                //}
            //}
            //rematch.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            //rematch.title = "rematch"
            //if(game.condition == "DRAW"){
                //rematch.textColor = .yellow
                //rematch.image = UIImage(named: "challenge_yel")!
                //return [rematch]
            //}
            //if(game.getWinner(username: username)){
                //rematch.textColor = .green
                //rematch.image = UIImage(named: "challenge_grn")!
                //return [rematch]
            //}
            //rematch.textColor = .red
            //rematch.image = UIImage(named: "challenge_red")!
            //return [rematch]
        //}
        //return nil
    //}
    
    //private func swipProposedInbound(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        //if(orientation == .left) {
            //let nAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                //let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                //cell.hideSwipe(animated: false, completion: nil)
                
                //self.activity!.setIndicator(on: true)
                //let requestPayload: [String: Any] = ["id_game": game.id, "id_self": self.activity!.player!.id]
                //UpdateNack().execute(requestPayload: requestPayload) { (result) in
                    //self.list.remove(at: indexPath.row)
                    //self.activity!.setIndicator(on: false)
                //}
            //}
            //nAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            //nAction.image = UIImage(named: "td_w")!
            //nAction.title = "reject"
            //return [nAction]
        //}
        //let ackAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            //let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
            //cell.hideSwipe(animated: false, completion: nil)
            
            //let game: EntityGame = self.list[indexPath.row]
            //let username: String = self.activity!.player!.username
            //let playerOther: EntityPlayer = game.getPlayerOther(username: username)
            
            //DispatchQueue.main.async {
                //let height: CGFloat = UIScreen.main.bounds.height
                //if(height.isLess(than: 750)){
                    //let storyboard: UIStoryboard = UIStoryboard(name: "AckL", bundle: nil)
                    //let viewController = storyboard.instantiateViewController(withIdentifier: "AckL") as! Ack
                    //viewController.setPlayerSelf(playerSelf: self.activity!.player!)
                    //viewController.setPlayerOther(playerOther: playerOther)
                    //viewController.setGameTschess(gameTschess: game)
                    //viewController.setSelection(selection: Int.random(in: 0...3))
                    //self.navigationController?.pushViewController(viewController, animated: false)
                    //return
                //}
                //let storyboard: UIStoryboard = UIStoryboard(name: "AckP", bundle: nil)
                //let viewController = storyboard.instantiateViewController(withIdentifier: "AckP") as! Ack
                //viewController.setPlayerSelf(playerSelf: self.activity!.player!)
                //viewController.setPlayerOther(playerOther: playerOther)
                //viewController.setGameTschess(gameTschess: game)
                //viewController.setSelection(selection: Int.random(in: 0...3))
                //self.navigationController?.pushViewController(viewController, animated: false)
            //}
        //}
        //ackAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
        //ackAction.title = "accept"
        //ackAction.image = UIImage(named: "tu_w")!
        //return [ackAction]
    //}
    
    //private func swipProposedOutbound(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        //if(orientation == .right) {
            //let rescind = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                //let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                //cell.hideSwipe(animated: false, completion: nil)
                
                //self.activity!.setIndicator(on: true)
                //let game = self.list[indexPath.row]
                //let requestPayload: [String: Any] = ["id_game": game.id, "id_self": self.activity!.player!.id]
                //UpdateRescind().execute(requestPayload: requestPayload) { (result) in
                    //self.list.remove(at: indexPath.row)
                    //self.activity!.setIndicator(on: false)
                //}
            //}
            //rescind.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            //rescind.image = UIImage(named: "close_w")!
            //rescind.title = "rescind"
            //return [rescind]
        //}
        //return nil
    //}
}
