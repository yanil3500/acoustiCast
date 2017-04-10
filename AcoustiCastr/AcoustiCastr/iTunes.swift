//
//  iTunes.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

typealias GetPodcastsCompletion = ([Podcast]?) -> ()



class iTunes {
    
    private var session : URLSession
    private var components : URLComponents
    
    static let shared = iTunes()
    
    let searchParameterOne = "marcmaron"
    let searchParameterTwo = "comedy"
    
    private init (){
        self.session = URLSession(configuration: .default)
        self.components = URLComponents()
        self.components.scheme = "https"
        self.components.host = "https://itunes.apple.com/search?entity=podcast"
    }
    
    func getPodcasts(completion: @escaping GetPodcastsCompletion ) {
        
        let queryItem = URLQueryItem(name: "term", value: searchParameterOne)
        let queryItemByCreate = URLQueryItem(name: "term", value: searchParameterTwo)
        self.components.queryItems = [queryItem, queryItemByCreate]
        
        func returnToMain(results: [Podcast]?){
            OperationQueue.main.addOperation {
                completion(results)
            }
        }
        
        guard let url = self.components.url else { returnToMain(results: nil); return }
        
        self.session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("getPodcasts error: \(String(describing: error))")
                returnToMain(results: nil)
                return
            }
            
            if let data = data {
                var podcasts = [Podcast]()
                
                guard let rootJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else { completion(nil); return }
                
                if let json = rootJSON {
                    for podcastJSON in json {
                        if let podcast = Podcast(json: podcastJSON){
                            podcasts.append(podcast)
                        }
                    }
                }
                
                returnToMain(results: podcasts)
            }
        }
        
    }
    
}
