//
//  MainPageDictyCell.swift
//  Dicty
//
//  Created by Егор Бедов on 25/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class MainPageDictyCell: UICollectionViewCell {
    @IBOutlet var cellIcon: UIImageView!
    @IBOutlet var cellLabel: UILabel!

    func customizeCell(icon: UIImage, title: String) {
        cellIcon.image = icon
        cellLabel.text = title

        cellLabel.tintColor = UIColor.white
        cellLabel.backgroundColor = UIColor.orange

        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
    }
}
