//
//  Copyright © 2020 Dictys. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainPageViewModel {
    private let translator = AWSTranslator()
    private let disposeBag = DisposeBag()

    let sourceLanguage = BehaviorRelay(value: TranslatorSupportedLanguage.russian)
    let targetLanguage = BehaviorRelay(value: TranslatorSupportedLanguage.english)

    let originalPhrase = BehaviorRelay<String?>(value: "") // fix this
    let translatedPhrase = BehaviorRelay<String?>(value: "")

    init() {
        originalPhrase
            .debounce(.milliseconds(800), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }

                self.translateCurrentPhrase()
            }).disposed(by: disposeBag)

        targetLanguage
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.translateCurrentPhrase()
            }).disposed(by: disposeBag)
    }

    private func translateCurrentPhrase() {
        guard
            let phrase = originalPhrase.value,
            !phrase.isEmpty // fix this
        else {
            return
        }

        translator.translatePhrase(phrase: phrase, sourceLang: sourceLanguage.value, targetLang: targetLanguage.value, completion: { result in
            switch result {
            case .success(let translated):
                self.translatedPhrase.accept(translated)
            case .failure(let error):
                print(error ?? "translate error")
            }
        })
    }
}
