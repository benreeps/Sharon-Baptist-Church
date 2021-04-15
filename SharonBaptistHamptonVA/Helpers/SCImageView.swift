//
//  UIViewExtensions.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/15/21.
//

import Foundation
import UIKit
import TinyConstraints

class SCImageView: UIView {
    
    var radius:CGFloat = 10
    var cornerRadius:CGFloat = 10
    
    init(_ imageView: UIImageView, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = false
        
        addSubview(imageView)
        imageView.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
