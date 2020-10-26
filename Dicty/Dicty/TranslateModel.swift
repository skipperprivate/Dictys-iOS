//
// Copyright © 2020 Dictys. All rights reserved.
//

import CoreData

class TranslateModel {
    let original: String
    let translated: String
    let originalLang: TranslatorSupportedLanguage
    let transatedLang: TranslatorSupportedLanguage

    init(original: String, originalLang: TranslatorSupportedLanguage, translated: String, transatedLang: TranslatorSupportedLanguage) {
        self.original = original
        self.translated = translated
        self.originalLang = originalLang
        self.transatedLang = transatedLang
    }

    convenience init?(obj: NSManagedObject) {
        guard let orig = obj.value(forKey: T.Translates.Original) as? String,
              let trans = obj.value(forKey: T.Translates.Translated) as? String,
              let oLang = obj.value(forKey: T.Translates.SourceLang) as? TranslatorSupportedLanguage,
              let tLang = obj.value(forKey: T.Translates.TargetLang) as? TranslatorSupportedLanguage
        else {
            return nil
        }

        self.init(original: orig, originalLang: oLang, translated: trans, transatedLang: tLang)
    }
}
