//
//  File.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/9/21.
//

import Foundation
import UIKit

class Leader {
    
    let title: String
    let name: String
    let image: UIImage
    let spouseImage: UIImage
    let description: String
    let leaderSpouseName: String
    
    init(title: String, name: String,description: String, image: UIImage, spouseImage: UIImage, leaderSpouseName: String) {
        self.title = title
        self.name = name
        self.image = image
        self.spouseImage = spouseImage
        self.description = description
        self.leaderSpouseName = leaderSpouseName
    }
}
