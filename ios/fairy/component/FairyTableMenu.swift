//
//  SquadUpAdapter.swift
//  ios
//
//  Created by Matthew on 8/8/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class FairyTableMenu: UITableViewController {
    
//    var player: Player?
//    
//    public func setPlayer(player: Player){
//        self.player = player
//    }
    
    var fairyListAdapter: Array<FairyElement> = Array(arrayLiteral: Amazon(), ArrowPawn(), Hunter(), LandminePawn(), Grasshopper())
    
    var fairyListFilter: [FairyElement]?
    
    func setFairyElementList(fairyElementList: [FairyElement]) {
        
        self.fairyListFilter = [FairyElement]()
        
        for fairyElementAdapter in fairyListAdapter {
            
            //if !fairyElementList.contains(where: {($0.name == fairyElementAdapter.name)}){
                
                fairyListFilter!.append(fairyElementAdapter)
            //}
        }
        self.tableView.reloadData()
    }
    
    func getFairyElementList() -> [FairyElement]? {
        return fairyListFilter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(fairyListFilter != nil) {
            return fairyListFilter!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let squadUpAdapterCell = tableView.dequeueReusableCell(withIdentifier: "FairyTableCell", for: indexPath) as! FairyTableCell
        let squadUpFairyElement = fairyListFilter![indexPath.row]
        
        squadUpAdapterCell.elementNameLabel.text = squadUpFairyElement.name.lowercased()
        squadUpAdapterCell.elementImageView.image = squadUpFairyElement.getImageDefault()
        
//        if(self.player!.getFairyElementList().contains(squadUpFairyElement)){
//            squadUpAdapterCell.alpha = 0.75
//        } else {
//            squadUpAdapterCell.alpha = 1.0
//        }
        
        return squadUpAdapterCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let squadUpDetailSelectionDictionary = ["squad_up_detail_selection": indexPath.row]
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "SquadUpDetailSelection"),
            object: nil,
            userInfo: squadUpDetailSelectionDictionary)
    }
    
}
