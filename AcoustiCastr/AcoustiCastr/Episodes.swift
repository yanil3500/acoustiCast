//
//  Episodes.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit


typealias GetPodcastsCompletion = ([Podcast]) -> ()

class iTunes {
    
    private var session : URLSession
    private var components : URLComponents
    
    static let shared = iTunes()
    
    private init (){
        self.session = URLSession(configuration: .default)
        self.components = URLComponents()
        self.components.scheme = "https"
        self.components.host = "https://itunes.apple.com/search"
    }
    
    func getPodcasts(completion: @escaping GetPodcastsCompletion ) {
        
    }
    
}
