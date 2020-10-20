//
//  TranslateViewController.swift
//  Dicty
//
//  Created by a.chetverov on 18.10.2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//
import Eureka
import UIKit

class TranslateViewController: FormViewController {
  var sourceLang: TranslatorSupportedLanguage = .russian
  var targetLang: TranslatorSupportedLanguage = .english

  override func viewDidLoad() {
    super.viewDidLoad()

    form +++

      Section("Test section")

      <<< DoublePickerInlineRow<String, String>("Languages Picker") {
        $0.title = "2 Component picker"
        $0.firstOptions = { TranslatorSupportedLanguage.allCases.map { $0.rawValue } }
        $0.secondOptions = { _ in TranslatorSupportedLanguage.allCases.map { $0.rawValue } }

        $0.onChange { picker in
          guard
            let source = TranslatorSupportedLanguage(rawValue: picker.value!.a),
            let target = TranslatorSupportedLanguage(rawValue: picker.value!.b)
          else {
            return
          }

          self.sourceLang = source
          self.targetLang = target
        }
      }

      +++ Section("TextAreaRow")

      <<< TextAreaRow("SourceTextTag") {
        $0.placeholder = "Your text..."
        $0.textAreaHeight = .dynamic(initialTextViewHeight: 200)
      }

      <<< TextAreaRow("TranslatedTag") {
        $0.placeholder = "Translated text"
        $0.value = ""
        $0.textAreaMode = .readOnly
        $0.textAreaHeight = .fixed(cellHeight: 200)
      }
  }

  override func textInputDidEndEditing<T>(_ textInput: UITextInput, cell: Cell<T>) where T: Equatable {
    guard let phrase = textInput.text(in: textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument)!) else {
      return
    }

    let callback = { [weak self] (translatedPhrase: String) in
      guard let self = self else {
        return
      }

      if let textRow = self.form.rowBy(tag: "TranslatedTag") as? TextAreaRow {
        textRow.value = translatedPhrase
        textRow.reload()
      }
    }
    let translator = AWSTranslator()
    translator.translatePhrase(phrase: phrase, sourceLang: sourceLang, targetLang: targetLang, callback: callback)
  }
}
