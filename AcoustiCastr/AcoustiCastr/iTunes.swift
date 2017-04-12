//
//  iTunes.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

typealias GetPodcastsCompletion = ([Podcast]?) -> Void



class iTunes {
    
    private var session : URLSession
    private var components : URLComponents
    
    static let shared = iTunes()
    
    var searchParameterTwo = "sports"
    
    private init (){
        self.session = URLSession(configuration: .default)
        self.components = URLComponents()
        self.components.scheme = "https"
        self.components.host = "itunes.apple.com"
    }
    
    func getPodcasts(completion: @escaping GetPodcastsCompletion ) {
        
        let queryItemByCreate = URLQueryItem(name: "term", value: searchParameterTwo)
        let queryItemEntity = URLQueryItem(name: "entity", value: "podcast")
        self.components.queryItems = [queryItemByCreate, queryItemEntity]
        self.components.path = "/search"
        
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
                
                
                do {
                    if let rootJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                        let podcastJSON = rootJSON["results"]
                        if let allPodcasts = podcastJSON as? [[String : Any]] {
                            for podcast in allPodcasts {
                                let podcastInst = Podcast(json: podcast)
                                podcasts.append(podcastInst)
                            }
                        }
                    }
                    returnToMain(results: podcasts)
                } catch {
                    print("Some error")
                }
            }
        }.resume()
        
    }
    
}
