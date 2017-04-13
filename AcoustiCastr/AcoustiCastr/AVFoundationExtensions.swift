//
//  AVFoundationExtensions.swift
//  AcoustiCastr
//
//  Created by David Porter on 4/13/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import AVFoundation

extension AVPlayer {
    func currentProgress() -> Double {
        return currentPlayTime() / totalDuration()
    }
    
    func currentPlayTime() -> Double {
        let time = CMTimeGetSeconds(currentTime())
        return time.isNaN ? 0 : CMTimeGetSeconds(currentTime())
    }
    
    func totalDuration() -> Double {
        
        if let currentItem = currentItem {
            return CMTimeGetSeconds(currentItem.asset.duration)
        }
        
        return 0.0
    }
    
    func isPlaying() -> Bool {
        return rate != 0 && error == nil
    }
}

