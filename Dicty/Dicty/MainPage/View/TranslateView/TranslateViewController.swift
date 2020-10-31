//
//  Copyright © 2020 Dicty. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum TranslateViewPlaceholders: String {
    case sourceTextPlaceholder = "Введи новое слово..."
    case translatedTextPlaceholder = "Здесь будет перевод"
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
        setupTextView()
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

extension TranslateViewController: UITextViewDelegate {
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = TranslateViewPlaceholders.sourceTextPlaceholder.rawValue
//            textView.textColor = #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1)
//        }
//    }
//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1) {
//            textView.text = ""
//            textView.textColor = .black
//        }
//    }

    // здесь не только textView
    func setupTextView() {
        self.viewModel?.translatedPhrase
            .compactMap { $0 }
            .bind(to: self.translateView.translatedTextView.rx.text)
            .disposed(by: disposeBag)

        guard let mainVC = self.parent as? MainPageViewController else {
            return
        }

        self.translateView.sourceTextView.rx.text
            .bind(to: mainVC.viewModel.originalPhrase)
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
