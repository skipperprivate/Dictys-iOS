//
// Copyright © 2020 Dictys. All rights reserved.
//

import Foundation

struct Word {
    var originalWord: String
    var translatedWord: String

//    init(oWord: String, tWord: String) {
//        self.originalWord = oWord
//        self.translatedWord = tWord
//    }
}

struct Letter {
    var letter: Character
    var words: [Word]
}

extension Letter {
    static var tempWords: [Letter] {
        return [
            Letter(letter: "A", words: [
                Word(originalWord: "Assign", translatedWord: "Присвоить"),
                Word(originalWord: "Attempt", translatedWord: "Попытка")]),
            Letter(letter: "W", words: [
                Word(originalWord: "Word", translatedWord: "Слово")
            ])
        ]
    }
}

func searchFor(_ searchText: String, in array: [Letter]) -> [Word] {
    var result = [Word]()
    for letter in array {
        for word in letter.words {
            if word.originalWord.lowercased().contains(searchText.lowercased())
                || word.translatedWord.lowercased().contains(searchText.lowercased()) {
                result.append(word)
            }
        }
    }
    return result
}
