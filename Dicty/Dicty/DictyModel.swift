//
// Copyright © 2020 Dictys. All rights reserved.
//

import CoreData

class DictyModel {
    var name: String

    init(_ name: String) {
        self.name = name
    }

    convenience init?(obj: NSManagedObject) {
        guard let name = obj.value(forKeyPath: T.Dictys.Name) as? String else {
            return nil
        }

        self.init(name)
    }
}
