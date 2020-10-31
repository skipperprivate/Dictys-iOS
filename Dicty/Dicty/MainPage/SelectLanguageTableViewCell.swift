//
//  SelectLanguageTableViewCell.swift
//  Dicty
//
//  Created by a.chetverov on 31.10.2020.
//  Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class SelectLanguageTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var detailText = ""
}
