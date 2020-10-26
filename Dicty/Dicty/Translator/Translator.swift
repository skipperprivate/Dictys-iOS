//
// Copyright © 2020 Dictys. All rights reserved.
//

import Foundation

// TODO: добавить description для формы

protocol Translator: AnyObject {
  func translatePhrase(phrase: String, sourceLang: TranslatorSupportedLanguage, targetLang: TranslatorSupportedLanguage,
                       callback: @escaping (String) -> Void)
}
