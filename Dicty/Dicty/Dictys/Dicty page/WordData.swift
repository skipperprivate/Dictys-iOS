//
//  WordData.swift
//  Dicty
//
//  Created by Егор Бедов on 19/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import Foundation

struct Word {
    var originalWord: String
    var translatedWord: String
}

struct Letter {
    var letter: String
    var words: [Word]
}

extension Letter {
    static var tempWords: [Letter] {
        return [
            Letter(letter: "A", words: [
                Word(originalWord: "Assign", translatedWord: "Присвоить"),
                Word(originalWord: "Attempt", translatedWord: "Попытка")]),
            Letter(letter: "W", words: [
                Word(originalWord: "Word", translatedWord: "Слово")])]
    }
}
