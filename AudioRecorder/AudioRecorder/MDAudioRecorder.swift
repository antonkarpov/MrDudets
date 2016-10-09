//
//  MDAudioRecorder.swift
//  AudioRecorder
//
//  Created by Anton on 08/10/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import AVFoundation

class MDAudioRecorder {
    
    var avRecorder: AVAudioRecorder!
    
    var recordTimer: NSTimer!
    
    var recording: Bool {
        get {
            return avRecorder.recording
        }
    }
    
    var url: NSURL {
        get {
            return avRecorder.url
        }
    }
    
    init(URL url: NSURL, avDelegate: AVAudioRecorderDelegate? ) throws {
        
        let recordSettings:[String : AnyObject] = [
            AVFormatIDKey:             Int(kAudioFormatAppleLossless),
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey :      320000,
            AVNumberOfChannelsKey:     2,
            AVSampleRateKey :          44100.0
        ]
        
        do {
            avRecorder = try AVAudioRecorder(URL: url, settings: recordSettings)
            avRecorder.meteringEnabled = true
            avRecorder.delegate = avDelegate
            avRecorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch let error as NSError {
            avRecorder = nil
            print(error.localizedDescription)
        }
    }
    
    func recordWithTimer(timeInterval ti:NSTimeInterval, target aTarget: AnyObject, selector aSelector: Selector) {
        avRecorder.record()
        recordTimer = NSTimer.scheduledTimerWithTimeInterval(ti, target: aTarget, selector: aSelector, userInfo: nil, repeats: true)
    }
    
    func pause() {
        avRecorder.pause()
    }
    
    func stop() {
        avRecorder.stop()
        recordTimer.invalidate()
    }
    
    func deleteRecording() -> Bool {
        return avRecorder.deleteRecording()
    }
    
}