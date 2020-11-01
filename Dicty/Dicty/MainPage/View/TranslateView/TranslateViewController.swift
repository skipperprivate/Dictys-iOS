//
//  Copyright © 2020 Dicty. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum TranslateViewPlaceholders: String {
    case sourceTextPlaceholder = "Введи новое слово..."
    case translatedTextPlaceholder = "Enter a new word..."
}

class TranslateViewController: UIViewController, TranslateViewDelegate {
    let translateView = TranslateView()
    private let disposeBag = DisposeBag()
    var viewModel: MainPageViewModel? = nil

    private var isViewControllerPresentedForSelectSourceLang = true
    private var selectVC: SelectLanguageViewController?

    // перепривязать на rx
    func onSourceLanguageButtonTap() {
        guard let selectVC = self.selectVC else {
            return
        }
        isViewControllerPresentedForSelectSourceLang = true
        self.present(selectVC, animated: true, completion: nil)
    }

    func onTargetLanguageButtonTap() {
        guard let selectVC = self.selectVC else {
            return
        }
        isViewControllerPresentedForSelectSourceLang = false
        self.present(selectVC, animated: true, completion: nil)
    }

    override func loadView() {
        translateView.delegate = self
        self.view = translateView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translateView.resizeLabels()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        setupUIBindings()
        setupChildController()
    }

    func setupChildController() {
        self.selectVC = {
            let storyboard = UIStoryboard(name: "MainPage", bundle: Bundle.main)
            guard let selectLanguageVC = storyboard.instantiateViewController(withIdentifier: "SelectLanguageViewController") as? SelectLanguageViewController
            else {
                return nil
            }
            return selectLanguageVC
        }()

        guard let selectVC = self.selectVC else {
            return
        }

        selectVC.selectableLanguage
            .subscribe(onNext: { [weak self] lang in
                guard let self = self else {
                    return
                }
                if self.isViewControllerPresentedForSelectSourceLang {
                    self.viewModel?.sourceLanguage.accept(lang)
                } else {
                    self.viewModel?.targetLanguage.accept(lang)
                }
            }).disposed(by: disposeBag)
    }
}

extension TranslateViewController {
    func setupUIBindings() {
        self.translateView.sourceTextView.rx.didBeginEditing
            .map { self.translateView.sourceTextView.text }
            .subscribe(onNext: { text in
                if self.translateView.sourceTextView.textColor == #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1) {
                    self.translateView.sourceTextView.text = ""
                    self.translateView.translatedTextView.text = ""
                    self.translateView.sourceTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    self.translateView.translatedTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }
            })
            .disposed(by: disposeBag)

        self.translateView.sourceTextView.rx.didEndEditing
            .map { self.translateView.sourceTextView.text }
            .subscribe(onNext: { text in
                guard let text = text else {
                    return
                }
                if text.isEmpty {
                    self.translateView.sourceTextView.text = TranslateViewPlaceholders.sourceTextPlaceholder.rawValue
                    self.translateView.translatedTextView.text = ""
                    self.translateView.sourceTextView.textColor = #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1)
                    self.translateView.translatedTextView.textColor = #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1)
                }
            })
            .disposed(by: disposeBag)

        self.translateView.changeLanguagesButton.rx
            .tap
            .bind {
                self.viewModel?.swapLanguages()
            }
            .disposed(by: disposeBag)

        self.viewModel?.translatedPhrase
            .compactMap { $0 }
            .bind(to: self.translateView.translatedTextView.rx.text)
            .disposed(by: disposeBag)

        self.viewModel?.originalPhrase
            .compactMap { $0 }
            .bind(to: self.translateView.sourceTextView.rx.text)
            .disposed(by: disposeBag)

        self.translateView.sourceTextView.rx.text
            .bind(to: self.viewModel!.originalPhrase)
            .disposed(by: disposeBag)

        self.viewModel?.targetLanguage
            .map { $0.rawValue }
            .bind(to: self.translateView.targetLanguageButton.rx.title())
            .disposed(by: disposeBag)

        self.viewModel?.sourceLanguage
            .map { $0.rawValue }
            .bind(to: self.translateView.sourceLanguageButton.rx.title())
            .disposed(by: disposeBag)
    }
}
