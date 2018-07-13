//
//  MyViewCell.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 7/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit

class MyViewCell: UITableViewCell {

    @IBOutlet weak var lblFirstRow: UILabel!
    @IBOutlet weak var lblSecondRow: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblStopTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
