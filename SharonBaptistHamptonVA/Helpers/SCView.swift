//
//  SCView.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/15/21.
//

import UIKit

class SCView: UIView {

   
    
    init(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

