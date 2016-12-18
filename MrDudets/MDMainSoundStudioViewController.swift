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
    case url
    case player
}

class MDMainSoundStudioViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables
    
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
        
        let recordURLs = FileManager.generateURLsForRecords(8)
        for url in recordURLs {
            let item: [MDCellData : AnyObject?] = [
                MDCellData.url      : url as Optional<AnyObject>,
                MDCellData.player   : nil
            ]
            
            dataSource.append(item)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicalCell", for: indexPath) as! MDMusicStudioCell
        
        cell.configurateCell(indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let musicCell = collectionView.cellForItem(at: indexPath) as! MDMusicStudioCell
        loopButtonAction(musicCell.loopButton)
    }
    
    // MARK: Recorder Timer Updates
    
    func updateAudioRecorderMeter(_ timer: Timer) {
        
        let avRecorder = recorder.avRecorder
        if (avRecorder?.isRecording)! {
            let min = Int((avRecorder?.currentTime)! / 60)
            let sec = Int((avRecorder?.currentTime)! / 60)
            _ = String(format: "%02d:%02d", min, sec)
            //statusLabel.text = s
            avRecorder?.updateMeters()
            
            // if you want to draw some graphics...
            //var apc0 = recorder.averagePowerForChannel(0)
            //var peak0 = recorder.peakPowerForChannel(0)
        }
    }
    
    // MARK: - Actions
    
    func setupRecorder(_ sender: UIButton) {
        
        let cell = sender.superview?.superview
        let musicCell = cell as! MDMusicStudioCell
        
        let index = collectionView.indexPath(for: musicCell)?.row
        let url = dataSource[index!][MDCellData.url] as! URL
        
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
    
    @IBAction func recordButtonAction(_ sender: UIButton) {
        
        if let cell = sender.superview?.superview {
            
            let musicCell = cell as! MDMusicStudioCell
            
            if recorder != nil && recorder.recording {
                recorder.stop()
                musicCell.updateCellState(MDCellState.default)
            } else {
                setupRecorder(sender)
                musicCell.updateCellState(MDCellState.recording)
            }
            
        }
        
    }

    
    func play(_ sender: UIButton, loopAudio: Bool) -> Bool {
        
        let cell = sender.superview?.superview
        let musicCell = cell as! MDMusicStudioCell
        
        let index = collectionView.indexPath(for: musicCell)?.row
        let url = dataSource[index!][MDCellData.url] as! URL
        
        if !FileManager.default.fileExists(atPath: url.path) {
            return false
        }
        
        print("playing \(url)")
        
        do {
            
            let player = try MDAudioPlayer(URL: url, avDelegate: self)
            dataSource[index!][MDCellData.player] = player
            player.loopAudio(loopAudio)
            
            return player.play()
            
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
            
            return false
        }
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        
        if let cell = sender.superview?.superview {
            
            let musicCell = cell as! MDMusicStudioCell
            let index = collectionView.indexPath(for: musicCell)?.row
            let player = dataSource[index!][MDCellData.player] as! MDAudioPlayer?
            
            if player != nil && player!.playing {
                player!.stop()
                
                musicCell.updateCellState(MDCellState.default)
            } else {
                if play(sender, loopAudio: false) {
                
                    musicCell.updateCellState(MDCellState.playing)
                    
                }
            }
            
        }
        
    }

    @IBAction func loopButtonAction(_ sender: UIButton) {
        
        if let cell = sender.superview?.superview {
            
            let musicCell = cell as! MDMusicStudioCell
            let index = collectionView.indexPath(for: musicCell)?.row
            let player = dataSource[index!][MDCellData.player] as! MDAudioPlayer?
            
            
            if musicCell.cellState == MDCellState.default {
                if play(sender, loopAudio: true) {
                
                    musicCell.updateCellState(MDCellState.looping)
                    
                }
            } else if musicCell.cellState == MDCellState.playing {
                player?.loopAudio(true)
                
                musicCell.updateCellState(MDCellState.looping)
            } else if musicCell.cellState == MDCellState.looping {
                player!.stop()
                
                musicCell.updateCellState(MDCellState.default)
            }
            
        }
    }
    
}










