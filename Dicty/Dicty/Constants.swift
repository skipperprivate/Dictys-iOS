//
// Copyright © 2020 Dictys. All rights reserved.
//

struct T {
    static let ModelName = "Dictys"

    // MARK: User tables
    struct Translates {
        static let Table = "TTranslate"
        static let Original = "original"
        static let Translated = "translated"
        static let OriginalLang = "originalLang"
        static let TranslatedLang = "translatedLang"
    }

    struct Dictys {
        static let Table = "TDicty"
        static let Name = "name"
    }

    static let UserTables = [T.Translates.Table, T.Dictys.Table]

    // MARK: Default tables
    struct Languages {
        static let Table = "TLanguage"
        static let Id = "id"
        static let Name = "name"
        static let ShortName = "shortName"
    }

    static let DefaultTables = [T.Languages.Table]
}
