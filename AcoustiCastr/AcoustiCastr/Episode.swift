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
        self.title = episode["title"]!
        if let summaryOfPod = episode["summary"]{
            self.summary = summaryOfPod
        }
        if let link = episode["audiolink"] {
            self.audiolink = link
        }
        self.pubDate = episode["pubDate"]!
        self.duration = episode["duration"]!
    }
}

