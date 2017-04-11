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
        
        iTunes.shared.getPodcasts { (podcasts) in
            if let allPodcasts = podcasts {
                if let podcastOne = allPodcasts.first {
                    OperationQueue.main.addOperation {
                        
                    }
                }
            }
        }
        let controller = AVPlayerViewController()
        let url = URL(string: "https://traffic.libsyn.com/secure/wtfpod/WTF_-_EPISODE_752_RITCH_SHYDNER.mp3?dest-id=14434")
        let player = AVPlayer(url: url!)
        
        controller.player = player
        
        self.present(controller, animated: true, completion: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

