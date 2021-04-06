//
//  CustomTableViewCell.swift
//  LabTest2
//
//  Created by Gokul Murugan on 2021-04-06.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var Latitude: UILabel!
    @IBOutlet weak var Longitude: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Time: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
