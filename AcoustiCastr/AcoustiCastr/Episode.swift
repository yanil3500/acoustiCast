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
    var podDescription : String?
    var summary: String = ""
    var audiolink: String = ""
    var duration: String = ""
    var pubDate: String = ""
    
    init?(episode: [String : String]) {
        self.title = episode["title"]!
        if let summaryOfPod = episode["summary"]{
            self.summary = summaryOfPod
        }
        if let link = episode["audiolink"] {
            self.audiolink = link
        }
        if let date = episode["pubDate"] as? String {
            self.pubDate = date
        }
        
        // If duration is nil, then dont generate the episode, just return nil
        if let duration = episode["duration"] {
            self.duration = duration
        } else {
            return nil
        }
        if let podDescrip = episode["podDescription"] {
            self.podDescription = podDescrip
        } else {
            self.podDescription = nil
        }
        
    }
}

