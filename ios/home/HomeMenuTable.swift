//
//  HomeMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class HomeMenuTable: UITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let playerOther = self.leaderboardList[indexPath.row]
        
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Other", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Other") as! Other
            viewController.setPlayerSelf(playerSelf: self.player!)
            viewController.setPlayerOther(playerOther: playerOther)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    let REQUEST_PAGE_SIZE: Int
    var requestPageIndex: Int
    var leaderboardList: [EntityPlayer]
    
    required init?(coder aDecoder: NSCoder) {
        self.REQUEST_PAGE_SIZE = 9
        self.requestPageIndex = 0
        self.leaderboardList = [EntityPlayer]()
        super.init(coder: aDecoder)
    }
    
    var eloLabel: UILabel?
    var rankLabel: UILabel?
    var dispLabel: UILabel?
    var dispImageView: UIImageView?
    var activityIndicator: UIActivityIndicatorView?
    
    public func setHeaderView(
        eloLabel: UILabel,
        rankLabel: UILabel,
        dispLabel: UILabel,
        dispImageView: UIImageView,
        activityIndicator: UIActivityIndicatorView) {
        self.eloLabel = eloLabel
        self.rankLabel = rankLabel
        self.dispLabel = dispLabel
        self.dispImageView = dispImageView
        self.activityIndicator = activityIndicator
    }
    
    public func renderHeader() {
        self.eloLabel!.text = self.player!.getLabelTextElo()
        self.rankLabel!.text = self.player!.getLabelTextRank()
        self.dispLabel!.text = self.player!.getLabelTextDisp()
        self.dispImageView!.image = self.player!.getImageDisp()!
        self.dispImageView!.tintColor = self.player!.tintColor
    }
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    override func viewDidLoad() {
        self.fetchGameList()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        
        self.requestPageIndex = 0
        let requestPayload = ["id_player": self.player!.id, "size": REQUEST_PAGE_SIZE] as [String: Any]
        RequestRefresh().execute(requestPayload: requestPayload) { (response) in
            if(response == nil){
                return
            }
            let playerSelf: EntityPlayer = response!.last!
            self.setPlayer(player: playerSelf)
            
            let list: [EntityPlayer] = response!.dropLast()
            
            DispatchQueue.main.async() {
                self.renderHeader()
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
        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
        }
        let requestPayload = ["index": self.requestPageIndex, "size": REQUEST_PAGE_SIZE] as [String: Int]
        RequestPage().execute(requestPayload: requestPayload) { (result) in
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            if(result == nil){
                return
            }
            self.appendToLeaderboardTableList(additionalCellList: result!)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "RECENT", handler: { (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            
            let playerOther = self.leaderboardList[indexPath.row]
            
            let REQUEST_PAGE_SIZE: Int = 9
            
            let requestPayload = [
                "id": playerOther.id,
                "index": 0,
                "size": REQUEST_PAGE_SIZE
                ] as [String: Any]
            RequestHistoric().execute(requestPayload: requestPayload) { (result) in
                DispatchQueue.main.async() {
                    self.activityIndicator!.stopAnimating()
                    self.activityIndicator!.isHidden = true
                }
                if(result == nil){
                    DispatchQueue.main.async() {
                        let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
                        viewController.setPlayerSelf(playerSelf: self.player!)
                        viewController.setPlayerOther(playerOther: playerOther)
                        viewController.setBACK(BACK: "HOME")
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                    }
                    return
                }
                
                print("result.count: \(result!.count)")
                if(result!.count == 0){
                    DispatchQueue.main.async() {
                        let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
                        viewController.setPlayerSelf(playerSelf: self.player!)
                        viewController.setPlayerOther(playerOther: playerOther)
                        viewController.setBACK(BACK: "HOME")
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                    }
                    return
                }
                
                DispatchQueue.main.async() {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Recent", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Recent") as! Recent
                    viewController.setRecentGameList(recentGameList: result!)
                    viewController.setPlayerOther(playerOther: playerOther)
                    viewController.setPlayerSelf(playerSelf: self.player!)
                    //self.present(viewController, animated: false, completion: nil)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            
            print("RECENT SNAPS!")
            success(true)
        })
        if #available(iOS 13.0, *) {
            modifyAction.image = UIImage(systemName: "eye")!
        }
        modifyAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "CHALLENGE", handler: { (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            let playerOther = self.leaderboardList[indexPath.row]
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            viewController.setPlayerSelf(playerSelf: self.player!)
            viewController.setPlayerOther(playerOther: playerOther)
            viewController.setBACK(BACK: "HOME")
            UIApplication.shared.keyWindow?.rootViewController = viewController
            success(true)
        })
        if #available(iOS 13.0, *) { 
            modifyAction.image = UIImage(systemName: "gamecontroller.fill")!
        }
        modifyAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [modifyAction])
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
