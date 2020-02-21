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
            //print(" - Tschess - ")
            
            SelectorTschess().tschess(
                playerSelf: self.playerSelf!,
                playerOther: game.getPlayerOther(username: self.playerSelf!.username),
                game: game)
            return nil
        }
        if(game.getInboundInvitation(username: self.playerSelf!.username)){
            
            guard orientation == .right else {
                let nAction = SwipeAction(style: .default, title: "nACK") { action, indexPath in
                    print("nACK")
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
            let ackAction = SwipeAction(style: .default, title: "ACK") { action, indexPath in
                
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
        
        let rescind = SwipeAction(style: .default, title: "RESCIND") { action, indexPath in
            print("RESCIND")
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
        rescind.backgroundColor = .orange
        rescind.image = UIImage(named: "close_w")!
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
        //let gameTableMenuItem = gameMenuTableList[indexPath.row]
        let closeAction = UIContextualAction(style: .normal, title:  "nACK", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, marked as Closed")
            success(true)
        })
        closeAction.image = UIImage(named: "td_w")!
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
            modifyAction.image = UIImage(named: "tu_w")!
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
            DispatchQueue.main.async {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
                self.tableView!.reloadData()
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

//private func renderShrug(){  // thiis can exist in practice...
//    DispatchQueue.main.async() {
//        let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
//        self.label = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5, width: UIScreen.main.bounds.width, height: 40))
//        self.label!.center = frameSize
//        self.label!.textAlignment = .center
//        self.label!.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
//        self.label!.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = NSLayoutConstraint(item: self.label!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
//        let verticalConstraint = NSLayoutConstraint(item: self.label!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
//        self.label!.text = "¯\\_( ͡° ͜ʖ ͡°)_/¯"
//        self.view.addSubview(self.label!)
//        self.view.addConstraints([horizontalConstraint, verticalConstraint])
//    }
//}
