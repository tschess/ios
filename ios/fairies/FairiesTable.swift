//
//  FairyTable.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class FairiesTable: UITableViewController {
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    //var fairyListAdapter: Array<Fairy> = Array(arrayLiteral: Amazon(), Poison(), Hunter(), Grasshopper())
    var fairyListAdapter: Array<Fairy> = Array(arrayLiteral: Amazon(), Hunter(), Poison())
    
    var fairyListFilter: [Fairy]?
    
    func setFairyElementList(fairyElementList: [Fairy]) {
        self.fairyListFilter = [Fairy]()
        
        for fairyElementAdapter in fairyListAdapter {
            fairyListFilter!.append(fairyElementAdapter)
        }
        self.tableView.reloadData()
    }
    
    func getFairyElementList() -> [Fairy]? {
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
        let squadUpAdapterCell = tableView.dequeueReusableCell(withIdentifier: "FairiesCell", for: indexPath) as! FairiesCell
        let squadUpFairyElement = fairyListFilter![indexPath.row]
        squadUpAdapterCell.elementNameLabel.text = self.getName(name: squadUpFairyElement.name)
        squadUpAdapterCell.elementImageView.image = squadUpFairyElement.getImageDefault()
        return squadUpAdapterCell
    }
    
    func getName(name: String) -> String {
        if(name == "Poison"){
            return "poison pawn"
        }
        return name.lowercased()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let squadUpDetailSelectionDictionary = ["fairies_table_selection": indexPath.row]
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "FairiesTableSelection"),
            object: nil,
            userInfo: squadUpDetailSelectionDictionary)
    }
    
}
