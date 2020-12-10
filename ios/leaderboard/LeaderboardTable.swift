//
//  LeaderboardTable.swift
//  ios
//
//  Created by S. Matthew English on 12/3/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class LeaderboardTable: UITableViewController, SwipeTableViewCellDelegate {
    
    var home: Leaderboard?
    
    //let REQUEST_PAGE_SIZE: Int
    var requestPageIndex: Int
    var leaderboardList: [EntityPlayer]
    
    required init?(coder aDecoder: NSCoder) {
        //self.REQUEST_PAGE_SIZE = 9
        self.requestPageIndex = 0
        self.leaderboardList = [EntityPlayer]()
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if(orientation == .left) {
            return nil
            //let modifyAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                //let cell = tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                //cell.hideSwipe(animated: false, completion: nil)
                
                //self.home!.setIndicator(on: true)
                
                //let playerOther = self.leaderboardList[indexPath.row]
                
                //RequestRecent().execute(id: playerOther.id) { (result) in
                    //self.home!.setIndicator(on: false)
                    
                    //if(result["fail"] != nil) {
                        //DispatchQueue.main.async {
                            //let storyboard: UIStoryboard = UIStoryboard(name: "PopNoop", bundle: nil)
                            //let viewController = storyboard.instantiateViewController(withIdentifier: "PopNoop") as! PopDismiss
                            //self.present(viewController, animated: true, completion: nil)
                        //}
                        //return
                    //}
                    //let game: EntityGame = ParseGame().execute(json: result)
                    //DispatchQueue.main.async() {
                        //SelectSnapshot().snapshot(playerSelf: self.home!.playerSelf!, game: game, presentor: self)
                    //}
                //}
            //}
            //modifyAction.image = UIImage(named: "eyeye")!
            //modifyAction.image = UIImage(named: "eye_g")!
            //modifyAction.backgroundColor = .orange
            //modifyAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            
            //modifyAction.title = "recent"
            //modifyAction.textColor = UIColor.lightGray
            //modifyAction.textColor = UIColor.white
            //return [modifyAction]
        }
        let modifyAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            let cell = tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
            cell.hideSwipe(animated: false, completion: nil)
            
            //let opponent: EntityPlayer =
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Other", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Other") as! Other
            viewController.player = self.home!.playerSelf!
            viewController.opponent = self.leaderboardList[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: false)

        }
        //modifyAction.image = UIImage(named: "challenge_g")!
        modifyAction.image = UIImage(named: "eyeye")!
        modifyAction.title = "Games"
        modifyAction.textColor = UIColor.white
        //modifyAction.backgroundColor = .purple
        modifyAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
        
        return [modifyAction]
    }
    
    func getOther(index: Int) -> EntityPlayer {
        return self.leaderboardList[index]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let discoverSelectionDictionary: [String: Any] = ["leaderboard_selection": indexPath.row]
        
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "LeaderboardSelection"),
            object: nil,
            userInfo: discoverSelectionDictionary)
    }
    
    override func viewDidLoad() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.white
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        self.requestPageIndex = 0
        //let requestPayload: [String: Any] = ["id_player": self.home!.playerSelf!.id,
                                             //"size": Const().PAGE_SIZE]
        let requestPayload = ["index": self.requestPageIndex,
                              "size": Const().PAGE_SIZE] as [String: Int]
        RequestPage().execute(requestPayload: requestPayload) { (response) in
            if(response == nil){
                return
            }
            let playerSelf: EntityPlayer = response!.last!
            
            self.home!.playerSelf = playerSelf
            let list: [EntityPlayer] = response!.dropLast()
            
            DispatchQueue.main.async() {
                
                //self.home!.renderHeader()
                
                //self.leaderboardList = [EntityPlayer]()
                //self.tableView.reloadData()
                //self.appendToLeaderboardTableList(additionalCellList: list)
                
                
                refreshControl.endRefreshing()
                self.leaderboardList = [EntityPlayer]()
                for game in list {
                    self.leaderboardList.append(game)
                }
                self.home!.header!.setIndicator(on: false, tableView: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = self.leaderboardList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell
        cell.delegate = self
        cell.avatarImageView.image = player.getImageAvatar()
        
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2
        cell.avatarImageView.clipsToBounds = true
        
        
        cell.rankLabel.text = player.getLabelTextRank()
        //cell.usernameLabel.text = player.username
        cell.dateLabel.text = player.username
        
        let val: String = player.getLabelTextDisp()
        if(val == "0"){
            //cell.dispLabel.isHidden = true
            cell.dispImage.isHidden = true
            //cell.dispLabelAlign.isHidden = true
        } else {
            //cell.dispLabel.isHidden = false
            cell.dispImage.isHidden = false
            //cell.dispLabelAlign.isHidden = false
            //cell.dispLabel.text = player.getLabelTextDisp()
            
            cell.labelRating.text = player.getLabelTextElo()
            
            cell.dispImage.image = player.getImageDisp()!
            cell.dispImage.tintColor = player.tintColor
        }
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        cell.buttonSideSlide.addGestureRecognizer(pictureTap)
        cell.buttonSideSlide.isUserInteractionEnabled = true
        
        
        
        return cell
    }
    
    var swipeVisible: Bool = false
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        guard let cell = sender.view?.superview?.superview as? LeaderboardCell else {
            return
        }
        if(!self.swipeVisible){
            cell.showSwipe(orientation: .right, animated: true)
            self.swipeVisible = true
            return
        }
        cell.hideSwipe(animated: true, completion: nil)
        self.swipeVisible = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let visibleRows = self.tableView.indexPathsForVisibleRows
        let lastRow = visibleRows?.last?.row
        if(lastRow == nil){
            return
        }
        let index = self.requestPageIndex
        let size = Const().PAGE_SIZE
        let indexFrom: Int =  index * size
        let indexTo: Int = indexFrom + Const().PAGE_SIZE - 2
        if lastRow == indexTo {
            self.requestPageIndex += 1
            self.fetchGameList()
        }
    }
    
    func fetchGameList() {
        self.home!.header!.setIndicator(on: true)
        
        let requestPayload = ["index": self.requestPageIndex,
                              "size": Const().PAGE_SIZE] as [String: Int]
        RequestPage().execute(requestPayload: requestPayload) { (result) in
            if(result == nil){
                self.home!.header!.setIndicator(on: false, tableView: self)
                return
            }
            for game in result! {
                self.leaderboardList.append(game)
            }
            
            self.home!.header!.setIndicator(on: false, tableView: self)
            
            //self.appendToLeaderboardTableList(additionalCellList: result!)
        }
    }
    
//    func appendToLeaderboardTableList(additionalCellList: [EntityPlayer]) {
//        for game in additionalCellList {
//            self.leaderboardList.append(game)
//        }
//        DispatchQueue.main.async() {
//            self.tableView.reloadData()
//        }
//    }
}
