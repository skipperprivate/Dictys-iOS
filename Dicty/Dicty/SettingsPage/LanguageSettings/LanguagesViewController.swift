//
//  LanguagesViewController.swift
//  Dicty
//
//  Created by Егор Бедов on 15/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let languages = Languages.supportedLanguages
    var selectedLanguage = Languages.english
    var selectedRow = 0
    
    var cells: [LanguageCellModel] = [
        LanguageCellModel(imageName: "English", title: "English"),
        LanguageCellModel(imageName: "Russian", title: "Русский"),
        LanguageCellModel(imageName: "German", title: "Deutsch"),
        LanguageCellModel(imageName: "Spanish", title: "Española"),
        LanguageCellModel(imageName: "Chinese", title: "中文"),
        LanguageCellModel(imageName: "Japanese", title: "日本語"),
        LanguageCellModel(imageName: "Ukrainian", title: "Українська")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Interface language"
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as? LanguageCell else {
            return .init()  //.inti() = UITableViewCell here
        }
        if languages[indexPath.row] == selectedLanguage {
          cell.accessoryType = .checkmark
          selectedRow = indexPath.row
        } else {
          cell.accessoryType = .none
        }
        cell.configure(with: cells[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unselect the row
        tableView.deselectRow(at: indexPath, animated: false)

        // Remove the checkmark from the previously selected filter item
        if let previousCell = tableView.cellForRow(at: IndexPath(row: selectedRow, section: indexPath.section)) {
          previousCell.accessoryType = .none
        }

        // Mark the newly selected filter item with a checkmark.
        if let cell = tableView.cellForRow(at: indexPath) {
          cell.accessoryType = .checkmark
        }

        // Remember this selected filter item.
        selectedRow = indexPath.row
    }
}



/*
import UIKit

class LanguagesViewController: UITableViewController {
  let languages = Languages.supportedLanguages
  var selectedLanguage = Languages.english
  var selectedRow = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return languages.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)

    cell.textLabel?.text = languages[indexPath.row].rawValue

    if languages[indexPath.row] == selectedLanguage {
      cell.accessoryType = .checkmark
      selectedRow = indexPath.row
    } else {
      cell.accessoryType = .none
    }

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Unselect the row
    tableView.deselectRow(at: indexPath, animated: false)

    // Remove the checkmark from the previously selected filter item
    if let previousCell = tableView.cellForRow(at: IndexPath(row: selectedRow, section: indexPath.section)) {
      previousCell.accessoryType = .none
    }

    // Mark the newly selected filter item with a checkmark.
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.accessoryType = .checkmark
    }

    // Remember this selected filter item.
    selectedRow = indexPath.row
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
}
*/
