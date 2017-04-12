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
    
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlstring = "http://feeds.soundcloud.com/stream/316747147-comedybangbang-481-thomas-middleditch-kumail-nanjiani-martin-starr.mp3"
        let url = URL(string: urlstring)
        self.downloadFileFromURL(url: url!)
        
        
    }
    
    func downloadFileFromURL(url: URL){
        weak var weakSelf = self
        var downloadTask: URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (outputURL, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            if let outputURL = outputURL {
                //TODO: Move this code to play button pressed
                weakSelf?.play(url: outputURL)
            } else {
                print("no output url")
            }
        })
        
        downloadTask.resume()
        
    }
    
    func play(url: URL) {
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("button works!")
        
        

        iTunes.shared.getPodcasts { (podcasts) in
            if let allPodcasts = podcasts {
                guard let onePodcast = allPodcasts.first else { print("This failed."); return }
                RSS.shared.rssFeed = onePodcast.podcastFeed
                RSS.shared.getEpisodes(completion: { (episodes) in
                    if let allEpisodes = episodes {
//                        self.presentSafariViewControllerWith(urlString: (allEpisodes[6].audiolink))
                        print(allEpisodes.first?.audiolink)
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

