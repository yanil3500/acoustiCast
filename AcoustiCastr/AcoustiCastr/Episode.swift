//
//  Episodes.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class Episode {
    var title: String = ""
    var summary: String = ""
    var audiolink: String = ""
    var duration: String = ""
    var pubDate: String = ""
    
    init (episode: [String : String]) {
        print("Inside of Episode init: \(episode.count)")
        print("Dictionary: \(String(describing: episode["audiolink"]))")
        self.title = episode["title"]!
        self.summary = episode["summary"]!
        if let link = episode["audiolink"] {
            self.audiolink = link
        }
        self.pubDate = episode["pubDate"]!
        self.duration = episode["duration"]!
    }
}

