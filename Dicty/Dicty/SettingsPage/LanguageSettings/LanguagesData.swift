//
//  LanguagesData.swift
//  Dicty
//
//  Created by Егор Бедов on 15/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//
import UIKit

struct LanguageCellModel {
    let imageName: String
    let title: String
}

class LanguageCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        }
    }
    
    func configure(with model: LanguageCellModel) {
        iconImageView.image = UIImage(named: model.imageName)
        titleLabel.text = model.title
    }
}


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

