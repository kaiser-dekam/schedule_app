//
//  ProjectViewCell.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 2/24/19.
//  Copyright © 2019 Kaiser De Kam. All rights reserved.
//

import UIKit

class ProjectViewCell: UITableViewCell {

    @IBOutlet weak var project_Label: UILabel!
    @IBOutlet weak var projectPermissionLabel: UILabel!
    
    @IBOutlet weak var project_Image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
