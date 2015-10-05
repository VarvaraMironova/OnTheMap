//
//  ShakeViewExtensions.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 10/5/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    private func shakeView(offset: CGFloat) {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.duration = 0.05
        animation.repeatCount = 6
        animation.autoreverses = true
        animation.fromValue = center.x - offset
        animation.toValue = center.x + offset
        
        layer.addAnimation(animation, forKey: "position.x")
    }
    
    func shake() {
        shakeView(7.0)
    }
    
}
