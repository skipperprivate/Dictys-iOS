//
//  DictysViewController.swift
//  Dicty
//
//  Created by Егор Бедов on 17/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class DictysViewController: UIViewController {
    
    var dictys = DictysCategory.tempDictys
    
    @IBOutlet weak var leftNavBarButton: UIBarButtonItem!
    @IBOutlet weak var rightNavBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.backgroundColor = UIColor.black
        
        customizeNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.view.backgroundColor = UIColor.black
    }
    
    func customizeNavigationItem() {
        leftNavBarButton.image = UIImage(named: "AddIcon")
        rightNavBarButton.image = UIImage(named: "SearchIcon")
        leftNavBarButton.tintColor = UIColor.blue
        rightNavBarButton.tintColor = UIColor.blue
    }

}

extension DictysViewController: UITableViewDataSource,  UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dictys.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dictys[section].title
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
//        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
//        label.font = UIFont.systemFont(ofSize: 14)
//        view.addSubview(label)
//        view.backgroundColor = UIColor.gray
//
//        return view
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictys[section].dictys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictyCell", for: indexPath) as! DictyCell
        
        cell.customizeCell(icon: dictys[indexPath.section].dictys[indexPath.row].icon,
                           title: dictys[indexPath.section].dictys[indexPath.row].title)
        
        if indexPath.section == 2 {
            cell.fillIcon()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unselect the row
        tableView.deselectRow(at: indexPath, animated: false)
        
        print("tap on dicty")
        
//        let dicty = dictys[indexPath.section].dictys[indexPath.row]
//        let dictyViewController = DictyViewController(dicty: dicty)
//        present(dictyViewController, animated: true, completion: nil)
    }
    
}
