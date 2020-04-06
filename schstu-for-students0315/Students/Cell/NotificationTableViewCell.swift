//
//  NotificationTableViewCell.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/18.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var teachernameLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    static let reuseIdentifier = "NotificationTableViewCell"
    static let rowHeight: CGFloat = 80
    
    static var nib: UINib {
        return UINib(nibName: "NotificationTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
