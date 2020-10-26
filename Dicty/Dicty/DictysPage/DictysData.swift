//
// Copyright © 2020 Dictys. All rights reserved.
//

import Foundation
import UIKit

struct Dicty {
    var title: String
    var icon: UIImage
    var words: [String]?

    init(title: String, icon: UIImage?, words: [String]?) {
        self.title = title
        self.icon = icon!
        self.words = words
    }
}

struct DictysCategory {
    var title: String
    var dictys = [Dicty]()
}

extension DictysCategory {
    static var tempDictys: [DictysCategory] {
        return [
            DictysCategory(title: "General dictys", dictys: [
                Dicty(title: "English",
                      icon: #imageLiteral(resourceName: "English"),
                      words: ["Apple", "Insert"]),
                Dicty(title: "German",
                      icon: #imageLiteral(resourceName: "German"),
                      words: ["Naturwissenshaft", "Hoff"])
            ]),
            DictysCategory(title: "Your dictys", dictys: [
                Dicty(title: "The Foghorn",
                      icon: #imageLiteral(resourceName: "BookIcon"),
                      words: ["Fog", "Horn"]),
                Dicty(title: "National Geographic",
                      icon: #imageLiteral(resourceName: "NewspaperIcon"),
                      words: ["news", "paper"])
            ])
        ]
    }
}

extension Dicty {
    static var tempPersonalDictys: [Dicty] {
        return [
            Dicty(title: "The Foghorn", icon: #imageLiteral(resourceName: "BookIcon"), words: ["None"]),
            Dicty(title: "The National Geographic", icon: #imageLiteral(resourceName: "NewspaperIcon"), words: ["None"])
        ]
    }

    static var tempCommonDictys: [Dicty] {
        return [
            Dicty(title: "Book", icon: #imageLiteral(resourceName: "BookIcon"), words: nil),
            Dicty(title: "Newspaper", icon: #imageLiteral(resourceName: "NewspaperIcon"), words: nil),
            Dicty(title: "Person", icon: #imageLiteral(resourceName: "ProfileIcon"), words: nil),
            Dicty(title: "Worldwide", icon: #imageLiteral(resourceName: "GlobeIcon"), words: nil)
        ]
    }
}
