//
// Copyright © 2020 Dictys. All rights reserved.
//

enum TranslatorSupportedLanguage: String, CaseIterable, CustomStringConvertible {
    case russian = "Русский"
    case english = "English"
    case german = "Deutsch"
    case spanish = "Española"
    case chinese = "中文"
    case japanese = "日本語"
    case ukrainian = "Український"

    var description: String {
        switch self {
        case .russian: return "ru"
        case .english: return "en"
        case .german: return "de"
        case .spanish: return "es"
        case .chinese: return "zh"
        case .japanese: return "ja"
        case .ukrainian: return "uk"
        }
    }
}

let supportedLanguages: [LanguageModel] = [
    LanguageModel("English", 1, TranslatorSupportedLanguage.english),
    LanguageModel("Русский", 2, TranslatorSupportedLanguage.russian),
    LanguageModel("Deutsch", 3, TranslatorSupportedLanguage.german),
    LanguageModel("Española", 4, TranslatorSupportedLanguage.spanish),
    LanguageModel("中文", 5, TranslatorSupportedLanguage.chinese),
    LanguageModel("日本語", 6, TranslatorSupportedLanguage.japanese),
    LanguageModel("Український", 7, TranslatorSupportedLanguage.ukrainian)
]
