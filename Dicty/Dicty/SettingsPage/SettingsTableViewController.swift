//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        return tableView
    }()
    var database = Database.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.edgesToSuperview()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Настройки"
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Settings.allSettings[section].title
    }
//  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//      let someView = UIView()
//      someView.backgroundColor = .orange
//      return someView
//  }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Settings.allSettings.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.allSettings[section].fields.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as? SettingsTableViewCell else {
            return.init()
        }
        cell.label.text = Settings.allSettings[indexPath.section].fields[indexPath.row].title
        cell.pictureView.image = Settings.allSettings[indexPath.section].fields[indexPath.row].icon
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 4 && indexPath.row == 1 {
            database.purge()
            database.populate()
        }
    }
}
