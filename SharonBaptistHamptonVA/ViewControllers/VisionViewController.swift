//
//  VisionViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/19/21.
//

import UIKit

class VisionViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
