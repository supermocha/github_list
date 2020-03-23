//
//  ListCell.swift
//  POC
//
//  Created by Cheryl Chen on 2020/3/24.
//  Copyright © 2020 Cheryl Chen. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func config(avatarImage: UIImage, title: String, badge: String?) {
        avatarImageView.image = avatarImage
        titleLabel.text = title
        
        if let badge = badge {
            badgeView.isHidden = false
            badgeLabel.text = badge
        } else {
            badgeView.isHidden = true
        }
    }
}
