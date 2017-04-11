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
    
    init?(episode: [String : String]) {
        if let titleUnwrap = episode["title"], let descriptionUnwrap = episode["podDescription"], let audioUnwrap = episode["audioLink"], let pubDateUnwrap = episode["pubDate"], let durationUnwrap = episode["duration"] {
            self.title = titleUnwrap
            self.description = descriptionUnwrap
            self.podcastAudio = audioUnwrap
            self.pubDate = pubDateUnwrap
            self.duration = durationUnwrap
        } else {
            return nil
        }
    }
}

