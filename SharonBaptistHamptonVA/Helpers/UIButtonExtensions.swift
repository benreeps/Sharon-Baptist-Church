//
//  UIButtonExtensions.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 3/25/21.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.4
    pulse.fromValue = 0.98
    pulse.toValue = 1.0
    pulse.autoreverses = true
    pulse.repeatCount = 1
    pulse.initialVelocity = 0.5
    pulse.damping = 1.0
    layer.add(pulse, forKey: nil)
    }
        
}


