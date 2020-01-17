//
//  OfflineDictionariesData.swift
//  Dicty
//
//  Created by Егор Бедов on 15/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import Foundation

enum OfflineDictionaries: String {
    case English = "English"
    case German  = "German"
    case Spanish = "Spanish"
    
    static var availableDictionaries: [OfflineDictionaries] {
        return [.English,
                .German,
                .Spanish]
    }
}
