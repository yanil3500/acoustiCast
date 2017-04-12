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
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlstring = "http://feeds.soundcloud.com/stream/316747147-comedybangbang-481-thomas-middleditch-kumail-nanjiani-martin-starr.mp3"
        
        let controller = AVPlayerViewController()
        guard let url = URL(string: urlstring) else { print("Failed to create URL"); return }
        let player = AVPlayer(url: url)
        controller.player = player
        self.present(controller, animated: true) { 
            controller.player?.play()
        }
        
    }
    
}

