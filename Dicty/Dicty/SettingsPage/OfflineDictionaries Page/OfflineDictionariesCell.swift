//
//  OfflineDictionariesCell.swift
//  Dicty
//
//  Created by Егор Бедов on 16/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class OfflineDictionariesCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellIcon: UIImageView!
    
    func setCell(title: String) {
        cellLabel.text = title
        cellIcon.image = UIImage(named: "LoadingIcon")
        cellIcon.alpha = 0.0
    }
    
    func iconAppear() {
        cellIcon.rotate(duration: 1)
        UIView.animate(withDuration: 0.5, animations: {
            self.cellIcon.alpha = 1.0
        })
        UIView.animate(withDuration: 0.1, delay: 2, animations: {
            self.cellIcon.alpha = 0.0
//            self.accessoryType = .checkmark
        })
//        cellIcon.stopRotating()
    }
    
    // https://developer.apple.com/documentation/uikit/uiactivityindicatorview
    // https://www.youtube.com/watch?v=_EZINiWExLI
}

/// Rotation animation
extension UIImageView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIImageView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIImageView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIImageView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIImageView.kRotationAnimationKey)
        }
    }
}




/// Some custom animations
extension UIImageView {
    func rotate() {
        let rotate = CASpringAnimation(keyPath: "transform.rotation.z")
        rotate.toValue = 2
        rotate.duration = 2
        
        layer.add(rotate, forKey: nil)
    }
    func fade_out() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 0.5
        animation.fromValue = 0
        animation.toValue = 1
    }
    func fade_in() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 0.5
        animation.fromValue = 1
        animation.toValue = 0
    }
}

