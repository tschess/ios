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
    
    var pageCount: Int
    
    // MARK: ~
    var menu: Menu?
    func setSelf(menu: Menu) {
        self.menu = menu
    }
    
    var gameMenuTableList: [EntityGame] = [EntityGame]()
    
    func getGameMenuTableList() -> [EntityGame] {
        return gameMenuTableList
    }
    
    func fetchMenuTableList() {
        //print("0 - self.pageCount: \(self.pageCount)")
        
        self.menu!.setIndicator(on: true)
        let request: [String: Any] = [
            "id": self.menu!.playerSelf!.id,
            "index": self.pageCount,
            "size": Const().PAGE_SIZE,
            "self": true]
        RequestActual().execute(requestPayload: request) { (result) in
            self.menu!.setIndicator(on: false)
            self.menuTableListAppend(list: result)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.pageCount = 0
        super.init(coder: aDecoder)
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
        self.pageCount = 0
        let request: [String: Any] = ["id": self.menu!.playerSelf!.id, "index": self.pageCount, "size": Const().PAGE_SIZE, "self": true]
        RequestActual().execute(requestPayload: request) { (result) in
            self.menu!.setIndicator(on: false)
            DispatchQueue.main.async {
                self.gameMenuTableList = result
                self.tableView.reloadData()
                if(refreshControl == nil){
                    return
                }
                refreshControl!.endRefreshing()
            }
        }
    }
    
    func getPageListNext() {
        //print("1 - self.pageCount: \(self.pageCount)")
        
        self.menu!.setIndicator(on: true)
        let request: [String: Any] = ["id": self.menu!.playerSelf!.id, "index": self.pageCount, "size": Const().PAGE_SIZE, "self": true]
        RequestActual().execute(requestPayload: request) { (result) in
            self.menu!.setIndicator(on: false)
            self.menuTableListAppend(list: result)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let visibleRows = self.tableView.indexPathsForVisibleRows
        let lastRow = visibleRows?.last?.row
        if(lastRow == nil){
            return
        }
        let index = self.pageCount
        //print(" index \(index) ")
        let indexFrom: Int =  index * Const().PAGE_SIZE
        //print(" indexFrom \(indexFrom) ")
        let indexTo: Int = indexFrom + Const().PAGE_SIZE - 2
        //print(" indexTo \(indexTo) ")
        //print(" lastRow! \(lastRow!) ")
        //if(lastRow! <= indexTo){
        //print(" -M- ")
        //return
        //}
        if lastRow == indexTo {
            
            //print(" -N- ")
            
            self.pageCount += 1
            self.getPageListNext()
        }
        //print(" 0 ")
    }
    
    // MARK: TABLE
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameMenuTableList.count
    }
    
    private func swipeResolved(orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if(orientation == .right) {
            
           
            
            //self.tableView.backgroundColor = UIColor.black
            let rematch = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                           cell.hideSwipe(animated: false, completion: nil)
                
                
                let game: EntityGame = self.gameMenuTableList[indexPath.row]
                let username: String = self.menu!.playerSelf!.username
                let playerOther: EntityPlayer = game.getPlayerOther(username: username)
//                DispatchQueue.main.async {
//                    let screenSize: CGRect = UIScreen.main.bounds
//                    let height = screenSize.height
//                    SelectChallenge().execute(selection: Int.random(in: 0...3), playerSelf: self.menu!.playerSelf!, playerOther: playerOther, BACK: "MENU", height: height)
//                }
                DispatchQueue.main.async {
                    let height: CGFloat = UIScreen.main.bounds.height
                    if(height.isLess(than: 750)){
                        let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeL", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeL") as! Challenge
                        viewController.setPlayerSelf(playerSelf: self.menu!.playerSelf!)
                        viewController.setPlayerOther(playerOther: playerOther)
                        viewController.setSelection(selection: Int.random(in: 0...3))
                        viewController.BACK = "OTHER"
                        //viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        //viewController.modalTransitionStyle = .crossDissolve
                        //self.home!.present(viewController, animated: false , completion: nil)
                        self.navigationController?.pushViewController(viewController, animated: false)
                        return
                    }
                    let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeP") as! Challenge
                    viewController.setPlayerSelf(playerSelf: self.menu!.playerSelf!)
                    viewController.setPlayerOther(playerOther: playerOther)
                    viewController.setSelection(selection: Int.random(in: 0...3))
                    viewController.BACK = "OTHER"
                    //viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                    //viewController.modalTransitionStyle = .crossDissolve
                    //self.home!.present(viewController, animated: false , completion: nil)
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
            rematch.backgroundColor = .purple
            rematch.image = UIImage(named: "challenge")!
            rematch.title = "rematch"
            return [rematch]
        }
        return nil
    }
    
    private func swipProposedInbound(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        if(orientation == .left) {
            let nAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                cell.hideSwipe(animated: false, completion: nil)
                
                self.menu!.setIndicator(on: true)
                let requestPayload: [String: Any] = ["id_game": game.id, "id_self": self.menu!.playerSelf!.id]
                UpdateNack().execute(requestPayload: requestPayload) { (result) in
                    self.gameMenuTableList.remove(at: indexPath.row)
                    self.menu!.setIndicator(on: false)
                }
            }
            nAction.backgroundColor = .red
            nAction.image = UIImage(named: "td_w")!
            nAction.title = "reject"
            return [nAction]
        }
        let ackAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
            cell.hideSwipe(animated: false, completion: nil)
            
            let game: EntityGame = self.gameMenuTableList[indexPath.row]
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
        ackAction.backgroundColor = .green
        ackAction.title = "accept"
        ackAction.image = UIImage(named: "tu_w")!
        return [ackAction]
    }
    
    private func swipProposedOutbound(orientation: SwipeActionsOrientation, game: EntityGame) -> [SwipeAction]? {
        if(orientation == .left) {
            let rescind = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                cell.hideSwipe(animated: false, completion: nil)
                
                self.menu!.setIndicator(on: true)
                let game = self.gameMenuTableList[indexPath.row]
                let requestPayload: [String: Any] = ["id_game": game.id, "id_self": self.menu!.playerSelf!.id]
                UpdateRescind().execute(requestPayload: requestPayload) { (result) in
                    self.gameMenuTableList.remove(at: indexPath.row)
                    self.menu!.setIndicator(on: false)
                }
            }
            rescind.backgroundColor = .red
            rescind.image = UIImage(named: "close_w")!
            rescind.title = "rescind"
            return [rescind]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let username: String = self.menu!.playerSelf!.username
        let game = self.gameMenuTableList[indexPath.row]
        let inbound: Bool = game.getInboundInvitation(username: username)
        
        if(game.status == "ONGOING"){
            return nil
        }
        if(game.status == "RESOLVED"){
            return self.swipeResolved(orientation: orientation)
        }
        if(inbound){
            return self.swipProposedInbound(orientation: orientation, game: game)
        }
        return self.swipProposedOutbound(orientation: orientation, game: game)
    }
    
    private func getCellActive(cell: MenuCell) -> MenuCell {
        cell.soLaLa.backgroundColor = UIColor.white
        cell.usernameLabel.textColor = UIColor.black
        cell.timeIndicatorLabel.textColor = UIColor.black
        cell.actionImageView.isHidden = false
        cell.dispImageView.isHidden = true
        cell.dispAdjacentLabel.isHidden = true
        cell.oddsIndicatorLabel.isHidden = true
        cell.oddsValueLabel.isHidden = true
        cell.dispImageView.isHidden = true
        cell.dispValueLabel.isHidden = true
        return cell
    }
    
    //let val: String = player.getLabelTextDisp()
    private func getCellHisto(cell: MenuCell, disp: String) -> MenuCell {
        cell.soLaLa.backgroundColor = UIColor.black
        cell.usernameLabel.textColor = UIColor.white
        cell.timeIndicatorLabel.textColor = UIColor.lightGray
        cell.actionImageView.isHidden = true
        cell.dispImageView.isHidden = false
        cell.dispAdjacentLabel.isHidden = false
        cell.dispAdjacentLabel.textColor = UIColor.lightGray
        cell.oddsIndicatorLabel.isHidden = false
        cell.oddsIndicatorLabel.textColor = UIColor.lightGray
        cell.oddsValueLabel.isHidden = false
        cell.oddsValueLabel.textColor = UIColor.white
        cell.dispValueLabel.isHidden = false
        cell.dispValueLabel.textColor = UIColor.white
        if(disp == "0"){
            cell.dispValueLabel.isHidden = true
            cell.dispAdjacentLabel.isHidden = true
            cell.dispImageView.isHidden = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index: Int = indexPath.row
        let game: EntityGame = self.gameMenuTableList[index]
        let username: String = self.menu!.playerSelf!.username
        let usernameOther: String = game.getLabelTextUsernameOpponent(username: username)
        let avatarImageOther: UIImage = game.getImageAvatarOpponent(username: username)
        let date: String = game.getLabelTextDate()
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.delegate = self
        cell.timeIndicatorLabel.text = date
        cell.usernameLabel.text = usernameOther
        cell.avatarImageView.image = avatarImageOther
        if(game.status == "RESOLVED"){
            let disp: String = game.getLabelTextDisp(username: username)!
            cell = self.getCellHisto(cell: cell, disp: disp)
            cell.dispImageView.image = game.getImageDisp(username: username)
            cell.oddsValueLabel.text = game.getOdds(username: username)
            cell.dispValueLabel.text = disp
            return cell
        }
        cell = self.getCellActive(cell: cell)
        let inbound: Bool = game.getTurn(username: username)
        if(game.status == "ONGOING"){
            if(inbound){
                let image: UIImage = UIImage(named: "turn.on")!
                cell.actionImageView.image = image
                cell.labelAction.text = "action!"
                return cell
            }
            let image: UIImage = UIImage(named: "turn.off")!
            cell.actionImageView.image = image
            cell.labelAction.text = "pending"
            return cell
        }
        if(game.status == "PROPOSED"){
            if(inbound){
                let image: UIImage = UIImage(named: "inbound")!
                cell.actionImageView.image = image
                cell.labelAction.text = "challenge"
                return cell
            }
        }
        let image: UIImage = UIImage(named: "outbound")!
        cell.actionImageView.image = image
        cell.labelAction.text = "outbound"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MenuCell
        let game = self.gameMenuTableList[indexPath.row]
        if(game.status == "RESOLVED"){
            DispatchQueue.main.async {
                
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
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
                    viewController.setOther(player: playerOther)
                    viewController.setSelf(player: self.menu!.playerSelf!)
                    viewController.setGame(game: game)
                    self.navigationController?.pushViewController(viewController, animated: false)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
                viewController.setOther(player: playerOther)
                viewController.setSelf(player: self.menu!.playerSelf!)
                viewController.setGame(game: game)
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
    
    func menuTableListAppend(list: [EntityGame]) {
        let count0 = self.gameMenuTableList.count
        for game: EntityGame in list {
            if(self.gameMenuTableList.contains(game)){
                continue
            }
            self.gameMenuTableList.append(game)
        }
        let count1 = gameMenuTableList.count
        if(count0 != count1){
            self.menu!.setIndicator(on: false)
        }
    }
}
