//
//  SettingsCell.swift
//  Dicty
//
//  Created by Егор Бедов on 15/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    @IBOutlet weak var settingIcon: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    
    func setSettingCell(image: UIImage, title: String) {
        settingIcon.image = image
        settingIcon.setImageColor(color: UIColor.green)
        settingLabel.text = title
    }
}

/// Prepare icon for imageView
func resizeImageWithAspect(image: UIImage, scaledToMaxWidth width: CGFloat, maxHeight height: CGFloat) -> UIImage? {
    let oldWidth = image.size.width
    let oldHeight = image.size.height

    let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight

    let newHeight = oldHeight * scaleFactor
    let newWidth = oldWidth * scaleFactor
    let newSize = CGSize(width: newWidth, height: newHeight)

    UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)

    image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
