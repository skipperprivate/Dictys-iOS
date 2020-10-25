//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class MainPageDictyCell: UICollectionViewCell {
    @IBOutlet var cellIcon: UIImageView!
    @IBOutlet var cellLabel: UILabel!

    func customizeCell(icon: UIImage, title: String) {
        cellIcon.image = icon
        cellLabel.text = title

        cellLabel.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cellLabel.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    }
}
