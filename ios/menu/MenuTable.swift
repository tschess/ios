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
    
    var containerView: UIView?
    
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
        
        //self.containerView!.addSubview(self.enter)
       
        //if(self.containerView!.subviews.contains(self.enter)){
            //self.enter.isHidden = true
        //}
    }
    
    var activityIndicator: UIActivityIndicatorView?
    
    public func setIndicator(indicator: UIActivityIndicatorView){
        self.activityIndicator = indicator
    }
    
    public func setContainerView(container: UIView){
        self.containerView = container
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameMenuTableList.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let game = gameMenuTableList[indexPath.row]
        if(game.status == "RESOLVED"){
            //print(" - Tschess - ")
            DispatchQueue.main.async {
                let skin: String = SelectSnapshot().getSkinGame(username: self.playerSelf!.username, game: game)
                SelectSnapshot().snapshot(skin: skin, playerSelf: self.playerSelf!, game: game, presentor: self)
            }
            return nil
        }
        if(game.status == "ONGOING"){
            //print(" - Tschess - ")
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                let playerOther: EntityPlayer = game.getPlayerOther(username: self.playerSelf!.username)
                SelectTschess().tschess(playerSelf: self.playerSelf!, playerOther: playerOther, game: game, height: height)
            }
            return nil
        }
        if(game.getInboundInvitation(username: self.playerSelf!.username)){
            
            guard orientation == .right else {
                let nAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                    //print("nACK")
                    self.activityIndicator!.isHidden = false
                    self.activityIndicator!.startAnimating()
                    let requestPayload: [String: Any] = ["id_game": game.id, "id_player": self.playerSelf!.id]
                    
                    UpdateNack().execute(requestPayload: requestPayload) { (player) in
                        //print("player: \(player)")
                        //ERROR...
                        self.setPlayerSelf(playerSelf: player!)
                        
                        DispatchQueue.main.async {
                            self.activityIndicator!.stopAnimating()
                            self.activityIndicator!.isHidden = true
                            self.gameMenuTableList.remove(at: indexPath.row)
                            self.tableView!.reloadData()
                        }
                    }
                }
                nAction.backgroundColor = .red
                nAction.image = UIImage(named: "td_w")!
                return [nAction]
            }
            let ackAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let game = self.gameMenuTableList[indexPath.row]
                let playerOther: EntityPlayer = game.getPlayerOther(username: self.playerSelf!.username)
                DispatchQueue.main.async {
                    let screenSize: CGRect = UIScreen.main.bounds
                    let height = screenSize.height
                    SelectAck().execute(selection: Int.random(in: 0...3), playerSelf: self.playerSelf!, playerOther: playerOther, game: game, height: height)
                }
            }
            ackAction.backgroundColor = .green
            ackAction.image = UIImage(named: "tu_w")!
            return [ackAction]
            
        }
        guard orientation == .left else {
            return nil
        }
        
        let rescind = SwipeAction(style: .default, title: nil) { action, indexPath in
            //print("RESCIND")
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            let game = self.gameMenuTableList[indexPath.row]
            let requestPayload: [String: Any] = ["id_game": game.id, "id_player": self.playerSelf!.id]
            
            UpdateRescind().execute(requestPayload: requestPayload) { (result) in
                //print("result: \(result)")
                DispatchQueue.main.async {
                    self.activityIndicator!.stopAnimating()
                    self.activityIndicator!.isHidden = true
                    self.gameMenuTableList.remove(at: indexPath.row)
                    self.tableView!.reloadData()
                }
            }
        }
        rescind.backgroundColor = .red
        rescind.image = UIImage(named: "close_w")!
        return [rescind]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = gameMenuTableList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.delegate = self
        cell.usernameLabel.text = game.getLabelTextUsernameOpponent(username: self.playerSelf!.username)
        cell.avatarImageView.image = game.getImageAvatarOpponent(username: self.playerSelf!.username)
        
        if(game.status == "ONGOING"){
            cell.timeIndicatorLabel.text = game.getLabelTextDate(update: true)
            if(game.getInboundGame(username: self.playerSelf!.username)){
                
                let image = UIImage(named: "turn.on")!
                cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
                cell.actionImageView.tintColor = .black
                return cell
            }
            
            let image = UIImage(named: "turn.off")!
            cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
            cell.actionImageView.tintColor = .black
            return cell
        }
        if(game.status == "PROPOSED"){
            cell.timeIndicatorLabel.text = game.getLabelTextDate(update: false)
            if(game.getInboundInvitation(username: self.playerSelf!.username)){
                
                cell.actionImageView.tintColor = .black
                let image = UIImage(named: "inbound")!
                cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
                return cell
            }
            
            cell.actionImageView.tintColor = .black
            let image = UIImage(named: "outbound")!
            cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        if(game.status == "RESOLVED"){
            cell.timeIndicatorLabel.text = game.getLabelTextDate(update: true)
            cell.soLaLa.backgroundColor = UIColor.black
            cell.actionImageView.isHidden = true
            cell.usernameLabel.textColor = UIColor.lightGray
            cell.timeIndicatorLabel.isHidden = false
            cell.timeIndicatorLabel.textColor = UIColor.darkGray
            cell.oddsIndicatorLabel.isHidden = false
            cell.oddsIndicatorLabel.textColor = UIColor.darkGray
            
            cell.oddsValueLabel.isHidden = false
            cell.oddsValueLabel.textColor = UIColor.lightGray
            cell.oddsValueLabel.text = game.getOdds(username: self.playerSelf!.username)
            
            cell.dispAdjacentLabel.isHidden = false
            cell.dispAdjacentLabel.textColor = UIColor.darkGray
            
            cell.dispImageView.isHidden = false
            cell.dispImageView.image = game.getImageDisp(username: self.playerSelf!.username)
            cell.dispImageView.tintColor = game.getTint(username: self.playerSelf!.username)
            
            cell.dispValueLabel.isHidden = false
            cell.dispValueLabel.textColor = UIColor.lightGray
            cell.dispValueLabel.text = game.getLabelTextDisp(username: self.playerSelf!.username)
            //            if(game.getInboundInvitation(username: self.playerSelf!.username)){
            //
            //                cell.actionImageView.tintColor = .black
            //                let image = UIImage(named: "inbound")!
            //                cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
            //                return cell
            //            }
            //
            //            cell.actionImageView.tintColor = .black
            //            let image = UIImage(named: "outbound")!
            //            cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MenuCell
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
        //let gameTableMenuItem = gameMenuTableList[indexPath.row]
        let closeAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        })
        closeAction.image = UIImage(named: "td_w")!
        closeAction.backgroundColor = .red
        //return UISwipeActionsConfiguration(actions: [closeAction])
        let config = UISwipeActionsConfiguration(actions: [closeAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let game = gameMenuTableList[indexPath.row]
        if(game.getInboundInvitation(username: self.playerSelf!.username)){
            let modifyAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view: UIView, success: (Bool) -> Void) in
                success(true)
            })
            modifyAction.image = UIImage(named: "tu_w")!
            modifyAction.backgroundColor = .green
            //return UISwipeActionsConfiguration(actions: [modifyAction])
            let config = UISwipeActionsConfiguration(actions: [modifyAction])
            config.performsFirstActionWithFullSwipe = false
            return config
        }
        return nil
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//if(self.gameMenuTableList.count == 0){
//    DispatchQueue.main.async {
//        self.containerView!.addSubview(self.enter)
//    }
//}
//    }
    
    
    
    let enter: Enter = Enter.instanceFromNib()
    
    func appendToTableList(additionalCellList: [EntityGame]) {
        let currentCount = self.gameMenuTableList.count
        
        print("self.gameMenuTableList.count \(self.gameMenuTableList.count)")
        
        //if(self.containerView!.subviews.contains(self.enter)){
                   //self.enter.isHidden = true
               //}
       
        
        for game in additionalCellList {
            if(!self.gameMenuTableList.contains(game)){
                self.gameMenuTableList.append(game)
            }
        }
        if(currentCount != self.gameMenuTableList.count){
            DispatchQueue.main.async {
                
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
                self.tableView!.reloadData()
            }
        }
        
        print("self.gameMenuTableList.count \(self.gameMenuTableList.count)")
        if(self.gameMenuTableList.count > 0){
            DispatchQueue.main.async {
                if(self.containerView!.subviews.contains(self.enter)){
                    self.enter.removeFromSuperview()
                }
            }
        }
    }
    
    func fetchMenuTableList() {
        
        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            
        }
        let REQUEST_PAGE_SIZE: Int = 9
        
        let requestPayload = [
            "id": self.playerSelf!.id,
            "index": self.pageFromWhichContentLoads, //TODO ~ remove this...
            "size": REQUEST_PAGE_SIZE,
            "self": true
            ] as [String: Any]
        
        RequestActual().execute(requestPayload: requestPayload) { (result) in
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            print("result \(result)")
            
            if(result == nil){
                DispatchQueue.main.async {
                    self.containerView!.addSubview(self.enter)
                }
                return
            }
            self.appendToTableList(additionalCellList: result!)
        }
        DispatchQueue.main.async() {
            self.activityIndicator!.stopAnimating()
            self.activityIndicator!.isHidden = true
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
