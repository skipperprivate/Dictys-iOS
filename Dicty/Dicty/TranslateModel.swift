//  Copyright © 2020 Dictys

import CoreData

class TranslateModel {
    let original: String!
    let translated: String

    init(original orig: String, translated trans: String) {
        self.original = orig
        self.translated = trans
    }

    convenience init?(obj: NSManagedObject) {
        guard let orig = obj.value(forKey: T.Translates.Original) as? String,
              let trans = obj.value(forKey: T.Translates.Translated) as? String else {
            return nil
        }

        self.init(original: orig, translated: trans)
    }
}
