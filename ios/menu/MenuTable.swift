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
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        print("lol")
        return nil
    }
    
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
                    viewController.player = self.menu!.playerSelf!
                    viewController.game = game
                    self.navigationController?.pushViewController(viewController, animated: false)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
                viewController.playerOther = playerOther
                viewController.player = self.menu!.playerSelf!
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
