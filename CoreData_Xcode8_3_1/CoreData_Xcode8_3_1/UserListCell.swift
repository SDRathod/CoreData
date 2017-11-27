//
//  UserListCell.swift
//  CoreData_Xcode8_3_1
//
//  Created by Samir Rathod on 26/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {

    @IBOutlet weak var imgUserPhoto: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
