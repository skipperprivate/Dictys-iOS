//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

enum TranslatorSupportedLanguage: String, CaseIterable {
    case russian = "ru"
    case english = "en"
    case german = "de"
    case spanish = "es"
    case chinese = "zh"
    case japanese = "ja"
    case ukrainian = "uk"
}

// Category constants
struct C {
    // Languages
    static let English = "English"
    static let Russian = "Русский"
    static let German = "Deutsch"
    static let Spanish = "Española"
    static let Chinese = "中文"
    static let Japanese = "日本語"
    static let Ukranian = "Український"

    // Categories
    static let Book = "Book"
    static let Magazine = "Magazine"
}

let iconsDict: [String: UIImage] = [
    C.English: #imageLiteral(resourceName: "English"),
    C.Russian: #imageLiteral(resourceName: "Russian"),
    C.German: #imageLiteral(resourceName: "German"),
    C.Spanish: #imageLiteral(resourceName: "Spanish"),
    C.Chinese: #imageLiteral(resourceName: "Chinese"),
    C.Japanese: #imageLiteral(resourceName: "Japanese"),
    C.Ukranian: #imageLiteral(resourceName: "Ukrainian"),
    C.Book: #imageLiteral(resourceName: "BookIcon"),
    C.Magazine: #imageLiteral(resourceName: "NewspaperIcon")
]

let supportedLanguages: [LanguageModel] = [
    LanguageModel(C.English, 1, TranslatorSupportedLanguage.english),
    LanguageModel(C.Russian, 2, TranslatorSupportedLanguage.russian),
    LanguageModel(C.German, 3, TranslatorSupportedLanguage.german),
    LanguageModel(C.Spanish, 4, TranslatorSupportedLanguage.spanish),
    LanguageModel(C.Chinese, 5, TranslatorSupportedLanguage.chinese),
    LanguageModel(C.Japanese, 6, TranslatorSupportedLanguage.japanese),
    LanguageModel(C.Ukranian, 7, TranslatorSupportedLanguage.ukrainian)
]

let staticCategoriesLangs: [DictyCategoryModel] = [
    DictyCategoryModel(id: 0, name: supportedLanguages[0].name),
    DictyCategoryModel(id: 1, name: supportedLanguages[1].name),
    DictyCategoryModel(id: 2, name: supportedLanguages[2].name),
    DictyCategoryModel(id: 3, name: supportedLanguages[3].name),
    DictyCategoryModel(id: 4, name: supportedLanguages[4].name),
    DictyCategoryModel(id: 5, name: supportedLanguages[5].name),
    DictyCategoryModel(id: 6, name: supportedLanguages[6].name)
]
let staticCategoriesCustom: [DictyCategoryModel] = [
    DictyCategoryModel(id: 7, name: C.Book),
    DictyCategoryModel(id: 8, name: C.Magazine)
]

let tmpLangDictys: [DictyModel] = [
    DictyModel("English", category: staticCategoriesLangs[0]),
    DictyModel("Deutsch", category: staticCategoriesLangs[1])
]

let tmpCustomDictys: [DictyModel] = [
    DictyModel("The Foghorn", category: staticCategoriesCustom[0])
]
