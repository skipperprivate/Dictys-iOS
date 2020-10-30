//
//  MainPageViewModel.swift
//  Dicty
//
//  Created by a.chetverov on 29.10.2020.
//  Copyright © 2020 Dictys. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainPageViewModel {
    private let translator = AWSTranslator()
    private let disposeBag = DisposeBag()

    public let translate: PublishSubject<TranslateModel> = PublishSubject()

// зарефакторить сигнатуру
    func fetchTranslate(phrase: String, sourceLang: TranslatorSupportedLanguage, targetLang: TranslatorSupportedLanguage) {
        translator.translatePhrase(phrase: phrase, sourceLang: sourceLang, targetLang: targetLang, completion: { result in
            switch result {
                case .success(let translate):
                    self.translate.onNext(translate)
                case .failure(let error):
                    print(error)
            }
        })
    }
}
