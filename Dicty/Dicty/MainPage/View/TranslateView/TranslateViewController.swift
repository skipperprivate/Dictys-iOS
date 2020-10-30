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
    var sourceLang = UDUtils.getSourceLang()
    var targetLang = UDUtils.getTargetLang()

    let translateView = TranslateView()
    private let disposeBag = DisposeBag()
    public let translate: PublishSubject<TranslateModel> = PublishSubject()

    func onSourceLanguageButtonTap() {
        guard let selectLanguageVC: SelectLanguageViewController = {
            let storyboard = UIStoryboard(name: "MainPage", bundle: Bundle.main)
            guard let selectLanguageVC = storyboard.instantiateViewController(withIdentifier: "SelectLanguageViewController") as? SelectLanguageViewController
            else {
                return nil
            }
            return selectLanguageVC
        }() else {
            return
        }

        selectLanguageVC.didSelectCompletion = { [weak self] in
            guard let self = self else {
                return
            }
            self.translateView.reloadButtons()
        }

        selectLanguageVC.lang = K.UserDefaults.SourceLang
        self.present(selectLanguageVC, animated: true, completion: nil)
    }

    func onTargetLanguageButtonTap() {
        guard let selectLanguageVC: SelectLanguageViewController = {
            let storyboard = UIStoryboard(name: "MainPage", bundle: Bundle.main)
            guard let selectLanguageVC = storyboard.instantiateViewController(withIdentifier: "SelectLanguageViewController") as? SelectLanguageViewController
            else {
                return nil
            }
            return selectLanguageVC
        }() else {
            return
        }

        selectLanguageVC.lang = K.UserDefaults.TargetLang
        selectLanguageVC.didSelectCompletion = { [weak self] in
            guard let self = self else {
                return
            }
            self.translateView.reloadButtons()
        }

        self.present(selectLanguageVC, animated: true, completion: nil)
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

    func setupTextView() {
        self.translate
            .map { translateModel in
                return translateModel.translated
            }
            .bind(to: self.translateView.translatedTextView.rx.text)
            .disposed(by: disposeBag)

        self.translateView.sourceTextView.rx.text
            .debounce(.milliseconds(800), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else {
                    return
                }
                if let mainVC = self.parent as? MainPageViewController {
                    mainVC.viewModel.fetchTranslate(phrase: text ?? "", sourceLang: .russian, targetLang: .english)
                }
            }).disposed(by: disposeBag)
    }
}
