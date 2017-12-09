//
//  chatCell.swift
//  Chatter
//
//  Created by Chavane Minto on 12/8/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit

class chatCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
