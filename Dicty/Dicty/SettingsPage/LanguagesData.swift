//
//  Copyright © 2020 Dictys. All rights reserved.
//

enum Languages: String {
  case english  = "🇬🇧 English"
  case russian  = "🇷🇺 Русский"
  case german   = "🇩🇪 Deutsch"
  case spanish  = "🇪🇸 Española"
  case chinese  = "🇨🇳 中文"
  case japanese = "🇯🇵 日本語"
  case ukranian = "🇺🇦 Український"

  static var supportedLanguages: [Languages] {
    return [.english,
            .russian,
            .german,
            .spanish,
            .chinese,
            .japanese,
            .ukranian]
  }
}
