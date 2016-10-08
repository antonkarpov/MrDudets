//
//  MDMusicStudioCell.swift
//  MrDudets
//
//  Created by RomanPanichkin on 08/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit

enum MDSoundRecordingState {
    case MDSoundRecordingActive
    case MDSoundRecoringInactive
}

enum MDSoundPlayingState {
    case MDSoundPlayingReadyToPlay
    case MDSoundPlayingNotReadyToPlay
    case MDSoundPlayingActive
}

enum MDSoundLoopState {
    case MDSoundLoopReadyToLoop
    case MDSoundLoopNotReadyToLoop
    case MDSoundLoopActive
}

enum MDMusicCellState {
    case MDMusicCellStateActive
    case MDMusicCellStateInactive
}

class MDMusicStudioCell: UICollectionViewCell {
    
    // MARK: - Variables & outlets
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var loopButton: UIButton!
    @IBOutlet var recordingLabel: UILabel!
    @IBOutlet var durationLabel: MDDurationLabel!
    
    let redColorHex =        "#EB5757"
    let orangeColorHex =     "#F2994A"
    let yellowColorHex =     "#F2C94C"
    let greenColorHex =      "#219653"
    let lightBlueColorHex =  "#56CCF2"
    let blueColorHex =       "#2D9CDB"
    let silverTreeColorHex = "#6FCF97"
    let eucaliptusColorHex = "#27AE60"
    
    // MARK: - Cell configuration
    
    func configurateCell(indexPath: NSIndexPath) {
        self.backgroundColor = self.cellColor(indexPath.row)
        self.recordingLabel.hidden = true
    }
    
    func cellColor(indexPathRow: Int) -> UIColor {
        let colorsDictionary = [0: redColorHex,
                                1: orangeColorHex,
                                2: yellowColorHex,
                                3: greenColorHex,
                                4: lightBlueColorHex,
                                5: blueColorHex,
                                6: silverTreeColorHex,
                                7: eucaliptusColorHex]
        
        return UIColor.init(hexString: colorsDictionary[indexPathRow]!)
    }
    
    //MARK: - Cell states
    
    func updateRecordButton(state: MDSoundRecordingState) {
        switch state {
        case .MDSoundRecordingActive:
            recordingLabel.hidden = false
            playButton.hidden = true
            loopButton.hidden = true
            durationLabel.startTimer()
            break
            
        case .MDSoundRecoringInactive:
            recordingLabel.hidden = true
            playButton.hidden = false
            loopButton.hidden = false
            durationLabel.stopTimer()
            break
        }

    }
    
    func updatePlayButton(state: MDSoundPlayingState) {
        switch state {
        case .MDSoundPlayingReadyToPlay:
            playButton.hidden = false
            playButton.setImage(UIImage.init(named: "play_button_active"), forState: UIControlState.Normal)
            break
        
        case .MDSoundPlayingNotReadyToPlay:
            playButton.hidden = false
            playButton.setImage(UIImage.init(named: "play_button_inactive"), forState: UIControlState.Normal)
            break
            
        case .MDSoundPlayingActive:
            recordingLabel.hidden = false
            recordButton.hidden = true
            loopButton.hidden = false
            playButton.setImage(UIImage.init(named: "stop_button"), forState: UIControlState.Normal)
            durationLabel.startTimer()
            break
        }
    }
    
    func updateLoopButton(state: MDSoundLoopState) {
        switch state {
        case .MDSoundLoopReadyToLoop:
            loopButton.hidden = false
            loopButton.setImage(UIImage.init(named: "loop_button_active_off"), forState: UIControlState.Normal)
            break
            
        case .MDSoundLoopNotReadyToLoop:
            loopButton.hidden = false
            loopButton.setImage(UIImage.init(named: "loop_button_inactive"), forState: UIControlState.Normal)
            break
            
        case .MDSoundLoopActive:
            recordButton.hidden = true
            playButton.hidden = true
            loopButton.hidden = false
            loopButton.setImage(UIImage.init(named: "loop_button_active_on"), forState: UIControlState.Normal)
            break
        }
    }
}




