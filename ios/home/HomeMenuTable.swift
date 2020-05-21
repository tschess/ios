//
//  HomeMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class HomeMenuTable: UITableViewController, SwipeTableViewCellDelegate {
    
    var home: Home?
    
    let REQUEST_PAGE_SIZE: Int
    var requestPageIndex: Int
    var leaderboardList: [EntityPlayer]
    
    required init?(coder aDecoder: NSCoder) {
        self.REQUEST_PAGE_SIZE = 9
        self.requestPageIndex = 0
        self.leaderboardList = [EntityPlayer]()
        super.init(coder: aDecoder)
    }
    
    //var eloLabel: UILabel?
    //var rankLabel: UILabel?
    //var dispLabel: UILabel?
    //var dispImageView: UIImageView?
    //var activityIndicator: UIActivityIndicatorView?
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if(orientation == .left) {
            let modifyAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let cell = tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                cell.hideSwipe(animated: false, completion: nil)
                
                //self.activityIndicator!.isHidden = false
                //self.activityIndicator!.startAnimating()
                self.home!.setIndicator(on: true)
                
                let playerOther = self.leaderboardList[indexPath.row]
                
                RequestRecent().execute(id: playerOther.id) { (result) in
                    //DispatchQueue.main.async() {
                        //self.activityIndicator!.stopAnimating()
                        //self.activityIndicator!.isHidden = true
                    //}
                    self.home!.setIndicator(on: false)
                    
                    if(result["fail"] != nil) {
                        DispatchQueue.main.async {
                            let storyboard: UIStoryboard = UIStoryboard(name: "Noop", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "Noop") as! Noop
                            self.present(viewController, animated: true, completion: nil)
                        }
                        return
                    }
                    let game: EntityGame = ParseGame().execute(json: result)
                    DispatchQueue.main.async() {
                        SelectSnapshot().snapshot(playerSelf: self.home!.playerSelf!, game: game, presentor: self)
                    }
                }
            }
            modifyAction.image = UIImage(named: "eyeye")!
            modifyAction.backgroundColor = .orange
            modifyAction.title = "recent"
            return [modifyAction]
        }
        let modifyAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            let cell = tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
            cell.hideSwipe(animated: false, completion: nil)
            
            let playerOther = self.leaderboardList[indexPath.row]
            //DispatchQueue.main.async {
                //let screenSize: CGRect = UIScreen.main.bounds
                //let height = screenSize.height
                //SelectChallenge().execute(selection: , playerSelf: , playerOther: playerOther, BACK: , height: height)
            
                DispatchQueue.main.async {
                    let height: CGFloat = UIScreen.main.bounds.height
                    if(height.isLess(than: 750)){
                        let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeL", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeL") as! Challenge
                        viewController.setPlayerSelf(playerSelf: self.home!.playerSelf!)
                        viewController.setPlayerOther(playerOther: playerOther)
                        viewController.setSelection(selection: Int.random(in: 0...3))
                        viewController.BACK = "HOME"
                        viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        //viewController.modalTransitionStyle = .crossDissolve
                        self.home!.present(viewController, animated: false , completion: nil)
                        return
                    }
                    let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeP") as! Challenge
                    viewController.setPlayerSelf(playerSelf: self.home!.playerSelf!)
                    viewController.setPlayerOther(playerOther: playerOther)
                    viewController.setSelection(selection: Int.random(in: 0...3))
                    viewController.BACK = "HOME"
                    viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                    //viewController.modalTransitionStyle = .crossDissolve
                    self.home!.present(viewController, animated: false , completion: nil)
                }
            
            
            //}
            
        }
        modifyAction.image = UIImage(named: "challenge")!
        modifyAction.title = "challenge"
        modifyAction.backgroundColor = .purple
        return [modifyAction]
    }
    
    func getOther(index: Int) -> EntityPlayer {
        return self.leaderboardList[index]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let discoverSelectionDictionary: [String: Any] = ["home_menu_selection": indexPath.row]
        
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "HomeMenuSelection"),
            object: nil,
            userInfo: discoverSelectionDictionary)
    }
    
    override func viewDidLoad() {
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        
        self.requestPageIndex = 0
        let requestPayload: [String: Any] = ["id_player": self.home!.playerSelf!.id,
                                             "size": REQUEST_PAGE_SIZE]
        RequestRefresh().execute(requestPayload: requestPayload) { (response) in
            if(response == nil){
                return
            }
            let playerSelf: EntityPlayer = response!.last!
            
            self.home!.playerSelf = playerSelf
            let list: [EntityPlayer] = response!.dropLast()
            
            DispatchQueue.main.async() {
                
                self.home!.renderHeader()
                
                self.leaderboardList = [EntityPlayer]()
                self.tableView.reloadData()
                self.appendToLeaderboardTableList(additionalCellList: list)
                refreshControl.endRefreshing()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMenuCell", for: indexPath) as! HomeMenuCell
        cell.delegate = self
        cell.avatarImageView.image = player.getImageAvatar()
        cell.rankLabel.text = player.getLabelTextRank()
        cell.usernameLabel.text = player.username
        cell.dateLabel.text = player.getLabelTextDate()
        cell.dispLabel.text = player.getLabelTextDisp()
        cell.dispImage.image = player.getImageDisp()!
        cell.dispImage.tintColor = player.tintColor
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let visibleRows = self.tableView.indexPathsForVisibleRows
        let lastRow = visibleRows?.last?.row
        if(lastRow == nil){
            return
        }
        let index = self.requestPageIndex
        let size = self.REQUEST_PAGE_SIZE
        let indexFrom: Int =  index * size
        let indexTo: Int = indexFrom + REQUEST_PAGE_SIZE - 2
        if lastRow == indexTo {
            self.requestPageIndex += 1
            self.fetchGameList()
        }
    }
    
    func fetchGameList() {
        self.home!.setIndicator(on: true)
        
        let requestPayload = ["index": self.requestPageIndex,
                              "size": REQUEST_PAGE_SIZE] as [String: Int]
        RequestPage().execute(requestPayload: requestPayload) { (result) in
            self.home!.setIndicator(on: false)
            if(result == nil){
                return
            }
            self.appendToLeaderboardTableList(additionalCellList: result!)
        }
    }
    
    func appendToLeaderboardTableList(additionalCellList: [EntityPlayer]) {
        for game in additionalCellList {
            self.leaderboardList.append(game)
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
}
