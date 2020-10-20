//  Copyright © 2020 Dicty

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
                       callback: @escaping (String) -> Void) {
    let translateRequest = AWSTranslateTranslateTextRequest()
    translateRequest?.sourceLanguageCode = sourceLang.rawValue
    translateRequest?.targetLanguageCode = targetLang.rawValue
    translateRequest?.text = phrase
    
    let translateCallback: (AWSTranslateTranslateTextResponse?, Error?) -> Void = { response, error in
      guard let response = response else {
        if let error = error {
          print("Got error \(error)")
        } else {
          print("Get undefined error")
        }
        return
      }
      if let translatedText = response.translatedText {
        DispatchQueue.main.async {
          callback(translatedText)
        }
      } else {
        print("Translated text is nil")
      }
    }

    translateClient.translateText(translateRequest!, completionHandler: translateCallback)
  }
}
