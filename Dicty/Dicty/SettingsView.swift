//
//  SettingsView.swift
//  Dicty
//
//  Created by Егор Бедов on 12/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var settings = Settings.allSettings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].fields.count
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let setting = settings[indexPath.section].fields[indexPath.row]
        
        cell.imageView?.image = resizeImageWithAspect(image: setting.icon!, scaledToMaxWidth: 30, maxHeight: 30)
        cell.imageView?.tintColor = UIColor.green   // TODO: Doesn't respect that
        cell.textLabel?.text = setting.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section].title
    }
}
