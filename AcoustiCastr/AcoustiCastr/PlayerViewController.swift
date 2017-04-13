//
//  PlayerViewController.swift
//  AcoustiCastr
//
//  Created by David Porter on 4/12/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: UIViewController {
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var sliderBar: UISlider!
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var examplePodcast : Episode?
    var podcastEpUrl : String = ""
    var updater : CADisplayLink! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        iTunes.shared.getSearchText(searchRequest: ["wtf"])
        iTunes.shared.getPodcasts(completion: { (podcasts) in
            guard let pod = podcasts?.first else { print("Failure to get podcast"); return }
            UIImage.fetchImageWith(pod.podcastArt as! String, callback: { (image) in
                guard let podArt = image else { print("Failed to get image");return }
                pod.podcastArt = podArt
                self.artworkImage.image = podArt
            })
            RSS.shared.rssFeed = pod.podcastFeed
            RSS.shared.getEpisodes(completion: { (episodes) in
                guard let epOne = episodes?.first else { print("failed"); return }
                self.examplePodcast = epOne
                guard let urls = self.examplePodcast?.audiolink else { print("failed again"); return }
                print("Inside of closure: \(urls)")
                self.podcastEpUrl = urls
            })
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let url = URL(string: "https://traffic.libsyn.com/secure/wtfpod/WTF_-_EPISODE_801_ANNE_HATHAWAY.mp3?dest-id=14434" ) else { print("failed to get episode link") ;return}
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)

        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)

        self.sliderBar.minimumValue = 0
        self.sliderBar.maximumValue = Float(seconds)
        self.sliderBar.isContinuous = true
        self.sliderBar.addTarget(self, action: #selector(PlayerViewController.sliderChanges(_:)), for: .valueChanged)
        
        

    }
    
    
    
    func sliderChanges(_ sender: UISlider) {
        print("Inside of playbackSliderChanges")
        let secondsFromSlider : Int64 = Int64(sender.value)
        let targetTime:CMTime = CMTimeMake(secondsFromSlider, 1)
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rewind(_ sender: Any) {
        
    }
    @IBAction func fastForward(_ sender: Any) {
        
    }
    @IBAction func playButton(_ sender: Any) {
        if player?.rate == 0 {
            player!.play()
            (sender as! UIButton).setTitle("Pause", for: UIControlState.normal)
        } else {
            player!.pause()
            (sender as! UIButton).setTitle("Play", for: UIControlState.normal)
        }
    }
    

}
