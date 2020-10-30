//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class SelectLanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let database = Database.shared
    let defaults = UserDefaults.standard
    var lang: String?
    var languages: [LanguageModel] = []

    let cellReuseIdentifier = "cell"

    typealias Callback = () -> Void

    var didSelectCompletion: Callback? = nil

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self

        languages = database.fetchLanguages()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
            return .init()
        }

        cell.textLabel?.text = self.languages[indexPath.row].name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You tapped cell number \(indexPath.row).")
        defaults.set(languages[indexPath.row].shortName.rawValue, forKey: lang ?? K.UserDefaults.SourceLang)

        didSelectCompletion?()

        self.dismiss(animated: true, completion: nil)
    }
}
