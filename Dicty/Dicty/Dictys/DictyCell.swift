//
//  DictyCell.swift
//  Dicty
//
//  Created by Егор Бедов on 17/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class DictyCell: UITableViewCell {

    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var celllabel: UILabel!
    
    func customizeCell(icon: UIImage, title: String) {
        cellIcon.image = icon
        celllabel.text = title
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
//        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
    }
    
    func fillIcon() {
        cellIcon.tintColor = UIColor.blue
    }

}
