//
//  Copyright © 2020 Dictys
//

import CoreData

class LanguageModel {
    let name: String
    let id: Int16
    let shortName: TranslatorSupportedLanguage

    init(_ name: String, _ id: Int16, _ shortName: TranslatorSupportedLanguage) {
        self.name = name
        self.id = id
        self.shortName = shortName
    }

    convenience init?(obj: NSManagedObject) {
        guard let name = obj.value(forKey: T.Languages.Name) as? String,
              let id = obj.value(forKey: T.Languages.Id) as? Int16,
              let shortNameStr = obj.value(forKey: T.Languages.ShortName) as? String,
              let shortName = TranslatorSupportedLanguage(rawValue: shortNameStr)
        else {
            return nil
        }

        self.init(name, id, shortName)
    }
}
