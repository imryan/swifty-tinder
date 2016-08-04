//
//  ProfileTableViewCell.swift
//  SwiftyTinder
//
//  Created by Ryan Cohen on 8/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 22
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
