//
//  ViewCell.swift
//  BMIapp
//
//  Created by Matin Salehi on 2018-12-13.
//  Copyright © 2018 Matin Salehi. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var Weight: UILabel!
    @IBOutlet weak var BMI: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
