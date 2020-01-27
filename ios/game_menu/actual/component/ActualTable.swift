//
//  GameTableViewController.swift
//  ios
//
//  Created by Matthew on 7/27/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class ActualTable: UITableViewController, SwipeTableViewCellDelegate {
    
    var gameMenuTableList: [Game] = [Game]()
    var player: Player?
    var label: UILabel?
    
    public var pageFromWhichContentLoads: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.pageFromWhichContentLoads = 0
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.tableFooterView = UIView()
        
        self.fetchMenuTableList(id: self.player!.getId())
    }
    
    func getGameMenuTableList() -> [Game] {
        return gameMenuTableList
    }
    
    public func setPlayer(player: Player) {
        self.player = player
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
    
    //    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
    //        var options = SwipeOptions()
    //        return options
    //    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        print("orientation: \(orientation)")
        let actualMenuItem = gameMenuTableList[indexPath.row]
        
        if(actualMenuItem.getGameStatus() == "ONGOING"){
            
            let gameModel = gameMenuTableList[indexPath.row]
            
            let tschessElementMatrix = [[TschessElement?]](repeating: [TschessElement?](repeating: nil, count: 8), count: 8)
            let gamestate = Gamestate(
                gameModel: gameModel,
                tschessElementMatrix: tschessElementMatrix
            )
            gamestate.setPlayer(player: self.player!)
            PollingAgent().execute(id: gameModel.getIdentifier(), gamestate: gamestate) { (result, error) in
                if(error != nil || result == nil){
                    return
                }
                StoryboardSelector().chess(gameModel: gameModel, player: gamestate.getPlayer(), gamestate: result!)
            }
            return nil
        }
        
        if(!actualMenuItem.inbound!){
            
            guard orientation == .right else { return nil}
            
            let rescind = SwipeAction(style: .default, title: "RESCIND") { action, indexPath in
                print("RESCIND")
                GameDeleteTask().execute(id: actualMenuItem.getIdentifier())
                self.gameMenuTableList.remove(at: indexPath.row)
                self.tableView!.reloadData()
            }
            rescind.backgroundColor = .orange
            if #available(iOS 13.0, *) {
                rescind.image = UIImage(systemName: "xmark.rectangle.fill")!
            }
            return [rescind]
        }
        guard orientation == .right else {
            let nAction = SwipeAction(style: .default, title: "nACK") { action, indexPath in
                print("nACK")
                GameDeleteTask().execute(id: actualMenuItem.getIdentifier())
                self.gameMenuTableList.remove(at: indexPath.row)
                self.tableView!.reloadData()
            }
            nAction.backgroundColor = .red
            if #available(iOS 13.0, *) {
                nAction.image = UIImage(systemName: "hand.thumbsdown.fill")!
            }
            return [nAction]
        }
        let ackAction = SwipeAction(style: .default, title: "ACK") { action, indexPath in
            print("ACK")
            let storyboard: UIStoryboard = UIStoryboard(name: "Ack", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Ack") as! Ack
            viewController.setPlayer(player: self.player!)
            viewController.setOpponent(opponent: actualMenuItem.getOpponent()) // <-- REDUNDANT
            viewController.setGameModel(gameModel: actualMenuItem)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
        ackAction.backgroundColor = .green
        if #available(iOS 13.0, *) {
            ackAction.image = UIImage(systemName: "hand.thumbsup.fill")!
        }
        return [ackAction]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActualCell", for: indexPath) as! ActualCell
        
        cell.delegate = self
        
        
        let gameTableMenuItem = gameMenuTableList[indexPath.row]
        
        cell.usernameLabel.text = gameTableMenuItem.getUsernameOpponent()
        //cell.eloLabel.text = gameTableMenuItem.getOpponentElo()
        let dataDecoded: Data = Data(base64Encoded: gameTableMenuItem.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        cell.avatarImageView.image = decodedimage
        
        let status = gameTableMenuItem.getGameStatus()
        
        if(status == "ONGOING"){
            if(gameTableMenuItem.usernameTurn == self.player!.getUsername()){
                if #available(iOS 13.0, *) {
                    let image = UIImage(systemName: "gamecontroller.fill")!
                    cell.actionImageView.image = image.withRenderingMode(.alwaysTemplate)
                    //cell.actionImageView.tintColor = .magenta //Colour().getRed()
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
        // 'PROPOSED'...
        if(gameTableMenuItem.inbound!){
            if #available(iOS 13.0, *) {
                //print("aHaHaHa")
                //cell.actionImageView.tintColor = Colour().getRed()
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //var discoverSelectionDictionary: [String: Any] = ["actual_selection": indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath) as! ActualCell
        cell.showSwipe(orientation: .right, animated: true)
        
        //discoverSelectionDictionary["action"] = cell.actionLabel!.text!
        
        //        NotificationCenter.default.post(
        //            name: NSNotification.Name(rawValue: "ActualSelection"),
        //            object: nil,
        //            userInfo: discoverSelectionDictionary)
    }
    
    override open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(tableView.selectionCount < 13 && self.pageFromWhichContentLoads > 0){
            return
        }
        if indexPath.row == self.gameMenuTableList.count - 1 {
            self.pageFromWhichContentLoads += 1
            self.fetchMenuTableList(id: self.player!.getId())
        }
    }
    
    func appendToTableList(additionalCellList: [Game]) {
        let currentCount = self.gameMenuTableList.count
        for game in additionalCellList {
            if(!self.gameMenuTableList.contains(game)){
                self.gameMenuTableList.append(game)
            }
        }
        if(currentCount != self.gameMenuTableList.count){
            self.gameMenuTableList = self.gameMenuTableList.sorted(by: { $0.inbound! && !$1.inbound! })
            self.gameMenuTableList = self.gameMenuTableList.sorted(by: { $0.gameStatus < $1.gameStatus })
            DispatchQueue.main.async() {
                //self.activityIndicator!.stopAnimating()
                //self.activityIndicator!.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchMenuTableList(id: String) {
        PageList().execute(player: self.player!, page: self.pageFromWhichContentLoads){ (result) in
            if(result == nil){
                return
            }
            let resultList: [Game] = result!
            if(resultList.count == 0) {
                self.renderShrug()
                return
            }
            if(self.label != nil) {
                self.label!.removeFromSuperview()
            }
            self.appendToTableList(additionalCellList: resultList)
        }
    }
    
    // beecause of quick play yoou'll never see this...
    private func renderShrug(){
        DispatchQueue.main.async() {
            //self.activityIndicator!.stopAnimating()
            //self.activityIndicator!.isHidden = true
            let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
            self.label = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5, width: UIScreen.main.bounds.width, height: 40))
            self.label!.center = frameSize
            self.label!.textAlignment = .center
            self.label!.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
            self.label!.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = NSLayoutConstraint(item: self.label!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: self.label!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            self.label!.text = "¯\\_( ͡° ͜ʖ ͡°)_/¯"
            self.view.addSubview(self.label!)
            self.view.addConstraints([horizontalConstraint, verticalConstraint])
        }
    }
    
    
    //
    //    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
    ////        let more = UITableViewRowAction(style: .normal, title: "nACK") { action, index in
    ////            print("more button tapped")
    ////        }
    ////        more.backgroundColor = UIColor(red: 255/255.0, green: 211/255.0, blue: 211/255.0, alpha: 1)
    //
    //        let share = UITableViewRowAction(style: .normal, title: "ACK") { action, index in
    //            print("share button tapped")
    //        }
    //        share.backgroundColor = UIColor(red: 211/255.0, green: 255/255.0, blue: 211/255.0, alpha: 1)
    //
    //        return [share]
    //    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let gameTableMenuItem = gameMenuTableList[indexPath.row]
        if(!gameTableMenuItem.inbound!){ //rescind
            let modifyAction = UIContextualAction(style: .normal, title:  "CANCEL", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                print("Update action ...")
                success(true)
            })
            if #available(iOS 13.0, *) { //xmark
                modifyAction.image = UIImage(systemName: "xmark.rectangle.fill")!
            }
            modifyAction.backgroundColor = .black
            return UISwipeActionsConfiguration(actions: [modifyAction])
        }
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
        let gameTableMenuItem = gameMenuTableList[indexPath.row]
        if(!gameTableMenuItem.inbound!){
            return nil
        }
        let modifyAction = UIContextualAction(style: .normal, title:  "ACK", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
        })
        if #available(iOS 13.0, *) { //xmark
            modifyAction.image = UIImage(systemName: "hand.thumbsup.fill")!
        }
        modifyAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [modifyAction])
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
