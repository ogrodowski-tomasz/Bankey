//
//  SkeletonLoadable.swift
//  Bankey
//
//  Created by Tomasz Ogrodowski on 13/12/2022.
//

import Foundation
import UIKit

protocol SkeletonLoadable { }

extension SkeletonLoadable {
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.gradientLightGray.cgColor
        anim1.toValue = UIColor.gradientDarkGray.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0
        
        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientDarkGray.cgColor
        anim2.toValue = UIColor.gradientLightGray.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration
        
        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false
        
        if let previousGroup = previousGroup {
            // Offset groups by 0.33 seconds for effect
            group.beginTime = previousGroup.beginTime + 0.33
        }
        
        return group
    }
    
}

extension UIColor {
    
    static var gradientLightGray: UIColor {
        return UIColor(red: 239/255, green: 241/255, blue: 241/255, alpha: 1)
    }
    
    static var gradientDarkGray: UIColor {
        return UIColor(red: 201/255, green: 201/255, blue: 201/255, alpha: 1)
    }
    
}
