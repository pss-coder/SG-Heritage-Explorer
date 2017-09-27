//
//  PlaceCell.swift
//  SG Heritage Explorer
//
//  Created by Project on 27/9/17.
//  Copyright © 2017 PawandeepSingh. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    
    @IBOutlet weak var locationplace: UILabel!
    
    @IBOutlet weak var latvalue: UILabel!

    @IBOutlet weak var longvalue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
