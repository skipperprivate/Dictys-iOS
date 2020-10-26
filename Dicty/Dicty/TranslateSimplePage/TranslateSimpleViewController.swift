//
// Copyright © 2020 Dictys. All rights reserved.
//

import Eureka
import UIKit

class TranslateSimpleViewController: FormViewController {
    var languages: [LanguageModel] = []
    let database = Database.shared
    var sourceLang = TranslatorSupportedLanguage(rawValue: UserDefaults.standard.string(forKey: K.UserDefaults.SourceLang) ?? TranslatorSupportedLanguage.russian.rawValue) ?? TranslatorSupportedLanguage.russian
    var targetLang = TranslatorSupportedLanguage(rawValue: UserDefaults.standard.string(forKey: K.UserDefaults.TargetLang) ?? TranslatorSupportedLanguage.english.rawValue) ?? TranslatorSupportedLanguage.english

  override func viewDidLoad() {
    super.viewDidLoad()

    languages = database.fetchLanguages()

    form +++

      Section("Test section")

      <<< DoublePickerInlineRow<String, String>("Languages Picker") {
        $0.title = "2 Component picker"
        $0.firstOptions = { self.languages.map { $0.shortName.rawValue } }
        $0.secondOptions = { _ in self.languages.map { $0.shortName.rawValue } }

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
