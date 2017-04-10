//
//  Podcast.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class Podcast {
    let artistName : String
    let collectionName : String
    let genre : String
    let podcastFeed : URL
    let podcastArt : URL
    
    init?(json: [String: Any] ) {
        if let artistName = json["artistName"] as? String, let collectionName = json["collectioName"] as? String, let genre = json["primaryGenreName"] as? String, let podcastFeed = json["feedUrl"] as? URL, let podcastArt = json["artworkUrl600"] as? URL {
            self.artistName = artistName
            self.collectionName = collectionName
            self.genre = genre
            self.podcastFeed = podcastFeed
            self.podcastArt = podcastArt
        } else {
            return nil
        }
    }
}
