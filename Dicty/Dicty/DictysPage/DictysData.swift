//
//  DictysData.swift
//  Dicty
//
//  Created by Егор Бедов on 17/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
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
                      icon: UIImage(named: "FlagUK"),
                      words: ["Apple", "Insert"]),
                Dicty(title: "German",
                      icon: UIImage(named: "FlagGermany"),
                      words: ["Naturwissenshaft", "Hoff"])
            ]),
            DictysCategory(title: "Your dictys", dictys: [
                Dicty(title: "The Foghorn",
                      icon: UIImage(named: "BookIcon"),
                      words: ["Fog", "Horn"]),
                Dicty(title: "National Geographic",
                      icon: UIImage(named: "NewspaperIcon"),
                      words: ["news", "paper"])
            ])
        ]
    }
}

extension Dicty {
    static var tempPersonalDictys: [Dicty] {
        return [
        Dicty(title: "The Foghorn", icon: UIImage(named: "BookIcon"), words: ["None"]),
        Dicty(title: "The National Geographic", icon: UIImage(named: "NewspaperIcon"), words: ["None"])]
    }

    static var tempCommonDictys: [Dicty] {
        return [
        Dicty(title: "Book", icon: UIImage(named: "BookIcon"), words: nil),
        Dicty(title: "Newspaper", icon: UIImage(named: "NewspaperIcon"), words: nil),
        Dicty(title: "Person", icon: UIImage(named: "ProfileIcon"), words: nil),
        Dicty(title: "Worldwide", icon: UIImage(named: "GlobeIcon"), words: nil)]
    }
}
