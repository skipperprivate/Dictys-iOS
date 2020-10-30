//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class DictysViewController: UITableViewController {
    @IBOutlet var leftNavBarButton: UIBarButtonItem!
    @IBOutlet var rightNavBarButton: UIBarButtonItem!

    var dictys = DictysCategory.tempDictys

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Словари"
    }

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DictyCell", for: indexPath) as? DictyCell else {
            return .init()
        }

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

        guard let cell = tableView.cellForRow(at: indexPath) as? DictyCell else {
            return
        }
        dictyViewController.name = cell.celllabel.text!
        dictyViewController.words = Letter.tempWords
        self.navigationController?.pushViewController(dictyViewController, animated: true)
    }

    func customizeNavigationItem() {
        //    leftNavBarButton.image = #imageLiteral(resourceName: "Plus")
        rightNavBarButton.image = #imageLiteral(resourceName: "SearchIcon")

        leftNavBarButton.tintColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        rightNavBarButton.tintColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
    }

    func customizeHeader() {
    }
}
