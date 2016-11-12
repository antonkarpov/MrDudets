//
//  MDAudioPlayer.swift
//  AudioRecorder
//
//  Created by Anton on 09/10/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import AVFoundation

class MDAudioPlayer {
    
    var avPlayer: AVAudioPlayer!
    
    var soundTimer: Timer!
    
    var playing: Bool {
        get {
            return avPlayer.isPlaying
        }
    }
    
    init(URL url: URL, avDelegate: AVAudioPlayerDelegate? ) throws {
        
        do {
            
            avPlayer = try AVAudioPlayer(contentsOf: url)
            avPlayer.delegate = avDelegate
            avPlayer.prepareToPlay()
            avPlayer.volume = 1.0
            
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        }
        
    }
    
    func loopAudio(_ loop: Bool) {
        avPlayer.numberOfLoops = loop ? -1 : 0
    }
    
    func play() -> Bool {
        return avPlayer.play()
    }
    
    func stop() {
        avPlayer.stop()
    }
    
}
