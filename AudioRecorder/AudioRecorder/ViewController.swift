//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Anton on 08/10/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var recordButton1: UIButton!
    
    @IBOutlet weak var stopButton1: UIButton!
    
    @IBOutlet weak var playButton1: UIButton!
    
    
    var players: [MDAudioPlayer]!
    
    var player: MDAudioPlayer!
    
    var recorder: MDAudioRecorder!

    var fileURL: NSURL!
    
    var recordURLs: [NSURL]!
    
    deinit {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setActive(false)
        } catch let error as NSError {
            print("could not make session inactive")
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.players = []
        self.recordURLs = NSFileManager.generateURLsForRecords(2)
        
        requestPermissions()
    }
    
    func requestPermissions() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        // ios 8 and later
        
        if (session.respondsToSelector(#selector(AVAudioSession.requestRecordPermission(_:)))) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    
                    print("Permission to record granted")
                    
                    self.setSessionPlayAndRecord()
                    
                } else {
                    print("Permission to record not granted")
                }
            })
        } else {
            print("requestRecordPermission unrecognized")
        }
    }
    
    func setSessionPlayAndRecord() {
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            
            print("could not set session category")
            print(error.localizedDescription)
        }
        
        do {
            try session.setActive(true)
        } catch let error as NSError {
            
            print("could not make session active")
            print(error.localizedDescription)
        }
        
    }
    
    func setupRecorder(url: NSURL) {
        
        do {
            recorder = try MDAudioRecorder(URL: url, avDelegate: self)
        } catch let error as NSError {
            recorder = nil
            print(error.localizedDescription)
        }
        
    }
    
    func recordWithPermission(setup: Bool, forSender sender: UIButton) {
        
        if setup {
            
            var url = self.recordURLs.first
            if sender == self.recordButton1 {
                url = self.recordURLs.last
            }
            
            self.setupRecorder(url!)
        }
        
        self.recorder.recordWithTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(ViewController.updateAudioRecorderMeter(_:)))
        
    }
    
    func play(url: NSURL) {
        print("playing \(url)")
        
        do {
            
            let player_ = try MDAudioPlayer(URL: url, avDelegate: self)
            player_.play()
            
            players.append(player_)
            
            player_.loopAudio(true)
            
            stopButton.enabled = true
            stopButton1.enabled = true
            
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: Recorder Timer Updates
    
    func updateAudioRecorderMeter(timer: NSTimer) {
        
        let avRecorder = recorder.avRecorder
        if avRecorder.recording {
            let min = Int(avRecorder.currentTime / 60)
            let sec = Int(avRecorder.currentTime / 60)
            let s = String(format: "%02d:%02d", min, sec)
            //statusLabel.text = s
            avRecorder.updateMeters()
            
            // if you want to draw some graphics...
            //var apc0 = recorder.averagePowerForChannel(0)
            //var peak0 = recorder.peakPowerForChannel(0)
        }
    }
    
    
    //MARK: Button Actions
    
    @IBAction func stopButtonTapped(sender: UIButton) {
        print("stop")
        
        recorder?.stop()
        
        if sender == stopButton {
            players.first?.stop()
        } else if sender == stopButton1 {
            players.last?.stop()
        }
        
        recordButton.setTitle("Record", forState: UIControlState())
        recordButton1.setTitle("Record", forState: UIControlState())
        
        
        
        playButton.enabled = true
        playButton1.enabled = true
        
        stopButton.enabled = false
        stopButton1.enabled = false
        
        recordButton.enabled = true
        recordButton1.enabled = true
    }
    
    @IBAction func playButtonTapped(sender: UIButton) {
        
        var url = self.recordURLs.first
        if sender == self.playButton1 {
            url = self.recordURLs.last
        }
        
        play(url!)
    }
    
    @IBAction func recordButtonTapped(sender: UIButton) {
        
        for player_ in players {
            if player_.playing {
                player_.stop()
            }
        }
        
        if recorder == nil {
            print("recording. recorder nil")
            
            sender.setTitle("Pause", forState: UIControlState())
            
            playButton.enabled = false
            playButton1.enabled = false
            
            stopButton.enabled = (sender == recordButton)
            stopButton1.enabled = (sender == recordButton1)
            
            recordWithPermission(true, forSender: sender)
            return
        }
        
        if recorder != nil && recorder.recording {
            print("pausing")
            
            recorder.pause()
            sender.setTitle("Continue", forState: UIControlState())
            
        } else {
            print("recording")
            
            sender.setTitle("Pause", forState: UIControlState())
            playButton.enabled = false
            
            stopButton.enabled = (sender == recordButton)
            stopButton1.enabled = (sender == recordButton1)
            
            recordWithPermission(false, forSender: sender)
        }
        
        
    }
    
}

// MARK: AVAudioRecorderDelegate

extension ViewController : AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder,
                                         successfully flag: Bool) {
        print("finished recording \(flag)")
        stopButton.enabled = false
        stopButton1.enabled = false
        
        playButton.enabled = true
        
        recordButton.setTitle("Record", forState: UIControlState())
        recordButton1.setTitle("Record", forState: UIControlState())
        
        // iOS8 and later
        let alert = UIAlertController(title: "Recorder",
                                      message: "Finished Recording",
                                      preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Keep", style: .Default, handler: {action in
            print("keep was tapped")
            self.recorder = nil
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: {action in
            print("delete was tapped")
            self.recorder.deleteRecording()
        }))
        
        self.presentViewController(alert, animated:true, completion:nil)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: NSError?) {
        
        if let e = error {
            print("\(e.localizedDescription)")
        }
        
    }
    
}

// MARK: AVAudioPlayerDelegate
extension ViewController : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
        
        recordButton.enabled = true
        recordButton1.enabled = true
        
        stopButton.enabled = false
        stopButton1.enabled = false
        
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
        
    }
}






