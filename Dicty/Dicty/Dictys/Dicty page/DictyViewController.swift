//
//  DictyViewController.swift
//  Dicty
//
//  Created by Егор Бедов on 19/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class DictyViewController: UITableViewController {
    
    var words = [Letter]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words[section].words.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return words[section].letter
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordCell
        
        cell.originalLabel.text = words[indexPath.section].words[indexPath.row].originalWord
        cell.translatedLabel.text = words[indexPath.section].words[indexPath.row].translatedWord
        
        return cell
    }
    
    // https://developer.apple.com/documentation/uikit/uisearchbar
    // https://stackoverflow.com/questions/32004557/swipe-able-table-view-cell-in-ios-9
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
