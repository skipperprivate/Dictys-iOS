//
//  DictysViewController.swift
//  Dicty
//
//  Created by Егор Бедов on 17/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class DictysViewController: UITableViewController {
    
    @IBOutlet weak var leftNavBarButton: UIBarButtonItem!
    @IBOutlet weak var rightNavBarButton: UIBarButtonItem!
    
    var dictys = DictysCategory.tempDictys
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.backgroundColor = UIColor.black
        
        customizeNavigationItem()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dictys.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dictys[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictys[section].dictys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictyCell", for: indexPath) as! DictyCell
        
        cell.customizeCell(icon: dictys[indexPath.section].dictys[indexPath.row].icon,
                           title: dictys[indexPath.section].dictys[indexPath.row].title)
        
        if indexPath.section == 2 {
            cell.fillIcon()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unselect the row
        tableView.deselectRow(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: "Dicty", bundle: Bundle.main)
        
        guard let dictyViewController = storyboard.instantiateViewController(withIdentifier: "DictyViewController") as? DictyViewController else {
            print("failed")
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! DictyCell
        dictyViewController.name = cell.celllabel.text!
        dictyViewController.words = Letter.tempWords
        self.navigationController?.pushViewController(dictyViewController, animated: true)
    }
    
    func customizeNavigationItem() {
        leftNavBarButton.image = UIImage(named: "AddIcon")
        rightNavBarButton.image = UIImage(named: "SearchIcon")
        leftNavBarButton.tintColor = UIColor.blue
        rightNavBarButton.tintColor = UIColor.blue
    }

    func customizeHeader() {
        
    }
}
