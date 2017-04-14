//
//  DetailPodcastViewCell.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/13/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class DetailPodcastViewCell: UITableViewCell {
    
    var episodelink : String = ""
    @IBOutlet weak var episodeLink: UIButton!
    @IBOutlet weak var episodeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
