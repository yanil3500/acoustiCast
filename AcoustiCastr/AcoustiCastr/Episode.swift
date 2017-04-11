//
//  Episodes.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class Episode {
    var title: String
    var description: String
    var podcastAudio: String
    var duration: String
    var pubDate: String
    
    init(title: String, description: String, podcastAudio: String, duration: String, pubDate: String) {
        self.title = title
        print("title: \(self.title)")
        self.description = description
        print("description: \(self.description)")
        self.podcastAudio = podcastAudio
        print("podcast: \(self.podcastAudio)")
        self.duration = duration
        print("Duration: \(self.duration)")
        self.pubDate = pubDate
        print("pubDate: \(self.pubDate)")
    }
}

