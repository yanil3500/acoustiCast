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
        
//        let urlstring = "http://feeds.soundcloud.com/stream/316747147-comedybangbang-481-thomas-middleditch-kumail-nanjiani-martin-starr.mp3"
//        
//        let controller = AVPlayerViewController()
//        guard let url = URL(string: urlstring) else { print("Failed to create URL"); return }
//        let player = AVPlayer(url: url)
//        controller.player = player
//        self.present(controller, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: "http://feeds.soundcloud.com/stream/316747147-comedybangbang-481-thomas-middleditch-kumail-nanjiani-martin-starr.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
        
        playButton = UIButton(type: UIButtonType.system) as UIButton
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        playButton!.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
        playButton!.backgroundColor = UIColor.lightGray
        playButton!.setTitle("Play", for: UIControlState.normal)
        playButton!.tintColor = UIColor.black
        //playButton!.addTarget(self, action: Selector("playButtonTapped:"), for: .touchUpInside)
        playButton!.addTarget(self, action: #selector(ViewController.playButtonTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(playButton!)
        
        
        // Add playback slider
        
        let playbackSlider = UISlider(frame:CGRect(x:10, y:300, width:300, height:20))
        playbackSlider.minimumValue = 0
        
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        playbackSlider.tintColor = UIColor.green
        
        playbackSlider.addTarget(self, action: #selector(ViewController.playbackSliderValueChanged(_:)), for: .valueChanged)
        // playbackSlider.addTarget(self, action: "playbackSliderValueChanged:", forControlEvents: .ValueChanged)
        self.view.addSubview(playbackSlider)
        
    }
    
    
    
    func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    
    func playButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Pause", for: UIControlState.normal)
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Play", for: UIControlState.normal)
        }
    }
    
    
    
    
    
//    func downloadFileFromURL(url: URL){
//        weak var weakSelf = self
//        var downloadTask: URLSessionDownloadTask
//        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (outputURL, response, error) in
//            if error != nil {
//                print(error.debugDescription)
//                return
//            }
//            if let outputURL = outputURL {
//                //TODO: Move this code to play button pressed
//                weakSelf?.play(url: outputURL)
//            } else {
//                print("no output url")
//            }
//        })
//        
//        downloadTask.resume()
//        
//    }
//    
//    func play(url: URL) {
//        print("playing \(url)")
//        
//        do {
//            self.player = try AVAudioPlayer(contentsOf: url)
//            
//            player.volume = 1.0
//            player.play()
//        } catch let error as NSError {
//            //self.player = nil
//            print(error.localizedDescription)
//        } catch {
//            print("AVAudioPlayer init failed")
//        }
//        
//    }


}

