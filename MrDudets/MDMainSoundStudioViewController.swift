//
//  MDMainSoundStudioViewController.swift
//  MrDudets
//
//  Created by RomanPanichkin on 08/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit
import AVFoundation

enum MDCellData {
    case URL
    case Player
}

class MDMainSoundStudioViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables
    
    var recordingState = MDSoundRecordingState.MDSoundRecoringInactive
    var playingState = MDSoundPlayingState.MDSoundPlayingNotReadyToPlay
    
    var dataSource: [ [MDCellData: AnyObject?] ]!
    
    var recorder: MDAudioRecorder!
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestPermissions()
        prepareDataSource()
        
    }
    
    func prepareDataSource() {
        self.dataSource = []
        
        let recordURLs = NSFileManager.generateURLsForRecords(8)
        for url in recordURLs {
            let item: [MDCellData : AnyObject?] = [
                MDCellData.URL      : url,
                MDCellData.Player   : nil
            ]
            
            dataSource.append(item)
        }
    }
    
    // MARK: Permissions and Session Setup
    
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
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MusicalCell", forIndexPath: indexPath) as! MDMusicStudioCell
        cell.configurateCell(indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let haveSoundForCell = true // Check if recorded sound already exist
        let musicCell = collectionView.cellForItemAtIndexPath(indexPath) as! MDMusicStudioCell
        if haveSoundForCell {
            loopButtonAction(musicCell.loopButton)
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
    
    // MARK: - Actions
    
    func setupRecorder(sender: UIButton) {
        
        let cell = sender.superview?.superview
        let musicCell = cell as! MDMusicStudioCell
        
        let index = collectionView.indexPathForCell(musicCell)?.row
        let url = dataSource[index!][MDCellData.URL] as! NSURL
        
        do {
            recorder = try MDAudioRecorder(URL: url, avDelegate: self)
            
            self.recorder.recordWithTimer(
                timeInterval: 0.1,
                target: self,
                selector: #selector(MDMainSoundStudioViewController.updateAudioRecorderMeter(_:)))
            
        } catch let error as NSError {
            recorder = nil
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func recordButtonAction(sender: UIButton) {
        
        if let cell = sender.superview?.superview {
            
            if recorder.recording {
                recorder.stop()
            } else {
                setupRecorder(sender)
            }
            
            let musicCell = cell as! MDMusicStudioCell
            musicCell.updateRecordButton(recorder.recording ? MDSoundRecordingState.MDSoundRecordingActive : MDSoundRecordingState.MDSoundRecoringInactive)
        }
        
    }

    @IBAction func playButtonAction(sender: UIButton) {
        // model code here
        
        let haveSoundForCell = true // Check if recorded sound already exist
        let isPlaying = true // Put the player state here
        
        if let cell = sender.superview?.superview {
            let musicCell = cell as! MDMusicStudioCell
            
            if isPlaying {
                musicCell.updatePlayButton(MDSoundPlayingState.MDSoundPlayingActive)
            } else {
                musicCell.updatePlayButton(haveSoundForCell ? MDSoundPlayingState.MDSoundPlayingReadyToPlay : MDSoundPlayingState.MDSoundPlayingNotReadyToPlay)
            }
        }
        
    }

    @IBAction func loopButtonAction(sender: UIButton) {
        // model code here
        
        let haveSoundForCell = true // Check if recorded sound already exist
        let isPlaying = true // Put the player state here
        
        if let cell = sender.superview?.superview {
            let musicalCell = cell as! MDMusicStudioCell
            
            if isPlaying {
                musicalCell.updateLoopButton(MDSoundLoopState.MDSoundLoopActive)
            } else {
                musicalCell.updateLoopButton(haveSoundForCell ? MDSoundLoopState.MDSoundLoopReadyToLoop : MDSoundLoopState.MDSoundLoopNotReadyToLoop)
            }
        }
    }
    
    
}


// MARK: AVAudioRecorderDelegate

extension MDMainSoundStudioViewController : AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder,
                                         successfully flag: Bool) {
        print("finished recording \(flag)")
//        stopButton.enabled = false
//        stopButton1.enabled = false
//        
//        playButton.enabled = true
//        
//        recordButton.setTitle("Record", forState: UIControlState())
//        recordButton1.setTitle("Record", forState: UIControlState())
        
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: NSError?) {
        
        if let e = error {
            print("\(e.localizedDescription)")
        }
        
    }
    
}

// MARK: AVAudioPlayerDelegate
extension MDMainSoundStudioViewController : AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
        
//        recordButton.enabled = true
//        recordButton1.enabled = true
//        
//        stopButton.enabled = false
//        stopButton1.enabled = false
        
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
        
    }
}










