//
//  Copyright © 2020 Dicty. All rights reserved.
//

import UIKit

enum TranslateViewPlaceholders: String {
    case sourceTextPlaceholder = "Введи новое слово..."
    case translatedTextPlaceholder = "Здесь будет перевод"
}

class TranslateViewController: UIViewController, TranslateViewDelegate {
    var sourceLang = UDUtils.getSourceLang()
    var targetLang = UDUtils.getTargetLang()

    let headerTranslateView = TranslateView()

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
        // TODO: @chtvrv present correctly plz
        self.present(selectLanguageVC, animated: true, completion: nil)
    }

    public override func loadView() {
        headerTranslateView.delegate = self
        self.view = headerTranslateView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
    }
}

extension TranslateViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = TranslateViewPlaceholders.sourceTextPlaceholder.rawValue
            textView.textColor = #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1)
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1) {
            textView.text = ""
            textView.textColor = .black
        }
    }
}
