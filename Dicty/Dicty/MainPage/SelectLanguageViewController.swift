//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectLanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let database = Database.shared
    let defaults = UserDefaults.standard
    var lang: String?
    var languages: [LanguageModel] = []

    let cellReuseIdentifier = "cell"

    private let disposeBag = DisposeBag()

    let selectableLanguage: PublishRelay<TranslatorSupportedLanguage> = PublishRelay()

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.register(UINib(nibName: "SelectLanguageTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self

        languages = database.fetchLanguages()
        setupTableView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? SelectLanguageTableViewCell else {
            return .init()
        }

        cell.label.text = self.languages[indexPath.row].name
        return cell
    }

    func setupTableView() {
        tableView.rx.itemSelected
            .map { [weak self] (indexPath: IndexPath) -> TranslatorSupportedLanguage in
                guard
                    let self = self,
                    let cell = self.tableView.cellForRow(at: indexPath) as? SelectLanguageTableViewCell,
                    let text = cell.label.text else {
                    return TranslatorSupportedLanguage.english
                }
                let lang = TranslatorSupportedLanguage.init(rawValue: text) ?? .english
                self.dismiss(animated: true, completion: nil)
                return lang
            }
            .bind(to: self.selectableLanguage)
            .disposed(by: disposeBag)
    }
}
