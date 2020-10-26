//
//  TranslateViewController.swift
//  Dicty
//
//  Created by a.chetverov on 22.10.2020.
//  Copyright © 2020 Dicty. All rights reserved.
//

import UIKit

enum TranslateViewPlaceholders: String {
    case sourceTextPlaceholder = "Введи новое слово..."
    case translatedTextPlaceholder = "Здесь будет перевод"
}

class TranslateViewController: UIViewController, TranslateViewDelegate {
    func onSourceLanguageButtonTap() {
        guard let viewController: SelectLanguageViewController = {
            let storyboard = UIStoryboard(name: "MainPage", bundle: Bundle.main)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "SelectLanguageViewController") as? SelectLanguageViewController
            else {
                return nil
            }
            return viewController
        }() else {
            return
        }

        self.present(viewController, animated: true, completion: nil)
    }

    func onTargetLanguageButtonTap() {
        guard let viewController: SelectLanguageViewController = {
            let storyboard = UIStoryboard(name: "MainPage", bundle: Bundle.main)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "SelectLanguageViewController") as? SelectLanguageViewController
            else {
                return nil
            }
            return viewController
        }() else {
            return
        }

        self.present(viewController, animated: true, completion: nil)
    }

    var sourceLang: TranslatorSupportedLanguage = .russian
    var targetLang: TranslatorSupportedLanguage = .english

    let headerTranslateView = TranslateView()

    override func loadView() {
        headerTranslateView.delegate = self
        self.view = headerTranslateView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerTranslateView.resizeLabels()
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
