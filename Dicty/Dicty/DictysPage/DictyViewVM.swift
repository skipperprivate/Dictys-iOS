//
//  Copyright © 2020 Dictys. All rights reserved.
//

import Foundation
import UIKit

class DictyViewVM {
    private var dicty: DictyModel

    init(dicty: DictyModel) {
        self.dicty = dicty
    }

    var name: String {
        return self.dicty.name
    }

    var category: DictyCategoryModel {
        return self.dicty.category
    }
}
