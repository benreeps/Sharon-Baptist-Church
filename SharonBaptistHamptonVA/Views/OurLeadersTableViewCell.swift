//
//  OurLeadersTableViewCell.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/8/21.
//

import UIKit

class OurLeadersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leaderImageView: UIImageView!
    @IBOutlet weak var leaderNameLabel: UILabel!
    @IBOutlet weak var leaderTitleLabel: UILabel!
    
    func setLeader(leader: Leader) {
        
        leaderImageView.image = leader.image
        leaderNameLabel.text = leader.name
        leaderTitleLabel.text = leader.title
    }
}
