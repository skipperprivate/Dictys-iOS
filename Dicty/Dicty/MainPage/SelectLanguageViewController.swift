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

    // по идее здесь она уже не нужна
    //var viewModel: MainPageViewModel? = nil
    private let disposeBag = DisposeBag()

    // ещё подумать
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

    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        print("You tapped cell number \(indexPath.row).")
    //        defaults.set(languages[indexPath.row].shortName.rawValue, forKey: lang ?? K.UserDefaults.SourceLang)
    //
    //        didSelectCompletion?()
    //
    //        guard let mainVC = self.parent as? MainPageViewController else {
    //            return
    //        }
    //
    //        self.dismiss(animated: true, completion: nil)
    //    }

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
            // привязка должна быть не здесь
            .bind(to: self.selectableLanguage)
            .disposed(by: disposeBag)
    }
}
