//
// Copyright © 2020 Dictys. All rights reserved.
//

enum TranslatorSupportedLanguage: String, CaseIterable {
    case russian = "ru"
    case english = "en"
    case german = "de"
    case spanish = "es"
    case chinese = "zh"
    case japanese = "ja"
    case ukrainian = "uk"
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
