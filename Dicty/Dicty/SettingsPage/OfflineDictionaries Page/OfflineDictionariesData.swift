//
//  OfflineDictionariesData.swift
//  Dicty
//
//  Created by Егор Бедов on 15/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
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
