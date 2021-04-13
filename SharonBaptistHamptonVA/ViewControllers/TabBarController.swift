//
//  TabBarController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/13/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    delegate = self
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.restorationIdentifier == "giveViewController" {
            
            if let url = NSURL(string: "https://www.sharonbaptisthamptonva.com/give.html") {
                UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
            }
            return false
        }
        return true 
    }
}
