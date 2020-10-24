//  Copyright © 2020 Dictys

import CoreData

class LanguageModel {
    let name: String
    let id: Int16

    init(name: String, id: Int16) {
        self.name = name
        self.id = id
    }

    convenience init?(obj: NSManagedObject) {
        guard let name = obj.value(forKey: T.Languages.Name) as? String,
              let id = obj.value(forKey: T.Languages.Id) as? Int16 else {
            return nil
        }

        self.init(name: name, id: id)
    }
}
