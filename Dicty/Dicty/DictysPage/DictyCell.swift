//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class DictyCell: UITableViewCell {
  @IBOutlet var cellIcon: UIImageView!
  @IBOutlet var celllabel: UILabel!

  func customizeCell(icon: UIImage, title: String) {
    cellIcon.image = icon
    celllabel.text = title

    self.layer.cornerRadius = self.frame.height / 2
    self.layer.borderWidth = 0.5
    self.layer.borderColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)

//     Woopdi-woop margin magic
//         https://stackoverflow.com/questions/19640050/custom-uitableviewcell-add-margin-between-each-cell
 //    self.backgroundColor = UIColor.clear
 //    self.contentView.backgroundColor = UIColor.clear

 //    let marginView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: self.bounds.width, height: self.frame.height - 5))
 //        marginView.backgroundColor = UIColor.yellow
 //        self.addSubview(marginView)
 //        self.sendSubviewToBack(marginView)
  }

  func fillIcon() {
    cellIcon.tintColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
  }
}
