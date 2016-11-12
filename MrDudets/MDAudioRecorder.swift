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
    
    var recordTimer: Timer!
    
    var recording: Bool {
        get {
            return avRecorder.isRecording
        }
    }
    
    var url: URL {
        get {
            return avRecorder.url
        }
    }
    
    init(URL url: URL, avDelegate: AVAudioRecorderDelegate? ) throws {
        
        let recordSettings:[String : AnyObject] = [
            AVFormatIDKey:             Int(kAudioFormatAppleLossless) as AnyObject,
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue as AnyObject,
            AVEncoderBitRateKey :      320000 as AnyObject,
            AVNumberOfChannelsKey:     2 as AnyObject,
            AVSampleRateKey :          44100.0 as AnyObject
        ]
        
        do {
            avRecorder = try AVAudioRecorder(url: url, settings: recordSettings)
            avRecorder.isMeteringEnabled = true
            avRecorder.delegate = avDelegate
            avRecorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch let error as NSError {
            avRecorder = nil
            print(error.localizedDescription)
        }
    }
    
    func recordWithTimer(timeInterval ti:TimeInterval, target aTarget: AnyObject, selector aSelector: Selector) {
        avRecorder.record()
        recordTimer = Timer.scheduledTimer(timeInterval: ti, target: aTarget, selector: aSelector, userInfo: nil, repeats: true)
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
