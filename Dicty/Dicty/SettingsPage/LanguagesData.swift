//
//  LanguagesData.swift
//  Dicty
//
//  Created by Егор Бедов on 15/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

enum Languages: String {
    case English  = "🇬🇧 English"
    case Russian  = "🇷🇺 Русский"
    case German   = "🇩🇪 Deutsch"
    case Spanish  = "🇪🇸 Española"
    case Chinese  = "🇨🇳 中文"
    case Japanese = "🇯🇵 日本語"
    case Ukranian = "🇺🇦 Український"
    
    static var supportedLanguages: [Languages] {
        return [English,
                .Russian,
                .German,
                .Spanish,
                .Chinese,
                .Japanese,
                .Ukranian]
    }
}
