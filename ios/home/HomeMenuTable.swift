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
        //        let discoverSelectionDictionary = ["leaderboard_index": indexPath.row]
        //        NotificationCenter.default.post(
        //            name: NSNotification.Name(rawValue: "HomeMenuTable"),
        //            object: nil,
        //            userInfo: discoverSelectionDictionary)
        
        let gameModel = self.leaderboardList[indexPath.row]
        
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Other", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Other") as! Other
            viewController.setPlayer(player: self.player!)
            viewController.setGameModel(gameModel: gameModel)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    func getGameModel(index: Int) -> Game {
        return self.leaderboardList[index]
    }
    
    let REQUEST_PAGE_SIZE: Int
    var requestPageIndex: Int
    var leaderboardList: [Game]
    
    required init?(coder aDecoder: NSCoder) {
        self.REQUEST_PAGE_SIZE = 9
        self.requestPageIndex = 0
        self.leaderboardList = [Game]()
        super.init(coder: aDecoder)
        
        print("WEHAAT IS ` ` ` \(self.classForCoder.description())")
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
        self.eloLabel!.text = self.player!.getElo()
        self.rankLabel!.text = self.player!.getRank()
        self.dispLabel!.text = String(abs(Int(self.player!.getDisp())!))
        let disp: Int = Int(self.player!.getDisp())!
        if(disp >= 0){
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.up")!
                self.dispImageView!.image = image
                self.dispImageView!.tintColor = .green
            }
            return
        }
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "arrow.down")!
            self.dispImageView!.image = image
            self.dispImageView!.tintColor = .red
        }
    }
    
    var player: Player?
    
    public func setPlayer(player: Player) {
        self.player = player
    }
    
    override func viewDidLoad() {
        self.fetchGameList()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        print("Hello World!")
        
        self.requestPageIndex = 0
        
        let requestPayload = ["id_player": self.player!.getId(), "size": REQUEST_PAGE_SIZE] as [String: Any]
        
        RequestRefresh().execute(requestPayload: requestPayload, player: self.player!) { (list, player) in
            
            self.setPlayer(player: player)
            
            DispatchQueue.main.async() {
                self.renderHeader()
                self.leaderboardList = [Game]()
                self.tableView.reloadData()
                self.appendToLeaderboardTableList(additionalCellList: list!)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMenuCell", for: indexPath) as! HomeMenuCell
        
        print("indexPath.row: \(indexPath.row)")
        
        let gameTableMenuItem = self.leaderboardList[indexPath.row]
        
        let dataDecoded: Data = Data(base64Encoded: gameTableMenuItem.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        cell.avatarImageView.image = decodedimage
        cell.rankLabel.text = gameTableMenuItem.getOpponentRank()
        cell.usernameLabel.text = gameTableMenuItem.getUsernameOpponent()
        
        let date = gameTableMenuItem.getOpponent().getDate()
        if(date == "TBD"){
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YY"
            var yayayaya = formatter.string(from: DateTime().currentDate())
            yayayaya.insert("'", at: yayayaya.index(yayayaya.endIndex, offsetBy: -2))
            cell.dateLabel.text = yayayaya
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YY"
            var yayayaya = formatter.string(from: DateTime().toFormatDate(string: date))
            yayayaya.insert("'", at: yayayaya.index(yayayaya.endIndex, offsetBy: -2))
            cell.dateLabel.text = yayayaya
        }
        
        cell.dispLabel.text = String(abs(Int(gameTableMenuItem.getOpponent().getDisp())!))
        
        let disp: Int = Int(gameTableMenuItem.getOpponent().getDisp())!
        
        if(disp >= 0){
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.up")!
                cell.dispImage.image = image
                cell.dispImage.tintColor = .green
            }
        }
        else {
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.down")!
                cell.dispImage.image = image
                cell.dispImage.tintColor = .red
            }
        }
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "CHALLENGE", handler: { (ac: UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            
            //let gameModel = Game(opponent: self.player!)
            let gameModel = self.leaderboardList[indexPath.row]
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            viewController.setPlayer(player: self.player!)
            viewController.setOpponent(opponent: gameModel.getOpponent())
            viewController.setGameModel(gameModel: gameModel)  //TODO: ???need this???
            UIApplication.shared.keyWindow?.rootViewController = viewController
            success(true)
        })
        if #available(iOS 13.0, *) { 
            modifyAction.image = UIImage(systemName: "gamecontroller.fill")!
        }
        modifyAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    func appendToLeaderboardTableList(additionalCellList: [Game]) {
        for game in additionalCellList {
            self.leaderboardList.append(game)
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
}
