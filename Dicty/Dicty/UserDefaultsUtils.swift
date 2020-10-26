//
//  Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

final class UDUtils {
    static func getSourceLang() -> LanguageModel {
        let lang = supportedLanguages.first(
            where: { $0.shortName == getLang(
                key: K.UserDefaults.SourceLang,
                defaultValue: TranslatorSupportedLanguage.russian)
            })!
        print("Current source lang \(lang.name)")
        return lang
    }

    static func getTargetLang() -> LanguageModel {
        return supportedLanguages
            .first(where: { $0.shortName == getLang(
                    key: K.UserDefaults.TargetLang,
                    defaultValue: TranslatorSupportedLanguage.english)
            })!
    }

    private static func getLang(key: String, defaultValue: TranslatorSupportedLanguage) -> TranslatorSupportedLanguage {
        if let fromUD = UserDefaults.standard.string(forKey: key) {
            return TranslatorSupportedLanguage(rawValue: fromUD) ?? defaultValue
        } else {
            UserDefaults.standard.setValue(defaultValue.rawValue, forKey: key)
        }
        return defaultValue
    }
}
