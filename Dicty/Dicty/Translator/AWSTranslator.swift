//
// Copyright © 2020 Dictys. All rights reserved.
//

import AWSTranslate

class AWSTranslator: Translator {
    let credentialsProvider: AWSStaticCredentialsProvider
    let configuration: AWSServiceConfiguration
    let translateClient: AWSTranslate

    init() {
        self.credentialsProvider = AWSStaticCredentialsProvider(accessKey: AWSCredentials.shared.accessKey,
                                                                secretKey: AWSCredentials.shared.secretKey)
        self.configuration = AWSServiceConfiguration(region: .USEast2, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        self.translateClient = AWSTranslate.default()
    }

    func translatePhrase(phrase: String, sourceLang: TranslatorSupportedLanguage, targetLang: TranslatorSupportedLanguage,
                         completion: @escaping (TranslatorApiResponse) -> Void) {
        let translateRequest = AWSTranslateTranslateTextRequest()
        translateRequest?.sourceLanguageCode = sourceLang.rawValue
        translateRequest?.targetLanguageCode = targetLang.rawValue
        translateRequest?.text = phrase

        let translateCallback: (AWSTranslateTranslateTextResponse?, Error?) -> Void = { response, error in
            guard let response = response else {
                completion(.failure(error))
                return
            }
            completion(.success(.init(original: phrase, originalLang: sourceLang, translated: response.translatedText ?? "" , transatedLang: targetLang)))
            return
        }
        translateClient.translateText(translateRequest!, completionHandler: translateCallback)
    }
}
