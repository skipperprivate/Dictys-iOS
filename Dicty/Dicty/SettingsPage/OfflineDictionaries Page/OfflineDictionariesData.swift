//
//  Copyright © 2020 Dictys. All rights reserved.
//

import Foundation

enum OfflineDictionaries: String {
    case english = "English"
    case german  = "German"
    case spanish = "Spanish"

    static var availableDictionaries: [OfflineDictionaries] {
        return [.english,
                .german,
                .spanish]
    }
}
