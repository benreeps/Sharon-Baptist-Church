//
//  HomeViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 3/26/21.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let image: UIImage = UIImage(named: "sharon cropped png3")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(-5.0, for: .default)
        
        
       
    
    }
    
}


