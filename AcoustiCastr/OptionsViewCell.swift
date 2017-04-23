//
//  OptionsViewCell.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/23/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class OptionsViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var optionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
