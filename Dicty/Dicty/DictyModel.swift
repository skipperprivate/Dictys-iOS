//
// Copyright © 2020 Dictys. All rights reserved.
//

import CoreData
import UIKit

class DictyModel {
    var name: String
    var category: DictyCategoryModel

    init(_ name: String, category: DictyCategoryModel) {
        self.name = name
        self.category = category
    }

//    convenience init?(obj: NSManagedObject) {
//        guard let name = obj.value(forKeyPath: T.Dictys.Name) as? String else {
//            return nil
//        }
//
//        self.init(name, categoryId: nil)
//    }
}
