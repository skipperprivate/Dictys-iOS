//
// Copyright © 2020 Dictys. All rights reserved.
//

import Foundation

// TODO: добавить description для формы
enum TranslatorSupportedLanguage: String, CaseIterable {
    case russian = "ru"
    case english = "en"
    case german = "de"
    case spanish = "es"
    case chinese = "zh"
    case japanese = "ja"
    case ukrainian = "uk"
}

protocol Translator: AnyObject {
  func translatePhrase(phrase: String, sourceLang: TranslatorSupportedLanguage, targetLang: TranslatorSupportedLanguage,
                       callback: @escaping (String) -> Void)
}
