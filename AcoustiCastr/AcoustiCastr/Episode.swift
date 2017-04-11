//
//  Episodes.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class Episode {
    var title: String?
    var description: String?
    var podcastAudio: String?
    var duration: String?
    var pubDate: String?
    
    init(title: String, description: String, podcastAudio: String, duration: String, pubDate: String) {
        self.title = title
        self.description = description
        self.podcastAudio = podcastAudio
        self.duration = duration
        self.pubDate = pubDate
    }
}

