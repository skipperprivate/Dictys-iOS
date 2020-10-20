//
//  DictyViewController.swift
//  Dicty
//
//  Created by Егор Бедов on 19/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class DictyViewController: UITableViewController {
  var name: String = ""
  var words = [Letter]()
  var searchWords = [Word]()
  var searching: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }
  let searchController = UISearchController(searchResultsController: nil)

  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = name
    self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add,
                                                          target: self,
                                                          action: nil),
                                          animated: true)    // TODO: add action

    // Remove empty cells at the bottom
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)

    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    // Add searchbar to navigation since Interface Builder can't
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    // TODO: clean that up
    if searching {
      if searchWords.isEmpty {
        tableView.showEmptyTableView()
        return 0
      }
      tableView.restore()
      return 1
    } else if words.isEmpty {
      tableView.showEmptyTableView()
      return 0
    }
    tableView.restore()
    return words.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searching {
      return searchWords.count
    }
    return words[section].words.count
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if searching {
      return "Results"    // Questionable
    }
    return String(words[section].letter)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as? WordCell else {
      return .init()
    }

    let word: Word

    if searching {
      word = searchWords[indexPath.row]
    } else {
      word = words[indexPath.section].words[indexPath.row]
    }

    cell.originalLabel.text = word.originalWord
    cell.translatedLabel.text = word.translatedWord

    return cell
  }

  // TODO: replace uitableview style with plain and customize ti
  // https://developer.apple.com/documentation/uikit/uisearchbar
  // https://stackoverflow.com/questions/32004557/swipe-able-table-view-cell-in-ios-9
}

extension DictyViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    searchWords = searchFor(searchBar.text!, in: words)
    tableView.reloadData()
  }
  //https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started
}

extension UITableView {
  func showEmptyTableView() {
    let label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height)))
    label.backgroundColor = UIColor.cyan
    label.textAlignment = .center
    label.text = "No words"
    label.textColor = UIColor.white
    label.numberOfLines = 0
    label.sizeToFit()

    self.backgroundView = label
    self.separatorStyle = .none
  }

  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}
