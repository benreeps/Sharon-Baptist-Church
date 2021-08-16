//
//  Ministry.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/12/21.
//

import Foundation
import UIKit

class Ministry {
    
    let title: String
    let image: UIImage
    let url: NSURL
    
    init(title: String, image: UIImage, url: NSURL) {
        
        self.title = title
        self.image = image
        self.url = url
    }
}
