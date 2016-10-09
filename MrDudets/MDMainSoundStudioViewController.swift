//
//  MDMainSoundStudioViewController.swift
//  MrDudets
//
//  Created by RomanPanichkin on 08/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit


class MDMainSoundStudioViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables
    
    var recordingState = MDSoundRecordingState.MDSoundRecoringInactive
    var playingState = MDSoundPlayingState.MDSoundPlayingNotReadyToPlay
    
    @IBOutlet var collectionView: UICollectionView!
    var cellsDataSource: NSArray!
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Actions
    
    @IBAction func recordButtonAction(sender: UIButton) {
        // model code here
        
        let isRecording = true // Put the recorder state here
        
        if let cell = sender.superview?.superview {
            let musicCell = cell as! MDMusicStudioCell
            musicCell.updateRecordButton(isRecording ? MDSoundRecordingState.MDSoundRecordingActive : MDSoundRecordingState.MDSoundRecoringInactive)
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


