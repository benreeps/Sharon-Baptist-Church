//
//  ViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        model.getVideos()
    }
    

}

