//
//  Copyright © 2020 Dictys. All rights reserved.
//

import UIKit
import CoreData

class DictyCategoryModel {
    let id: Int
    let name: String
    let icon: UIImage

    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.icon = iconsDict[name] ?? #imageLiteral(resourceName: "LoadingIcon")
    }

//    convenience init?(obj: NSManagedObject) {
//        guard let id = obj.value(forKey: T.) as? String,
//              let trans = obj.value(forKey: T.Translates.Translated) as? String,
//              let oLang = obj.value(forKey: T.Translates.SourceLang) as? TranslatorSupportedLanguage,
//              let tLang = obj.value(forKey: T.Translates.TargetLang) as? TranslatorSupportedLanguage
//        else {
//            return nil
//        }
//
//        self.init(id: id, name: name)
//    }
}
