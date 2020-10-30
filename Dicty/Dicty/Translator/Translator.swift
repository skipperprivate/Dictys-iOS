//
// Copyright © 2020 Dictys. All rights reserved.
//

import Foundation

// TODO: добавить description для формы

enum TranslatorApiResponse {
    case success(TranslateModel)
    case failure(Error?)
}

protocol Translator: AnyObject {
  func translatePhrase(phrase: String, sourceLang: TranslatorSupportedLanguage, targetLang: TranslatorSupportedLanguage,
                       completion: @escaping (TranslatorApiResponse) -> Void)
}
