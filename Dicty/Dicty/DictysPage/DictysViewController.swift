//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class DictysViewController: UITableViewController {
    @IBOutlet var leftNavBarButton: UIBarButtonItem!
    @IBOutlet var rightNavBarButton: UIBarButtonItem!

    let sections: [(String, [DictyModel])] = [
        ("General dictys", tmpLangDictys),
        ("Your dictys", tmpCustomDictys)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeNavigationItem()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DictyCell", for: indexPath) as? DictyCell else {
            return .init()
        }
        systemMinimumLayoutMargins

        cell.configure(viewModel: DictyViewVM(dicty: sections[indexPath.section].1[indexPath.row]))

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
