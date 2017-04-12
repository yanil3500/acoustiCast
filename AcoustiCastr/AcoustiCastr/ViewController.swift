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
import SafariServices


class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var childViewForSafari: UIView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("button works!")
        func presentSafariViewControllerWith(urlString: String) {
            guard let url = URL(string: urlString) else {  print("This failed.");return}
            
            let safariController = SFSafariViewController(url: url)
            self.childViewForSafari.frame = 
            self.present(safariController, animated: true, completion: nil)
        }
        iTunes.shared.getPodcasts { (podcasts) in
            if let allPodcasts = podcasts {
                guard let onePodcast = allPodcasts.first else { print("This failed."); return }
                RSS.shared.rssFeed = onePodcast.podcastFeed
                RSS.shared.getEpisodes(completion: { (episodes) in
                    if let allEpisodes = episodes {
                        presentSafariViewControllerWith(urlString: (allEpisodes[6].audiolink))
                    } else {
                        print("RSS failed.")
                    }
                })
            } else {
                print("iTunes failed.")
            }
        }
    }
    


}

