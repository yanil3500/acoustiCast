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
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    var player: AVPlayer!
    var selectedPodcast : Podcast!
    var playerItem: AVPlayerItem?
    var episode : Episode!
    var podcastEpUrl : String = ""
    var updater : CADisplayLink! = nil
    var timer : Timer?
    var interactor: Interactor? = nil
    
    
    @IBAction func handlePanToDismissGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold: Float = 0.5
        // conver y=position to downward pull progress
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        
        let progress = Float(downwardMovementPercent)
        
        guard let interactor = interactor else {
            return
        }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: { 
                self.player.rate = 0
                self.timer?.invalidate()
            })
            break
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(CGFloat(progress))
            break
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
            break
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: episode.audiolink ) else { print("failed to get episode link") ;return}
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        
        self.sliderBar.value = 0
        self.sliderBar.minimumValue = 0
        self.sliderBar.maximumValue = 1
        self.sliderBar.isContinuous = true
        self.sliderBar.addTarget(self, action: #selector(PlayerViewController.sliderChanges(_:)), for: .valueChanged)
        self.episodeName.text = self.episode.title
        self.artworkImage.image = self.selectedPodcast.podcastAlbumArt

        secondsToHoursMinutesSeconds(seconds: Int(player.totalDuration()), withLabel: self.endTimeLabel)
        secondsToHoursMinutesSeconds(seconds: 0, withLabel: self.startTimeLabel)
        
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int, withLabel label: UILabel) {
        let secs = (seconds % 3600) % 60
        let mins = (seconds % 3600) / 60
        let hrs = seconds / 3600
        label.text = String(format: "%2d:%02d:%02d", hrs, mins, secs)
    }

    
    func sliderChanges(_ sender: UISlider) {

        let targetTime = CMTimeMakeWithSeconds(Float64(sliderBar.value * Float(player.totalDuration())), player.currentTime().timescale)
        player!.seek(to: targetTime)
        secondsToHoursMinutesSeconds(seconds: Int(player.currentPlayTime()), withLabel: self.startTimeLabel)
    }
    
    @IBAction func rewind(_ sender: Any) {
        // back 15 secs
        let sec = Float64(sliderBar.value * Float(player.totalDuration())) - 15
        let targetTime = CMTimeMakeWithSeconds(sec, player.currentTime().timescale)
        player!.seek(to: targetTime)
    }
    @IBAction func fastForward(_ sender: Any) {
        let sec = Float64(sliderBar.value * Float(player.totalDuration())) + 15
        let targetTime = CMTimeMakeWithSeconds(sec, player.currentTime().timescale)
        player!.seek(to: targetTime)
    }
    
    @IBAction func playButton(_ sender: Any) {
        if !player.isPlaying() {
            player!.play()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        } else {
            player!.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
            timer?.invalidate()
        }
    }
    
    func updateSlider() {
        sliderBar.value = Float(player.currentProgress())
        secondsToHoursMinutesSeconds(seconds: Int(player.currentPlayTime()), withLabel: self.startTimeLabel)
    }
}

