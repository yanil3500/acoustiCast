//
//  ViewController.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlFor : String?=nil
        iTunes.shared.getPodcasts { (podcasts) in
            print("Number of podcasts: \(podcasts?.count)")
            if let podcastOne = podcasts?[1] {
                RSS.shared.rssFeed = podcastOne.podcastFeed
                RSS.shared.getEpisodes(completion: { (episodes) in
                    if let ep = episodes?.first {
                        urlFor = ep.audiolink
//                        self.avPlayer(urlFrom: urlFor)
                    }
                })
            }
        }
        
        let urlNew = URL(string: "http://feeds.soundcloud.com/stream/316747147-comedybangbang-481-thomas-middleditch-kumail-nanjiani-martin-starr.mp3")
        UIApplication.shared.open(urlNew!)
    }
    
    //http://feeds.soundcloud.com/stream/316747147-comedybangbang-481-thomas-middleditch-kumail-nanjiani-martin-starr.mp3
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        guard let path = Bundle.main.path(forResource: "podcast-one", ofType: "mp3") else { print("Audio not found"); return }
//        
//        let url = URL(string: "https://play.publicradio.org/itunes/d/podcast/nflw/2017/04/08/nflw_20170408_64.mp3")
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//                let controller = AVPlayerViewController()
//                controller.player = player
//                self.present(controller, animated: true) { 
//                    player.play()
//        }
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func avPlayer (urlFrom: String){
        

        
    }
    
    


}

