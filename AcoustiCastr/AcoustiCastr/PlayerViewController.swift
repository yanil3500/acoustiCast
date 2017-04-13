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
    
    @IBOutlet weak var playButton: UIButton!
    var player: AVPlayer!
    var playerItem: AVPlayerItem?
    var examplePodcast : Episode?
    var podcastEpUrl : String = ""
    var updater : CADisplayLink! = nil
    var timer : Timer?

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
        
        guard let url = URL(string: "https://traffic.libsyn.com/secure/wtfpod/WTF_-_EPISODE_801_ANNE_HATHAWAY.mp3?dest-id=14434" ) else { print("failed to get episode link") ;return}
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        
        self.sliderBar.value = 0
        self.sliderBar.minimumValue = 0
        self.sliderBar.maximumValue = 1
        self.sliderBar.isContinuous = true
        self.sliderBar.addTarget(self, action: #selector(PlayerViewController.sliderChanges(_:)), for: .valueChanged)
        
        
        
    }

    
    func sliderChanges(_ sender: UISlider) {

        let targetTime = CMTimeMakeWithSeconds(Float64(sliderBar.value * Float(player.totalDuration())), player.currentTime().timescale)
        player!.seek(to: targetTime)        
    }
    
    
    @IBAction func rewind(_ sender: Any) {
        
    }
    @IBAction func fastForward(_ sender: Any) {
        
    }
    @IBAction func playButton(_ sender: Any) {
        if !player.isPlaying() {
            player!.play()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        } else {
            player!.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
            timer?.invalidate()
        }
    }
    
    func updateSlider() {
        sliderBar.value = Float(player.currentProgress())
    }
    

}
