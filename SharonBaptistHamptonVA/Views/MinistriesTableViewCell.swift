//
//  MinistriesTableViewCell.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/12/21.
//

import UIKit

class MinistriesTableViewCell: UITableViewCell {

    @IBOutlet weak var ministryImageView: UIImageView!
    @IBOutlet weak var ministryTitleLabel: UILabel!
    
    
    func setMinistry(ministry: Ministry) {
        
        ministryImageView.image = ministry.image
        ministryImageView.maskCircle(anyImage: ministryImageView.image!)
        
        ministryTitleLabel.text = ministry.title
        
    }
}

extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

   self.image = anyImage
  }
}
