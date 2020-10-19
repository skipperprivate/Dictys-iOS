//  Copyright © 2020 Dicty

import Foundation

// TODO: добавить description для формы
enum TranslatorSupportedLanguage: String, CaseIterable {
  case russian = "ru"
  case english = "en"
}

protocol Translator: AnyObject {
  func translatePhrase(phrase: String, sourceLang: TranslatorSupportedLanguage, targetLang: TranslatorSupportedLanguage,
                       callback: @escaping (String) -> Void)
}