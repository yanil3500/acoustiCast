//
//  Podcast.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class Podcast {
    var artistName : String
    var collectionName : String
    var genre : String
    var podcastFeed : String?
    var podcastArtUrl : String
    var podcastAlbumArt : UIImage?
    var podcastSummary : String?
    
    init(json: [String: Any] ) {
            self.artistName = json["artistName"] as! String
        if let collection = json["collectionName"] as? String {
            self.collectionName = collection
        } else {
            self.collectionName = ""
        }
        self.genre = json["primaryGenreName"] as! String
        self.podcastFeed = json["feedUrl"] as? String
        self.podcastArtUrl = json["artworkUrl600"] as! String
        self.podcastSummary = json["summary"] as! String
    }
}
