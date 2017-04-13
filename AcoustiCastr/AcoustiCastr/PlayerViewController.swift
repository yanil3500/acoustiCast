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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: "http://feeds.soundcloud.com/stream/316747147-comedybangbang-481-thomas-middleditch-kumail-nanjiani-martin-starr.mp3")
        let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
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
