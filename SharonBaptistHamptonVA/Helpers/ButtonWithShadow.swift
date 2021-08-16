//
//  CustomButton.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 3/26/21.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super .init(frame: frame)
        setShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        setShadow()
    }
    
    func setShadow() {
        
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowColor = UIColor.black.cgColor
    }
}
